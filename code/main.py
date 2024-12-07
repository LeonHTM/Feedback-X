from read import *
from logic import *
from files import *
import datetime




def run(iteration_value : int) -> None:
    """
    Args:
        iteration_value(int); How many times run
    Output:
        None
    Example:
        2
    """    
    account_list = accounts_read("icloudmail", iteration_value)
    password_list = accounts_read("password", iteration_value)

    startup("y")
    for index in range(0, iteration_value):
        login(account_list[index], password_list[index])
        create_feedback("Feedback Title", file_read("current_fdb/content.txt"))
        print("Feedback ID " + str(identify_feedback()))
        detail_feedback("Wallpaper,2,2,2")
        if index == (iteration_value -1):
            file_save(str(identify_feedback()),file_read("current_fdb/content.txt"), "y", iteration_value)
            file_clear("current_fdb/content.txt")
        upload_feedback("/Users/leon/Desktop/Feedback-X/current_fdb/bugs.jpeg,/Users/leon/Desktop/Feedback-X/current_fdb/recording.mp4")
        chill(5)
        finish_feedback("delete")
        logout(1)
        chill(2)



run(1)



    