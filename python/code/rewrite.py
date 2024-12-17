from selenium_rewrite import *
from selenium_feedback import *
from files import *
from error import ErrorListHandler
from chill import chill


def rewrite(path_value: str, save_value:str):
    """
    rewrites feedbacks with chatgpt, must be given a txt file

    """
    content_file_path = file_path(path_value)
    startup_rewrite(False)
    switchtab_rewrite()
    login_rewrite("ManweValar1379@icloud.com", "1Ringtorulethemall",path_value="https://chatgpt.com/")
    file_rewrite(content_file_path)
    save_rewrite(save_value)
    chill(5)


    



rewrite(path_value ="../current_fdb/content.txt", save_value = "python/saves/rewrite.txt")