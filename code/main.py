from read import *
from logic import *
from files import *
import datetime




class main():

    def duplication_cycle(self,iteration_value):
   
        account_list = accounts_read("icloudmail", iteration_value)
        password_list = accounts_read("password", iteration_value)

        startup("n")
        for index in range(0, iteration_value):
            login(account_list[index], password_list[index])
            create_feedback("Home Accessories glitch over Navigation Bar in Home App 18.2 (22C150) ", file_read("current_fdb/content.txt"))
            print("Feedback ID " + str(identify_feedback()))
            detail_feedback("Home App & HomeKit / Matter Accessories,1,2,2")
            if index == (iteration_value -1):
                file_save(str(identify_feedback()),file_read("current_fdb/content.txt"), "y", iteration_value)
                file_clear("current_fdb/content.txt")
            upload_feedback("/Users/leon/Desktop/Feedback-X/current_fdb/img.jpg,/Users/leon/Desktop/Feedback-X/current_fdb/recording.mov")
            finish_feedback("submit")
            logout(1)
            chill(2)

    def login_cycle(self,iteration_value,chill_value):
        account_list = accounts_read("icloudmail", iteration_value)
        password_list = accounts_read("password", iteration_value)

        startup("n")
        for index in range(0, iteration_value):
            try:
                login(account_list[index], password_list[index])
                chill(chill_value)
                logout(1)
                chill(2)
            except:
                print("Failed at : " + account_list[index])

    

at = main()
at.duplication_cycle()


    