#Normal Imports
import time
import datetime


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
from option_lists import *
from chill import chill
from files import file_path

#-----------------------------------------------------------FUNCTIONS-----------------------------------------------------------#

def switchtab() -> None:
    """
    Creates a new browser tab and switches to it.
    """
    driver.execute_script("window.open();") 
    new_tab_handle = driver.window_handles[-1]  
    driver.switch_to.window(new_tab_handle) 


def startup(headless: bool,cookies_file_path: str) -> None:
    """
    Initializes the Chrome browser with optional headless mode.
    
    Args:
        headless(bool): If True, the browser will run in headless mode (without UI).
        cookies_file_path(str): The path to the cookies
    Returns:
        None
    
    Example:
        startup(headless = True, cookies_file_path = "/User/FeedbackX") will start the browser in headless mode.
    """
    service = webdriver.ChromeService(executable_path="/Users/leon/Downloads/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing")
    
    
    
    global driver
    chrome_options = Options()
    chrome_options.add_argument("--no-sandbox")


    #print(user_data_dir)
    chrome_options.add_argument(f"user-data-dir={cookies_file_path}")
    if headless == True:
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--disable-blink-features=AutomationControlled")
        chrome_options.add_argument("--enable-javascript")
        chrome_options.add_argument("--disable-features=EnableAccessibilityObjectModel")
        chrome_options.add_argument("--remote-debugging-port=9222") 
    driver = webdriver.Chrome(service=service, options=chrome_options)

    
def login(account: str, password: str,path:str) -> None:
    """
    Logs into the Apple Feedback Assistant website using the provided account and password.
    
    Args:
        account(str): The user's account name (email).
        password(str): The user's account password.
        path(str): chatGPT or Apple
    
    Returns:
        None
    
    Example:
        login(account = "Testemail@icloud.com", password = "neverusepassword1234", path = "https://feedbackassistant.apple.com/")
    """
    if path == "https://feedbackassistant.apple.com/":
        driver.get(path)

        #iFrame Localisation
        try:
            iframe = WebDriverWait(driver, 5).until(
            expected_conditions.presence_of_element_located((By.ID, "aid-auth-widget-iFrame")))
            driver.switch_to.frame(iframe)
            #print("Iframe localized and switched")
        except TimeoutException:
            print("Failed: Could not localize iframe")
            
        #Account
        try:
            account_box = WebDriverWait(driver, 30).until(
            expected_conditions.presence_of_element_located((By.ID, "account_name_text_field"))
            )
            account_box.send_keys(account)
            chill(2)
            account_box.send_keys(Keys.RETURN)
            chill(1.5)
            #print("Entered Account Credentials")
        except TimeoutException:
            print("Failed: Couldn't find Account Box")
            
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
            print("Failed: Couldn't find Password Box")
    else: print("Failed: path doesn't match https://feedbackassistant.apple.com/ is " + path + " instead")
        

def logout(delay: int) -> None: 
    """
    Logs out from the Apple Feedback Assistant website.
    
    Args:
        delay(int): Time to wait before logging out. Helpful for giving users time to interract with the page.
    
    Returns:
        None
    
    Example:
        logout(1) will log out after a 1-second delay.
    """
    #Switch to Default Content
    try: 
        driver.switch_to.default_content()
    except TimeoutException:
        print("Failed: Couldn't switch to default content from iframe")

    #Logout Tent
    try:
        Logout_Tent = WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.CSS_SELECTOR, ".NavbarStyles__ActionBar-sc-wpx22n-12.fqapdO.localnav-menu-link")))
        if isinstance(delay, int) and int(delay) >0:
            chill(delay)
        else:
             raise ValueError
        Logout_Tent.click()
    except TimeoutException:
        print("Failed: Couldn't find log out tent")
        
    except ValueError:
        print("Failed: Delay has to be bigger than 0 and an integer")

    #Logout Button inside Tent    
    try:
        Logout_Button = WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//span[@role='button' and .//p[text()='Sign Out']]")))
        #print("Found Logout button")
        Logout_Button.click()
        #print("Logged out")
    except TimeoutException:
        print("Failed: Couldn't find Log out button")
    
    
def detail_feedback(path: str) -> None:
    """
    Fills out the feedback form based on the provided path.
    
    Args:
        path(str): A comma-separated string of selections for the feedback form. First Value has to be Name of Category
    
    Returns:
        None
    
    Example:
        detail_feedback(path = "Wallpaper,2,2,2") will fill out the feedback form accordingly.
    """
    #Split Path
    Path_List = path.split(",")
    Area_String = Path_List[0]
    Path_List[0]= str(Area_Options.index(Area_String))

    #Area Selection
    try:
        Area_Box = Select(WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//select[@aria-label='Which area are you seeing an issue with?']"))))
        #print("Found Feedback Area Box")
        WebDriverWait(driver,1)
        Area_Box.select_by_index(int(Path_List[0]))
        #print("Chosing Area " + Path_List[0] + " = " + Area_Options[int(Path_List[0])])
    except TimeoutException:
        print("Failed: Couldn't find feedback area selector")
    except UnexpectedTagNameException:
        print("Failed: Couldn't select Area")
    except NoSuchElementException:
        print("Failed: Couldn't find provided Value in area drop down")

    #Type Selection    
    try:
        Type_Box = Select(WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//select[@aria-label='What type of feedback are you reporting?']"))))
        #print("Found Type Area Box")
        WebDriverWait(driver,1)
        Type_Box.select_by_index(int(Path_List[1]))
        #print("Choosing Type: " + Type_Options[1])    
    except TimeoutException:
        print("Failed: Couldn't find feedback type selector")
        Path_List.pop(1)
    except UnexpectedTagNameException:
        print("Failed: Couldn't select Type")
    except NoSuchElementException:
        print("Failed: Couldn't find provided value in type drop down")

    #Work through all Elements, reload all elements everytime
    index = 2  
    try:
        while index < len(Path_List):
            Dropdown_List = WebDriverWait(driver, 5).until(
                expected_conditions.presence_of_all_elements_located((By.TAG_NAME, "select"))
            )
            # Ensure we have enough dropdowns to continue; otherwise, wait for new ones
            if  index < len(Dropdown_List):
                # Select the current dropdown by index
                Select_Dropdown = Select(Dropdown_List[index])
                Select_Dropdown.select_by_index(Path_List[index])
                index += 1  
               
            
            elif index == len(Dropdown_List):
                break
    except TimeoutException:
        print("Failed: Couldn't locate the required dropdowns with the given path")
    
    #Time Box (Doensn't stop process in Application because is not alway present)
    try:
        Time_Box = WebDriverWait(driver,2).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//*[@aria-label='What time was it when this last occurred?']")))
        #print("Found Time Box")
        current_stuff = datetime.datetime.now()
        Time_Box.send_keys(str(current_stuff.time().strftime("%I:%M %p %Z") + " CET " + str(current_stuff.date().strftime("%m/%d/%Y"))))
    except TimeoutException:
        #print("Couldn't find Time Box")
        pass
        
def cookies(wait: int) -> None:
    """
    Accepts cookies on the Apple Feedback Assistant website.
    """
    """
    try:
        Cookies_Box_1 = WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//*[@aria-label='Enter Verification Code Digit 1']")))
        Cookies_Box_1.focus()
    except TimeoutException:
        print("Failed: Couldn't find Cookies Button")"""

    WebDriverWait(driver,wait).until(expected_conditions.url_contains("feedbackassistant"))
    driver.close()

def upload_feedback(uploads: str) -> None:
    """
    Uploads files to the feedback form.
    
    Args:
        uploads(str): file paths to upload, separated by commas.
    
    Example:
        upload_feedback("/path/to/file1,/path/to/file2")
    """
    #Upload Button
    try:
        Upload_Button = WebDriverWait(driver,10).until(
        expected_conditions.presence_of_element_located((By.CSS_SELECTOR, "input[type='file']")))
        #print("Upload Button found")
        Upload_List = uploads.split(",")
        for element in Upload_List:
            Upload_Button.send_keys(element)
            #print("Uploaded" + str(element))    
    except TimeoutException:
        print("Failed: Couldn't find upload button")
   

def identify_feedback() -> int:
    """
    Identifies the feedback ID from the current URL.
    
    Returns:
        int: The feedback ID as an integer.
    
    Example:
        identify_feedback() returns 16923777
    """
    Feedback_ID = driver.current_url
    Feedback_URL_List = Feedback_ID.split("/")
    Feedback_ID = Feedback_URL_List[4]
    return int(Feedback_ID)

    
def create_feedback(title: str, file: str,topic: str) -> None:
    """
    Creates a new feedback form with the given title and content.
    
    Args:
        title(str): The title of the feedback.
        file(str): The content of the feedback or a path to the content.
        topic(str): The topic of the feedback (e.g., iOS & iPadOS).
    
    Returns:
        None
    
    Example:
        create_feedback(title = "App Library Blur displayed wrong iOS 18.2 (22C151) ", file =  "I like Potatoes", tpoic = "iOS & iPadOS"))
    """
    #New Feedback
    try:
        WebDriverWait(driver,5).until(expected_conditions.url_contains("feedbackassistant"))
        driver.get("https://feedbackassistant.apple.com/new")
        #print("Found Feedback in URL")
    except TimeoutException:
        print("Failed: Couldn't find feedbackassistant in URL")

    #Topic Selection
    if topic == "iOS & iPadOS" or topic == "visionOS" or topic == "watchOS" or topic == "macOS" or topic == "tvOS" or topic == "HomePod" or topic == "Developer Tools & Resources" or topic == "Developer Technologies & SDKs" or topic == "AirPods Beta Firmware" or topic == "Enterprise & Education" or topic == "MFi Technologies":
        try:
            New_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.XPATH, f"//button[.//span[text()='{topic}']]")))
            #print("Found iOS and iPadOS Feedback button")
            New_Feedback_Button.click()
            time.sleep(1)
        except TimeoutException:
            print("Failed: Couldn't find area topic: " + topic)
    else:
        print("Failed: Topic " + topic + " not valid")

    #Fill Title
    try:
        Title_Box = WebDriverWait(driver, 5).until(
    expected_conditions.presence_of_element_located((By.XPATH, '//*[@aria-label="Please provide a descriptive title for your feedback:"]'))
)
        #print("Found Title Field")
        Title_Box.send_keys(title)
    except TimeoutException:
        print("Failed: Couldn't find feedback title field")

    #Fill Issue
    try:
        Issue_Box = WebDriverWait(driver,5).until(
        expected_conditions.presence_of_element_located((By.XPATH, '//*[@aria-label="Please describe the issue and what steps we can take to reproduce it:"]')))
        #print("Found Feedback Content Field")
        Issue_Box.send_keys(file)
    except TimeoutException:
        print("Failed: Couldn't find describe issue field")

    
def finish_feedback(kind: str,noFiles: bool)-> None:
    """
    Finishes Feedback: Either Saves, Submits or Deletes it.
    
    Args:
        kind (str): Defines the action to be taken. Can be "Save", "Submit", or "Delete". Both written with Capitalzed first Letter or not
        noFiles (bool): Is important for the alert handling. If in upload_feedback there were no files uploaded, this has to be True. Or else Alert Handling won't work.
    Returns:
        None
    
    Example:
        finish_feedback(kind:"Submit", noFiles: True)
    """
    buttonvalue = "button"
    #Save Feedback
    if kind == "Save" or kind == "save":
        try:
            Finish_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.XPATH, "//button[text()='Save']")))
            Finish_Feedback_Button.click()
            
            #print("Finished Feedback with Action:  " +kind)
        except TimeoutException:
            print("Failed: Couldn't finish with action " + kind)
            return
    #Submit or Delete Feedback
    elif kind == "Delete" or kind =="delete":
        buttonvalue = "//button[text()='Delete']"
    elif kind == "Submit" or kind == "submit":
        buttonvalue = "//button[text()='Submit']"
    try:
        #Delete Feedback
        if kind == "delete" or kind == "Delete":
            Finish_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.CSS_SELECTOR, buttonvalue)))
            Finish_Feedback_Button.click()
            alert = driver.switch_to.alert
            alert.accept()
        #Submit Feedback
        elif kind == "Submit" or kind == "submit":
            try:
                Finish_Feedback_Button = WebDriverWait(driver,5).until(
                expected_conditions.presence_of_element_located((By.XPATH, buttonvalue)))
                chill(3)
                Finish_Feedback_Button.click()
                #print("chose submit button")

                #Files or no Files Alert Handling
                if noFiles == True:
                    #No Files Alert Handling
                    SubmitwithoutFiles = WebDriverWait(driver,5).until(expected_conditions.presence_of_element_located((By.XPATH, "//button[text()='Submit Without Files']")))
                    SubmitwithoutFiles.click()
                else:
                    #With Files Alert Handling
                    WebDriverWait(driver, 10).until(expected_conditions.alert_is_present())
                    alert2 = driver.switch_to.alert
                    alert2.accept()
                    #print("Alert handled successfully.")
                WebDriverWait(driver,120).until(expected_conditions.presence_of_element_located((By.XPATH, "//button[text()='Close Feedback']")))
            except TimeoutException:
                print("Failed: No alert appeared within the given timeframe.")
            except NoAlertPresentException:
                print("Failed: No alert was present to switch to.")
        time.sleep(2)
        #print("Finished Feedback with Action: " +kind)
    except TimeoutException:
        print("Failed: Couldn't finish Feedback with Action: " + kind)
    











