import datetime
import os


def file_save(name: str,title: str, content: str, addon: bool, iteration: str,feedback_id: list,path : str, upload : list[str]) -> None:
    """
    Saves content to a file with optional metadata and feedback IDs.

    Args:
        name (str): Name of the file to save. Can be given with or without a suffix.
        title(str): Title of Content to save
        content (str): Content to write to the file.
        addon (bool): If equal to true, appends the current date and time at the beginning of the file.
        iteration (str): The number of iterations or accounts the action has been performed on.
        feedback_id(list): A list of feedback IDs to be appended to the file.
        upload(list[str]): A list containg the strings of uploads

    Returns:
        None

    Example:
        THIS EXAMPLE WILL HAVE TO BE REWRITTEN ahha
        file_save(str(identify_feedback()), file_read("current_fdb/content.txt"), True, iteration_value, feedback_id_list)

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
        file.write(path+ "\n")
        for element in upload:
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



import json

def accounts_read(type: str, start: int, end: int, path: str) -> list | tuple[list, list] | str:
    """
    Reads account or password data from a JSON file within a specified range.

    Args:
        type (str): Either "account", "password", "both", or "icloudmail".
        start (int): The starting item number (1-based).
        end (int): The ending item number (inclusive, 1-based).
        path (str): Path to the JSON file.

    Returns:
        list | tuple[list, list]: Depending on the type:
            - "account" or "icloudmail": List of accounts.
            - "password": List of passwords.
            - "both": Tuple containing two lists ([accounts], [passwords]).
            - "unsupported type": If the type is invalid.

    Example:
        For type="both", start=2, end=3, and a JSON file containing:
            [
                {"account": "user1@example.com", "password": "pass1"},
                {"account": "user2@example.com", "password": "pass2"},
                {"account": "user3@example.com", "password": "pass3"}
            ]
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
            data = json.load(file)  # Load the JSON data as a Python list

        # Extract the specified range of data (adjusting for 1-based index)
        sliced_data = data[start - 1:end]

        for entry in sliced_data:
            if type == "both":
                account_list.append(entry.get("account"))
                password_list.append(entry.get("password"))
            elif type in ["account", "icloudmail"]:
                account_list.append(entry.get(type))
            else:  # type == "password"
                password_list.append(entry.get("password"))

    except FileNotFoundError:
        return "File not found."
    except json.JSONDecodeError:
        return "Invalid JSON format."
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