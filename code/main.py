from read import *
from logic import *
from files import *
import datetime




class main():

    def duplication_cycle(self,start_value: int,iteration_value: int ,submit :str):
        """
        
        Args:
            start_value(int): Account to start
            iteration_value(int): How many accounts to fill
            submit(str): "Submit" or "Submit" or "Delete" or "delete" or "save" or "Save"


        Returns:
            None
        
        """
   
        account_list = accounts_read("icloudmail", start_value,iteration_value,"accounts/accounts.txt")
        password_list = accounts_read("password", start_value,iteration_value, "accounts/accounts.txt")
        feedback_id_list = []
        try:
            file_read("current_fdb/content.txt")
        except (FileNotFoundError, ValueError) as e:
            print(f"Error: {e}. Exiting duplication cycle.")
            return  

        startup("y")
        for index in range(0, iteration_value):
                print(account_list[index])
                login(account_list[index], password_list[index])
                create_feedback("App Library Blur displayed wrong iOS 18.2 (22C151) ", file_read("current_fdb/content.txt"))
                print("Feedback ID " + str(identify_feedback()))
                feedback_id_list.append(str(identify_feedback))
                detail_feedback("Home Screen,1,1")
                if index == (iteration_value -1) and (submit == "submit" or submit =="Submit" or submit == "save" or submit == "Save"):
                    file_save(str(identify_feedback()),file_read("current_fdb/content.txt"), "y", iteration_value,feedback_id_list)
                    #file_clear("current_fdb/content.txt")
                upload_feedback("/Users/leon/Desktop/Feedback-X/current_fdb/Video_01.mov,/Users/leon/Desktop/Feedback-X/current_fdb/Image_01.png")
                finish_feedback(submit)
                chill(5)
                logout(1)
                chill(5)
                print("ITERATION " + str(index))
                
            
                
            


    def login_cycle(self,start_value, iteration_value,chill_value):
        account_list = accounts_read("icloudmail",start_value, iteration_value,"accounts/accounts.txt")
        password_list = accounts_read("password",start_value, iteration_value,"accounts/accounts.txt")
        startup("n")
        for index in range(0, iteration_value):
            #try:
                login(account_list[index], password_list[index])
                chill(chill_value)
                logout(1)
                chill(2)
            #except:
                print("Failed at: " + account_list[index])
        

    

at = main()
at.duplication_cycle(1,2,"save")
#at.login_cycle(1,10,15)





    