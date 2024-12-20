import datetime
import os


def file_save(name: str,title: str, content: str, addon: bool, iteration: str,feedback_id: list) -> None:
    """
    Saves content to a file with optional metadata and feedback IDs.

    Args:
        name (str): Name of the file to save. Can be given with or without a suffix.
        title(str): Title of Content to save
        content (str): Content to write to the file.
        addon (bool): If equal to "y", appends the current date and time at the beginning of the file.
        iteration (str): The number of iterations or accounts the action has been performed on.
        feedback_id(list): A list of feedback IDs to be appended to the file.

    Returns:
        None

    Example:
        file_save(str(identify_feedback()), file_read("current_fdb/content.txt"), "y", iteration_value, feedback_id_list)

    Raises:
        OSError: If there is an issue creating or writing to the file.
    """
    if name[-4:] != ".txt":
        name +=  ".txt"
    name = "python/saves/" + name
    if addon == True:
        current_date = datetime.datetime.now().strftime("%Y-%m-%d")  # Format: YYYY-MM-DD
        current_time = datetime.datetime.now().strftime("%H:%M") 
        
       
    try:
        file = open(name,"x")
        file.write(title + "\n")
        file.write(current_date + "\n" + current_time + "\n" + str(iteration)  +  "\n")
        for element in feedback_id:
            file.write(element + ",")
        file.write("\n")
        file.write("Content_Start" + "\n")
        file.write(content)
        file.write("\n" + "Content_Finish")
        
      
        print("Filled Content in File: " + name)
        file.close
    except OSError:
        print("Failed to create file: " + name)
   
def file_read(path: str) -> None:
    """
    Reads content from a file.

    Args:
        path (str): Path to the file to read from.

    Returns:
        str: The content of the file.

    Example:
        content = file_read("saves/content.txt")

    Raises:
        ValueError: If the file is empty.
        FileNotFoundError: If the file does not exist.
    """
    with open(path, "r") as file:
        content = file.read()
        if not content.strip():
            raise ValueError(f"File '{path}' contains no content.")
        return content
    file.close()

def file_clear(name: str) -> None:
    """
    Clears the content of a specified file.

    Args:
        name (str): Path to the file to clear.

    Returns:
        None

    Example:
        file_clear("saves/content.txt")
    """
    file = open(name,"w")
    print("Cleared file: " + name)
    file.close()



def accounts_read(type: str, start: int, end: int, path: str) -> list | tuple[list, list] | str:
    """
    Reads account or password data from a file within a specified range.

    Args:
        type (str): Either "account", "password", "both", or "icloudmail".
        start (int): The starting line number (1-based).
        end (int): The ending line number (inclusive, 1-based).
        path (str): Path to the file.

    Returns:
        list | tuple[list, list]: Depending on the type:
            - "account" or "icloudmail": List of accounts.
            - "password": List of passwords.
            - "both": Tuple containing two lists ([accounts], [passwords]).
            - "unsupported type": If the type is invalid.

    Example:
        For type="both", start=2, end=3, and a file containing:
            {"account": "user1@example.com", "password": "pass1"}
            {"account": "user2@example.com", "password": "pass2"}
            {"account": "user3@example.com", "password": "pass3"}
        Output:
            (["user2@example.com", "user3@example.com"], ["pass2", "pass3"])
    """
    if type not in ["password", "account", "both", "icloudmail"]:
        return "unsupported type"

    if start < 1 or end < start:
        return "Invalid range."

    account_list = []
    password_list = []

    try:
        with open(path, "r") as file:
            for counter, line in enumerate(file, start=1):
                if counter < start:
                    continue  # Skip lines before the start
                if counter > end:
                    break  # Stop reading after the end
                
                try:
                    # Directly evaluate the line content as a Python dictionary
                    line_content = eval(line.strip())
                except (SyntaxError, ValueError):
                    continue  # Skip invalid lines
                
                if type == "both":
                    account_list.append(line_content.get("account"))
                    password_list.append(line_content.get("password"))
                elif type in ["account", "icloudmail"]:
                    account_list.append(line_content.get(type))
                else:  # type == "password"
                    password_list.append(line_content.get("password"))

    except FileNotFoundError:
        return "File not found."
    except Exception as e:
        return f"An error occurred: {str(e)}"

    if type == "both":
        return account_list, password_list
    elif type in ["account", "icloudmail"]:
        return account_list
    else:
        return password_list
    

def file_path( relative_path: str) -> str:
        """
        Returns the absolute path based on the script's location.
        
        Args:
            relative_path (str): The relative path to the file.
            
        Returns:
            str: The absolute path to the file.
        """
        script_dir = os.path.dirname(os.path.abspath(__file__))  
        user_data_dir = os.path.join(script_dir, relative_path)
        user_data_dir = os.path.abspath(user_data_dir)
        return user_data_dir