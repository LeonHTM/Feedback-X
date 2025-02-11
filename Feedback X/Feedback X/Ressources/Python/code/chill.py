import time

def chill(chill_value: int) -> None:
    """
    Pauses the execution of the program for the specified amount of time.
    
    Args:
        chill_value (int): Time in seconds to sleep.
    
    Returns:
        None
    
    Example:
        chill(16) will pause for 16, but print a warning after 8 Seconds
    """
    #print("Sleeping: " + str(chill_value))
    time.sleep((chill_value/2))
    #print("Sleeping: " + str(chill_value/2) + " To go")
    time.sleep((chill_value/2))