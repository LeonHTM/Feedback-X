# Required imports
from selenium_rewrite import startup_rewrite, switchtab_rewrite, login_rewrite, file_rewrite, save_rewrite
from files import file_path
from chill import chill  # Utility to pause the execution for a set amount of time
from files import accounts_read

def rewrite(path_value: str, save_value: str, account_value: str, password_value: str):
    """
    Rewrites feedbacks using a ChatGPT automation script. 
    
    This function reads a text file from the given path, processes its content using ChatGPT, 
    and saves the rewritten content to a specified file.

    Parameters:
        path_value : str
            The file path of the input text file containing feedback to be rewritten.
        save_value : str
            The file path where the rewritten content will be saved.

    Outputs:
        Saves the rewritten content to the specified file path.

    Example:
        rewrite(path_value="../current_fdb/content.txt", save_value="../saves/rewrite.txt")
    """
    # Resolve file paths
    save_value = file_path(save_value)
    path_value = file_path(path_value)

    # Rewrite process
    startup_rewrite(headless=True)  
    switchtab_rewrite()             
    login_rewrite(account="ManweValar1379@icloud.com", password="1Ringtorulethemall", path_value="https://chatgpt.com/")
    file_rewrite(path_value)        
    chill(5)                        
    save_rewrite(save_value)        



rewrite(path_value="../current_fdb/content.txt", save_value="../saves/rewrite.txt",account_value = "Your Mom Gotcha", password_value =  "Your Mom Gotcha 2")
