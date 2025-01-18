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
from option_lists import Area_Options
from option_lists import Type_Options
from chill import chill
from files import file_path

def switchtab() -> None:
    """
    Creates a new browser tab and switches to it.
    """
    driver.execute_script("window.open();") 
    new_tab_handle = driver.window_handles[-1]  
    driver.switch_to.window(new_tab_handle) 






def startup(headless: bool) -> None:
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
    chrome_options = Options()
    user_data_dir =file_path("../cookies")
    #print(user_data_dir)
    chrome_options.add_argument(f"user-data-dir={user_data_dir}")
    if headless == True:
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--disable-blink-features=AutomationControlled")
        chrome_options.add_argument("--enable-javascript")
        chrome_options.add_argument("--disable-features=EnableAccessibilityObjectModel")
        chrome_options.add_argument("--remote-debugging-port=9222") 
    driver = webdriver.Chrome(options=chrome_options)

    
def login(account: str, password: str,path_value:str) -> None:

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
    
    if path_value == "https://feedbackassistant.apple.com/":
        driver.get(path_value)
    
    
            
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
    else: print("Failed: path_value doesn't match https://feedbackassistant.apple.com/ is " + path_value + " instead")
        

def logout(delay: int) -> None: 
    """
    Logs out from the Apple Feedback Assistant website.
    
    Args:
        delay (int): Time to wait before logging out.
    
    Returns:
        None
    
    Example:
        logout(1) will log out after a 1-second delay.
    """
    try: 
        driver.switch_to.default_content()
    except TimeoutException:
        print("Failed: Couldn't switch to default content from iframe")
        

    #SignOut
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
        path (str): A comma-separated string of selections for the feedback form. First Value has to be Name of Category
    
    Returns:
        None
    
    Example:
        detail_feedback("Wallpaper,2,2,2") will fill out the feedback form accordingly.
    """

    #Path Auseinandernehmen
    Path_List = path.split(",")
    Area_String = Path_List[0]
    Path_List[0]= str(Area_Options.index(Area_String))
    #Area and Type Selection
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

    #Work throgh All Elemnts, reload all elemenbts everytime
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
    
    #Fill all Dropdown_List Present (
    
    
    try:
        Time_Box = WebDriverWait(driver,2).until(
        expected_conditions.presence_of_element_located((By.XPATH, "//*[@aria-label='What time was it when this last occurred?']")))
        #print("Found Time Box")
        current_stuff = datetime.datetime.now()
        Time_Box.send_keys(str(current_stuff.time().strftime("%I:%M %p %Z") + " CET " + str(current_stuff.date().strftime("%m/%d/%Y"))))
    except TimeoutException:
        print("Couldn't find Time Box")

def upload_feedback(uploads: str) -> None:
    """
    Uploads files to the feedback form.
    
    Args:
        uploads (str): A comma-separated list of file paths to upload.
    
    Example:
        upload_feedback("/path/to/file1,/path/to/file2")
    """
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

    
def create_feedback(title: str, file: str,area: str) -> None:
    """
    Creates a new feedback form with the given title and content.
    
    Args:
        title (str): The title of the feedback.
        file (str): The content of the feedback or a path to the content.
        area(str): The area of the feedback
    
    Returns:
        None
    
    Example:
        create_feedback(title: "App Library Blur displayed wrong iOS 18.2 (22C151) ", file: "I like Potatoes", area: "iOS & iPadOS"))
    """
    #New Feedback
    try:
        WebDriverWait(driver,5).until(expected_conditions.url_contains("feedbackassistant"))
        driver.get("https://feedbackassistant.apple.com/new")
        #print("Found Feedback in URL")
    except TimeoutException:
        print("Failed: Couldn't find feedbackassistant in URL")




    if area == "iOS & iPadOS" or area == "visionOS" or area == "watchOS" or area == "macOS" or area == "tvOS" or area == "HomePod" or area == "Developer Tools & Resources" or area == "Developer Technologies & SDKs" or area == "AirPods Beta Firmware" or area == "Enterprise & Education" or area == "MFi Technologies":
        try:
            New_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.XPATH, f"//button[.//span[text()='{area}']]")))
            #print("Found iOS and iPadOS Feedback button")
            New_Feedback_Button.click()
            time.sleep(1)
        except TimeoutException:
            print("Failed: Couldn't find area topic: " + area)
    else:
        print("Failed: Topic " + area + " not valid")



    #Fill Title and Issue
    try:
        Title_Box = WebDriverWait(driver, 5).until(
    expected_conditions.presence_of_element_located((By.XPATH, '//*[@aria-label="Please provide a descriptive title for your feedback:"]'))
)
        #print("Found Title Field")
        Title_Box.send_keys(title)
    except TimeoutException:
        print("Failed: Couldn't find feedback title field")

    
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
        noFiles (bool): If True, the feedback will be submitted without any files
    Returns:
        None
    
    Example:
        finish_feedback(kind:"Submit", noFiles: True)
    """

    buttonvalue = "button"
    #Saving
    if kind == "Save" or kind == "save":
        try:
            Finish_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.XPATH, "//button[text()='Save']")))
            Finish_Feedback_Button.click()
            
            #print("Finished Feedback with Action:  " +kind)
        except TimeoutException:
            print("Failed: Couldn't finish with action " + kind)
            return
    #Submit or Delete
    elif kind == "Delete" or kind =="delete":
        buttonvalue = ".PrimaryButton__Button-sc-1si9oai-0.clOZiL"
    elif kind == "Submit" or kind == "submit":
        buttonvalue = "//button[text()='Submit']"
    try:
        if kind == "delete" or kind == "Delete":
            Finish_Feedback_Button = WebDriverWait(driver,5).until(
            expected_conditions.presence_of_element_located((By.CSS_SELECTOR, buttonvalue)))
            Finish_Feedback_Button.click()
            alert = driver.switch_to.alert
            alert.accept()

        elif kind == "Submit" or kind == "submit":
            try:
                Finish_Feedback_Button = WebDriverWait(driver,5).until(
                expected_conditions.presence_of_element_located((By.XPATH, buttonvalue)))
                chill(3)
                Finish_Feedback_Button.click()
                #print("chose submit button")
                if noFiles == True:
                    SubmitwithoutFiles = WebDriverWait(driver,5).until(expected_conditions.presence_of_element_located((By.XPATH, "//button[text()='Submit Without Files']")))
                    SubmitwithoutFiles.click()
                else:
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
    











