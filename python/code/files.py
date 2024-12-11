import datetime


def file_save(name: str,title: str, content: str, addon: str, iteration: str,feedback_id_list : list) -> None:
    """
    Saves content to a file with optional metadata and feedback IDs.

    Args:
        name (str): Name of the file to save. Can be given with or without a suffix.
        title(str): Title of Content to save
        content (str): Content to write to the file.
        addon (str): If equal to "y", appends the current date and time at the beginning of the file.
        iteration (str): The number of iterations or accounts the action has been performed on.
        feedback_id_list (list): A list of feedback IDs to be appended to the file.

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
    if addon == "y":
        current_stuff = datetime.datetime.now()
        current_stuff = current_stuff.strftime("%Y-%m-%d %H:%M")
        
       
    try:
        file = open(name,"x")
        #print("Created File:" + name)
        file.write(current_stuff + "\n" + str(iteration)  +  "\n")
        for element in feedback_id_list:
            file.write(element + ",")
        file.write("\n")
        file.write(title + "\n")
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
