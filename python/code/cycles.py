from selenium_feedback import *
from files import *
from error import ErrorListHandler
from chill import chill





class cycles():

    def duplication_cycle(self,start_value: int,iteration_value: int ,submit_value :str,title_value : str,path_value:str,headless_value, upload_value: list[str]) -> None:
        """
        Handles the cycle for duplicating feedback submissions across multiple accounts.

        Args:
            start_value (int): Account to start (index for account list).
            iteration_value (int): How many accounts to process.
            submit_value (str): Action for submitting feedback. Can be "submit", "Save", or "Delete".
            title_value(str): title of Feedback
            path_value(str): path of Feedback
            headless_value(str): headless 
            upload_value(list[string]): list containing string of files to upload

        Returns:
            None
        """
        print("Started Duplication Cycle" )
        

        accounts_file_path = file_path("../accounts/accounts.txt")
        content_file_path = file_path("../current_fdb/content.txt")
        
        account_list = accounts_read("icloudmail", start_value,iteration_value,accounts_file_path)
        password_list = accounts_read("password", start_value,iteration_value, accounts_file_path)
        feedback_id_list = []
        error = ErrorListHandler(9,iteration_value)
        isinCycle = False
        try:
            file_read(content_file_path)
            error.remove(0,10)
        except (FileNotFoundError, ValueError) as e:
            
            return  

        startup(headless_value)
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index], path_value = "https://feedbackassistant.apple.com/")
                    error.remove(1,1)
                except: 
                     continue
                try:
                    create_feedback(title_value, file_read(content_file_path))
                    error.remove(2,1)
                except:
                        pass
                try:
                    feedback_id_list.append(str(identify_feedback()))
                    error.remove(3,1)
                except: 
                        pass
                try:
                     detail_feedback(path_value)
                     error.remove(4,1)
                except:
                     pass
                    
                if index == (iteration_value -1) and (submit_value == "submit" or submit_value =="Submit" or submit_value == "save" or submit_value == "Save"):
                    try:
                        file_save(name =str(identify_feedback()),title = title_value, content = file_read(content_file_path), addon = True,iteration = iteration_value, feedback_id = feedback_id_list, path = path_value, upload = upload_value)
                        error.remove(5,10)
                    except:
                         pass
                        #file_clear("current_fdb/content.txt")
                try:
                    for element in upload_value:
                        upload_feedback(element)
                    error.remove(6,1)
                except:
                     pass
                try:
                     finish_feedback(submit_value)
                     error.remove(7,1)
                except:
                     pass
                chill(2)
                try:
                    logout(1)
                    error.remove(8,1)
                except:
                    pass
                if index == 0:
                     isinCycle = True
                chill(1)

        for report_str in error.report():
            print(report_str)
        
            
                
            


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
        
        accounts_file_path = file_path("../accounts/accounts.txt")
        print("Started Login Cycle")
        #Filling Variables
        account_list = accounts_read("icloudmail",start_value, iteration_value,accounts_file_path)
        password_list = accounts_read("password",start_value, iteration_value,accounts_file_path)
        isinCycle = False
        error = ErrorListHandler(2,iteration_value)
        startup(headless_value)
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index],path_value="https://feedbackassistant.apple.com/")
                    error.remove(0,1)
                except:
                     continue
                chill(chill_value)
                try:
                    logout(1)
                    error.remove(1,1)
                except:
                    pass
                if index == 0:
                     isinCycle == True
                chill(1)
               

        for report_str in error.report():
            print(report_str)
        
    







    