#Normal Imports
import time
import datetime
import os
import undetected_chromedriver as uc
from fake_useragent import UserAgent

#Selenium imports
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import *
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.common.keys import *
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.chrome.options import Options 
from selenium.webdriver.support.select import Select
from selenium.webdriver.common.alert import *

#Import from other files
from option_lists import Area_Options
from option_lists import Type_Options
from chill import chill
from files import file_path
from selenium_feedback import *

global result_list_rewrite
result_list_rewrite = []

def switchtab_rewrite() -> None:
    """
    Creates a new browser tab and switches to it.
    """
    driver.execute_script("window.open();") 
    new_tab_handle = driver.window_handles[-1]  
    driver.switch_to.window(new_tab_handle) 


def startup_rewrite(headless: bool) -> None:
    """
    Initializes the Chrome browser with optional headless mode.
    
    Args:
        headless (boll): If True, the browser will run in headless mode (without UI).
    
    Returns:
        None
    
    Example:
        startup("y") will start the browser in headless mode.
    """
    global driver
    user_data_dir =file_path("../cookies")



    options = Options()
    browser_executable_path= "/Users/leon/Applications/Google Chrome.app"
    options.add_argument(f"user-agent={UserAgent().random}")
    #options.add_argument("add_experimental_option")
    options.add_argument(f"user-data-dir={user_data_dir}")
    if headless == True:
        options.add_argument("--headless")
    #options.add_experimental_option("detach", True)
    #options.add_experimental_option("excludeSwitches", ["enable-logging"])

    # Initialize undetected_chromedriver
    driver = uc.Chrome(options=options)



def login_rewrite(account: str, password: str,path_value:str) -> None:
    """
    Logs into the Apple Feedback Assistant website using the provided account and password.
    
    Args:
        account (str): The user's account name (email).
        password (str): The user's account password.
        path(str): chatGPT or Apple
    
    Returns:
        None
    
    Example:
        login("Testemail@icloud.com", "neverusepassword1234")
    """

    if path_value == "https://chatgpt.com/":
        driver.get(path_value)
    elif path_value == "https://chatgpt.com/auth/login":
        driver.get(path_value)
        try:
            get_started_button = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located((By.CSS_SELECTOR, '[data-testid="login-button"]')))
            get_started_button.click()
        except:
            print("Failed to find get started Button")
        try:
            apple_field = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located(((By.XPATH, "//img[@src='/assets/apple-logo-vertical-full-bleed-tAoxPOUx.svg']"))))
            apple_field.click()
        except:
            print("could not find apple button")

        #Account
        try:
            account_box = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located((By.ID, "account_name_text_field"))
            )
            account_box.send_keys(account)
            chill(2)
            account_box.send_keys(Keys.RETURN)
            chill(1.5)
            #print("Entered Account Credentials")
        except TimeoutException:
            print("Could not Find Account Box")
            
        #Password
        try:
            password_box = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.ID, "password_text_field"))
        )
            password_box.send_keys(password)
            time.sleep(1)
            account_box.send_keys(Keys.RETURN)
            #print("Entered Password")
        except TimeoutException:
            print("Could not Find Password Box")
        try:
            continue_button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located( (By.CSS_SELECTOR, ".button.button-primary.last.nav-action.pull-right.weight-medium")))
            continue_button.click()
        except:
            print("could not find continue button")

def file_rewrite(content: str) -> None:
    """
    Fill in ChatGPT PRompts
    
    Args:
        content(str): hey chatgpt how are you
       
    
    Returns:
        None
    
    Example:
        fill_chatgpt("hello chatgpt")
    """
    try:
        inputElement = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located((By.ID, "prompt-textarea")))
        string = f"This is a Feedback send to Apple about a Bug or Enhancement Request. Please rewrite the Conent in the txt file. Do not add anything only rephrase. Do not change the meaning. Do only answer with the rephrased content dont give anything else back. Make it sound like another person wrote it. The text you made and the original one should say the same but on should not be able to find out they were made by the same person Do only give back the rewritten text, please add nothing to it that changes the meaning and do not say somehitng like here is the rewrite instead just give the rewrite. Do not give a a list give only text. In the txt file is the content you should rewrite:"
        inputElement.send_keys(string)
        
        Upload_Button = WebDriverWait(driver,10).until(
        expected_conditions.presence_of_element_located((By.CSS_SELECTOR, "input[type='file']")))
        Upload_Button.send_keys(content)
        chill(7)
        inputElement.send_keys(Keys.RETURN)
        chill(10)
    except:
        print("Could not upload file or enter Prompt")
    
    try:
        Answer_Elements = driver.find_elements(By.TAG_NAME, "p")
        Answer_Elements_li = driver.find_elements(By.TAG_NAME, "li")
        chill(5)
        for element in Answer_Elements_li:
            result_list_rewrite.append(element.text)
        for element in Answer_Elements:
            result_list_rewrite.append(element.text)
        
            

    except:
        print("Could not get ChatGPT Answer")

def save_rewrite(output_path):
    with open(output_path, "w") as file:
        for element in result_list_rewrite:
            file.write(element + "\n")
        print(result_list_rewrite)

    



   
    




