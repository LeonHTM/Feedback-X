from seleniumcore import *
from files import *
from error import ErrorListHandler
from chill import chill
import time




class main():
    def duplication_cycle(self,start_value: int,iteration_value: int ,submit_value :str,title_value : str,path_value:str,headless_value) -> None:
        """
        Handles the cycle for duplicating feedback submissions across multiple accounts.

        Args:
            start_value (int): Account to start (index for account list).
            iteration_value (int): How many accounts to process.
            submit_value (str): Action for submitting feedback. Can be "submit", "Save", or "Delete".
            title_value(str) title of Feedback
            path_value(str) path of Feedback
            headless_value(str) headless 

        Returns:
            None
        """
        print("Started Duplication Cycle")
        start_time = time.time()
        account_list = accounts_read("icloudmail", start_value,iteration_value,"python/accounts/accounts.txt")
        password_list = accounts_read("password", start_value,iteration_value, "python/accounts/accounts.txt")
        feedback_id_list = []
        error = ErrorListHandler(10)
        
        try:
            file_read("python/current_fdb/content.txt")
        except (FileNotFoundError, ValueError) as e:
            error.add(0,1)
            return  

        startup(headless_value)
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index])
                except:
                     error.add(1,1)
                     continue
                try:
                    create_feedback(title_value, file_read("python/current_fdb/content.txt"))
                except:
                     error.add(2,1)
                try:
                    feedback_id_list.append(str(identify_feedback()))
                except: 
                     error.add(3,1)
                try:
                     detail_feedback(path_value)
                except:
                     error.add(4,1)

                if index == (iteration_value -1) and (submit_value == "submit" or submit_value =="Submit" or submit_value == "save" or submit_value == "Save"):
                    try:
                        file_save(str(identify_feedback()),title_value,file_read("python/current_fdb/content.txt"), "y", iteration_value,feedback_id_list)
                    except:
                         error.add(5,1)
                        #file_clear("current_fdb/content.txt")
                try:
                    upload_feedback("/Users/leon/Desktop/Feedback-X/python/current_fdb/Video_01.mov,/Users/leon/Desktop/Feedback-X/python/current_fdb/Image_01.png")
                except:
                     error.add(6,1)
                try:
                     finish_feedback(submit_value)
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
        print("Runtime: " + str(round(time.time()-start_time))) 
            
                
            


    def login_cycle(self,start_value: int, iteration_value: int,chill_value: int,headless_value: bool) -> None:
        """
        Handles the cycle for logging into multiple accounts, for example to control if the Feedbacks were filed

        Args:
            start_value (int): The starting index for the account list.
            iteration_value (int): The number of accounts to process.
            chill_value (int): The number of seconds to pause (chill) after each login.
            headless_Value (Bool) if True headless

        Returns:
            None
        """

        print("Started Login Cycle")
        start_time = time.time()
        account_list = accounts_read("icloudmail",start_value, iteration_value,"python/accounts/accounts.txt")
        password_list = accounts_read("password",start_value, iteration_value,"python/accounts/accounts.txt")
        error = ErrorListHandler(2)
        startup(headless_value)
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index])
                except:
                     error.add(0,1)
                     continue
                chill(chill_value)
                try:
                    logout(1)
                except:
                    error.add(1,1)
                chill(2)

        for report_str in error.report():
            print(report_str)
        print("Runtime: " + str(round(time.time()-start_time))) 
    

at = main()
#at.duplication_cycle(start_value=1,iteration_value=10,submit="submit",title="Lock Screen Gallery doesn’t load Widgets iOS 18.2 (22C152)",path="Lock Screen,1,3",headless_value=True)
at.login_cycle(start_value=1,iteration_value=20,chill_value=1,headless_value=False)





    