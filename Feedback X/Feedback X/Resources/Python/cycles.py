from selenium_feedback import *
from files import *
from error import ErrorListHandler
from chill import chill





class cycles():
    def duplication_cycle(self,start_value: int,iteration_value: int ,submit_value :str,title_value : str,path_value:str,headless_value:bool, upload_value: list[str], topic_value: str,accounts_file_path: str, content_file_path: str, cookies_file_path,savesPath:str) -> None:
        """
        Handles the cycle for duplicating feedback submissions across multiple accounts.

        Args:
            start_value (int): Account to start (index for account list).
            iteration_value (int): How many accounts to process.
            submit_value (str): Action for submitting feedback. Can be "submit", "Save", or "Delete".
            title_value(str): title of Feedback
            path_value(str): path of Feedback
            headless_value(bool): headless 
            upload_value(list[string]): list containing string of files to upload
            topic_value(str): area of Feedback

        Returns:
            None
        """
        print("Started Duplication Cycle" )

        #accounts_file_path = file_path("../accounts/accounts.json")
        #content_file_path = "/Users/leon/Desktop/Feedback-X/python/current_fdb/content.txt"
        id = ""
        final_report: str = ""
        account_list = accounts_read("icloudmail", start_value,iteration_value,accounts_file_path)
        password_list = accounts_read("password", start_value,iteration_value, accounts_file_path)
        feedback_id_list = []
        error = ErrorListHandler(10,iteration_value)
        try:
            file_read(content_file_path)
            error.remove(0,iteration_value)
        except (FileNotFoundError, ValueError) as e:
            
            return  

        startup(headless_value,cookies_file_path=cookies_file_path)
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index], path = "https://feedbackassistant.apple.com/")
                    error.remove(1,1)
                except: 
                     continue
                try:
                    create_feedback(title = title_value, file = file_read(content_file_path), topic = topic_value)
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
                try:
                     id = str(identify_feedback())
                     error.remove(5,1)
                except:
                        pass
                try:
                    if upload_value != None:
                        for element in upload_value:
                            upload_feedback(element)
                        error.remove(6,1)
                    else:
                         error.remove(6,1)
                except:
                     pass
                try:
                    if upload_value == None:
                         #print("No Files to Upload")
                         finish_feedback(kind = submit_value, noFiles = True)
                         error.remove(7,1)
                    else:
                        #print("Uploading Files")   
                        finish_feedback(kind = submit_value, noFiles = False)
                        error.remove(7,1)
                except:
                     pass
                chill(2)
                try:
                    logout(1)
                    error.remove(8,1)
                except:
                    pass
                print("Finished " + str(account_list[index] + " " + str(index + 1) + "/" + str(iteration_value)))
                chill(1)

        if submit_value == "submit" or submit_value =="Submit" or submit_value == "save" or submit_value == "Save":
                    try:
                        file_save(name = id,title = title_value, content = file_read(content_file_path), addon = True,iteration = iteration_value, feedback_id = feedback_id_list, path = path_value, upload = upload_value, savesPath = savesPath)
                        #print("Saved Feedback in File")
                        error.remove(9,iteration_value)
                    except:
                         #print("Failed to Save Feedback in File")
                         pass
        for report_str in error.report():
            print(report_str)
            final_report += report_str + "\n"

        if submit_value == "submit" or submit_value =="Submit" or submit_value == "save" or submit_value == "Save":
             try:
                    file_append(name = id, report = final_report,savesPath=savesPath)
                    #print("Saved Report in File")
             except:
                  print("Couldn't save Report in File")
            


            
                
            
    def test_cycle(self):
         
        startup(headless=True,cookies_file_path="test")
    

    def login_cycle(self,start_value: int, iteration_value: int,chill_value: int,headless_value: bool,accounts_file_path:str,cookies_file_path:str) -> None:
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
        
        #accounts_file_path = file_path("../accounts/accounts.json")
        #Filling Variables
        account_list = accounts_read("icloudmail",start_value, iteration_value,accounts_file_path)
        password_list = accounts_read("password",start_value, iteration_value,accounts_file_path)
        isinCycle = False
        error1 = True
        error2 = True
        startup(headless_value,cookies_file_path=cookies_file_path) 
        for index in range(0, iteration_value):
                try: 
                    login(account_list[index], password_list[index],path="https://feedbackassistant.apple.com/")
                    error1 = False
                except:
                     continue
                try:
                    cookies(wait=chill_value)
                    error2 = False
                except:
                    continue
                
               

        if error1 == True or error2 == True:
             print("Failed " + str(account_list[0]))
             
        
        
    







    
