from read import *
from logic import *
from files import *
import datetime




class main():

    def duplication_cycle(self,iteration_value):
   
        account_list = accounts_read("icloudmail", iteration_value,"accounts/accounts.txt")
        password_list = accounts_read("password", iteration_value, "accounts/accounts.txt")
        try:
            file_read("current_fdb/content.txt")
        except (FileNotFoundError, ValueError) as e:
            print(f"Error: {e}. Exiting duplication cycle.")
            return  

        startup("n")
        for index in range(0, iteration_value):
            try:
                login(account_list[index], password_list[index])
                create_feedback("Unable to use Color Picker when picking color for Lock Screen Clock iOS 18.2 (22C151) ", file_read("current_fdb/content.txt"))
                print("Feedback ID " + str(identify_feedback()))
                detail_feedback("Lock Screen,1,4,1,2")
                if index == (iteration_value -1):
                    file_save(str(identify_feedback()),file_read("current_fdb/content.txt"), "y", iteration_value)
                    #file_clear("current_fdb/content.txt")
                upload_feedback("/Users/leon/Desktop/Feedback-X/current_fdb/recording.mov")
                chill(2)
                finish_feedback("submit")
                logout(1)
                chill(2)
                
            except:
                print("Failed at : " + account_list[index] + " Iteration: " + str(index))
                
            


    def login_cycle(self,iteration_value,chill_value):
        account_list = accounts_read("icloudmail", iteration_value,"accounts/accounts.txt")
        password_list = accounts_read("password", iteration_value,"accounts/accounts.txt")

        startup("n")
        for index in range(0, iteration_value):
            try:
                login(account_list[index], password_list[index])
                chill(chill_value)
                logout(1)
                chill(2)
            except:
                print("Failed at: " + account_list[index])

    

at = main()
at.login_cycle(10,10)





    