import datetime


def file_save(name: str, content: str, addon: str, walks: str) -> None:
    """
    Args:
        name(str): name of file one wants to save with or withouout suffix
        content(str): content of file
        addon(str): If equal to "y": Will add date and time to Beginnig of file
        walks(str): On how many accounts an action has been performed
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
        file.write(current_stuff + " " + str(walks) + "\n" +  "\n" + content)
      
        print("Filled Content in File: " + name)
        file.close
    except OSError:
        print("Failed to create file: " + name)
   
def file_read(file: str) -> None:
    """
    Args:
        file (str) -> File Path 
    Returns:
        None
    Example:
        "saves/content.txt"
    """
    with open(file, "r") as file:
        content = file.read()
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
