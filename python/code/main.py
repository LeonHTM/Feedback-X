from read import *
from logic import *
from files import *
from error import ErrorListHandler
import time




class main():
    def duplication_cycle(self,start_value: int,iteration_value: int ,submit :str,title : str) -> None:
        """
        Handles the cycle for duplicating feedback submissions across multiple accounts.

        Args:
            start_value (int): Account to start (index for account list).
            iteration_value (int): How many accounts to process.
            submit (str): Action for submitting feedback. Can be "submit", "Save", or "Delete".

        Returns:
            None
        """
        start_time = time.time()
        account_list = accounts_read("icloudmail", start_value,iteration_value,"python/accounts/accounts.txt")
        password_list = accounts_read("password", start_value,iteration_value, "python/accounts/accounts.txt")
        feedback_id_list = []
        error = ErrorListHandler(15)
        
        try:
            file_read("python/current_fdb/content.txt")
        except (FileNotFoundError, ValueError) as e:
            error.add(0,1)
            return  

        startup("y")
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index])
                except:
                     error.add(1,1)
                     return
                try:
                    create_feedback(title, file_read("python/current_fdb/content.txt"))
                except:
                     error.add(2,1)
                try:
                    feedback_id_list.append(str(identify_feedback()))
                except: 
                     error.add(3,1)
                try:
                     detail_feedback("Home Screen,1,1")
                except:
                     error.add(4,1)

                if index == (iteration_value -1) and (submit == "submit" or submit =="Submit" or submit == "save" or submit == "Save"):
                    try:
                        file_save(str(identify_feedback()),title,file_read("python/current_fdb/content.txt"), "y", iteration_value,feedback_id_list)
                    except:
                         error.add(5,1)
                        #file_clear("current_fdb/content.txt")
                try:
                    upload_feedback("/Users/leon/Desktop/Feedback-X/python/current_fdb/Video_01.mov,/Users/leon/Desktop/Feedback-X/python/current_fdb/Image_01.png")
                except:
                     error.add(6,1)
                try:
                     finish_feedback(submit)
                except:
                     error.add(7,1)
                chill(2)
                try:
                    logout(1)
                except:
                    error.add(8,1)
                chill(5)
        for report_str in error.report():
            print(report_str)
        print("Runtime: " + str(time.time()-start_time)) 
            
                
            


    def login_cycle(self,start_value: int, iteration_value,chill_value: int) -> None:
        """
        Handles the cycle for logging into multiple accounts, for example to control if the Feedbacks were filed

        Args:
            start_value (int): The starting index for the account list.
            iteration_value (int): The number of accounts to process.
            chill_value (int): The number of seconds to pause (chill) after each login.

        Returns:
            None
        """

        
        start_time = time.time()
        account_list = accounts_read("icloudmail",start_value, iteration_value,"python/accounts/accounts.txt")
        password_list = accounts_read("password",start_value, iteration_value,"python/accounts/accounts.txt")
        error = ErrorListHandler(2)
        startup("y")
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index])
                except:
                     error.add(1,1)
                     return
                chill(chill_value)
                try:
                    logout(1)
                except:
                    error.add(2,1)
                chill(2)

        for report_str in error.report():
            print(report_str)
        print("Runtime: " + str(time.time()-start_time)) 
    

at = main()
#at.duplication_cycle(1,2,"save","App Library Blur displayed wrong iOS 18.2 (22C151)")
at.login_cycle(1,10,1)





    