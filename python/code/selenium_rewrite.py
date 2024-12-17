# Normal Imports
import time
import undetected_chromedriver as uc
from fake_useragent import UserAgent

# Selenium imports
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import *
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.common.keys import *

# Import from other files
from chill import chill
from files import file_path

# Global result list for rewritten content
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
        headless (bool): If True, the browser will run in headless mode (without UI).
    
    Returns:
        None
    """
    global driver
    user_data_dir = file_path("../cookies")

    options = webdriver.ChromeOptions()
    browser_executable_path = "/Users/leon/Applications/Google Chrome.app"
    options.add_argument(f"user-agent={UserAgent().random}")
    options.add_argument(f"user-data-dir={user_data_dir}")
    
    if headless:
        options.add_argument("--headless")
        options.add_argument("--disable-blink-features=AutomationControlled")
        options.add_argument("--enable-javascript")
        options.add_argument("--disable-features=EnableAccessibilityObjectModel")
        options.add_argument("--remote-debugging-port=9222") 

    # Initialize undetected_chromedriver
    driver = uc.Chrome(options=options)


def login_rewrite(account: str, password: str, path_value: str) -> None:
    """
    Logs into the website using the provided account and password.
    
    Args:
        account (str): The user's account name (email).
        password (str): The user's account password.
        path_value (str): The URL path for login (either ChatGPT or Apple Feedback).
    
    Returns:
        None
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
            print("Failed to find 'Get Started' Button")
        
        try:
            apple_field = WebDriverWait(driver, 5).until(
                expected_conditions.presence_of_element_located((By.XPATH, "//img[@src='/assets/apple-logo-vertical-full-bleed-tAoxPOUx.svg']")))
            apple_field.click()
        except:
            print("Could not find Apple login button")
        
        # Account input
        try:
            account_box = WebDriverWait(driver, 5).until(
                expected_conditions.presence_of_element_located((By.ID, "account_name_text_field"))
            )
            account_box.send_keys(account)
            chill(2)
            account_box.send_keys(Keys.RETURN)
            chill(1.5)
        except TimeoutException:
            print("Could not find account box")
            
        # Password input
        try:
            password_box = WebDriverWait(driver, 5).until(
                expected_conditions.presence_of_element_located((By.ID, "password_text_field"))
            )
            password_box.send_keys(password)
            time.sleep(1)
            password_box.send_keys(Keys.RETURN)
        except TimeoutException:
            print("Could not find password box")
        
        try:
            continue_button = WebDriverWait(driver, 5).until(
                expected_conditions.presence_of_element_located((By.CSS_SELECTOR, ".button.button-primary.last.nav-action.pull-right.weight-medium")))
            continue_button.click()
        except:
            print("Could not find continue button")


def file_rewrite(content: str) -> None:
    """
    Uploads a file to be processed and sends a feedback prompt for rewriting content.
    
    Args:
        content (str): The path to the file to be uploaded.
    
    Returns:
        None
    """
    try:
        inputElement = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located((By.ID, "prompt-textarea")))
        
        string = "This is a Feedback send to Apple about a Bug or Enhancement Request. Please rewrite the Content in the txt file. Do not add anything only rephrase. Do not change the meaning. Do only answer with the rephrased content dont give anything else back. Make it sound like another person wrote it. The text you made and the original one should say the same but on should not be able to find out they were made by the same person Do only give back the rewritten text, please add nothing to it that changes the meaning and do not say somehitng like here is the rewrite instead just give the rewrite."
        inputElement.send_keys(string)
        
        Upload_Button = WebDriverWait(driver, 10).until(
            expected_conditions.presence_of_element_located((By.CSS_SELECTOR, "input[type='file']")))
        Upload_Button.send_keys(content)
        chill(7)
        inputElement.send_keys(Keys.RETURN)
        chill(10)
    except:
        print("Could not upload file or enter prompt")
    
    try:
        # Find all elements with text content
        Answer_Elements = driver.find_elements(By.XPATH, "//p | //li[not(contains(@data-testid, 'history-item'))]")

        chill(5)

        # Iterate over the elements and extract text if present
        for element in Answer_Elements:
            if element.text.strip():  # Ensure only non-empty text is added
                result_list_rewrite.append(element.text)
    except Exception as e:
        print(f"Could not extract text. Error: {e}")


def save_rewrite(output_path: str) -> None:
    """
    Saves the rewritten content to a file.
    
    Args:
        output_path (str): The path where the rewritten content should be saved.
    
    Returns:
        None
    """
    with open(output_path, "w") as file:
        for element in result_list_rewrite:
            file.write(element + "\n")
