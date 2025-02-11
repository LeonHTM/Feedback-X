import time

class ErrorListHandler:
    def __init__(self, size, startvalue):
        self.error_list = [startvalue] * size
        self.start_time = time.time()
        """
        Creates an error list of a given size with a starting value. The starting value should be how many times a script is supposed to run without errors. The size should be the maximal possible failure points.

        """

    def add(self, position: int, value_to_add:int) -> None:
        """
        Adds a given value to the existing value at a specific position in the list.

        Args:
            position (int): The index position to add the value.
            value_to_add (int): The value to add to the existing value at the position.

        Returns:
            None
        """
        if 0 <= position < len(self.error_list):  # Ensure the position is within bounds
            self.error_list[position] += value_to_add
        else:
            print("ErrorHandler Error: Position out of bounds.")

    def remove(self, position: int, value_to_remove:int) -> None:
        """
        Adds a given value to the existing value at a specific position in the list.

        Args:
            position (int): The index position to add the value.
            value_to_add (int): The value to add to the existing value at the position.

        Returns:
            None
        """
        if 0 <= position < len(self.error_list):  # Ensure the position is within bounds
            self.error_list[position] -= value_to_remove
        else:
            print("ErrorHandler Error: Position out of bounds.")

    def get_list(self) -> list:
        """
        Returns the current state of the error list.

        Returns:
            list: The error list.
        """
        return self.error_list
        
    def report(self) -> str: # type: ignore
        """
        Returns a report of the error list.

        Returns:
            For every element in the error list, it returns a string with the number of errors in that part. If there are no errors it returns "Worked in Part" + index. At the end it returns the runtime of the script. Time is mesuared from when object was created.
        Example:
            Worked in Part 0
            Failed in Part 1 -> 1 times
            Failed in Part 2 -> 1 times
            Failed in Part 3 -> 1 times
            Failed in Part 4 -> 1 times
            Failed in Part 5 -> 2 times
            Failed in Part 6 -> 1 times
            Failed in Part 7 -> 1 times
            Failed in Part 8 -> 1 times
            Runtime: 1 Mins = 31 Seconds
        """
        for index, element in enumerate(self.error_list):
            if element > 0:
                string = "Failed in Part " + str(index) + " -> " + str(element) + " times"
            else:
                string = "Worked in Part " + str(index)
            yield string
        yield "Runtime: " + str(round(round(time.time()-self.start_time)/60)) +  " Mins = " + str(round(time.time() - self.start_time))+ " Seconds"

    def reportcheck(self) -> str:
        """
        Simpler Version of the report function, returns "Failed" if there are any errors in the list. If everything workd it returns "Success"

        Returns:
            "Failed" or "Success"
        """
        for element in self.error_list:
            if element > 0:
                return("Failed")
        return("Success")
        


