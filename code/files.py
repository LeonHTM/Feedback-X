import datetime


def file_save(name: str, content: str, addon: str, iteration: str,feedback_id_list : list) -> None:
    """
    Args:
        name(str): name of file one wants to save with or withouout suffix
        content(str): content of file
        addon(str): If equal to "y": Will add date and time to Beginnig of file
        iteration(str): On how many accounts an action has been performed
        feedback_id_list(list) Append list to file
        
    Returns:
        
    Example:
        piis3141.py or piis3141

    """
    if name[-4:] != ".txt":
        name +=  ".txt"
    name = "saves/" + name
    if addon == "y":
        current_stuff = datetime.datetime.now()
        current_stuff = current_stuff.strftime("%Y-%m-%d %H:%M")
        
       
    try:
        file = open(name,"x")
        print("Created File:" + name)
        file.write(current_stuff + " " + str(iteration) + "\n" +  "\n" )
        for element in feedback_id_list:
            file.write(element + "\n")
        file.write("\n")
        file.write("Content" + "\n")
        file.write(content)
        
      
        print("Filled Content in File: " + name)
        file.close
    except OSError:
        print("Failed to create file: " + name)
   
def file_read(path: str) -> None:
    """
    Args:
        file (str) -> File Path 
    Returns:
        None
    Example:
        "saves/content.txt"

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
    Args:
        name(str) -> File Path 
    Returns:
        None
    Example:
        "saves/content.txt"
    """
    file = open(name,"w")
    print("Cleared file: " + name)
    file.close()
