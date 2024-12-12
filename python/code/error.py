import time

class ErrorListHandler:
    def __init__(self, size,startvalue):
        self.error_list = [startvalue] * size
        self.start_time = time.time()

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
        
    def report(self) -> None:
        for index, element in enumerate(self.error_list):
            if element > 0:
                string = "Failed in Part " + str(index) + " " + str(element) + " times"
            else:
                string = "Worked in Part " + str(index)
            yield string
        yield "Runtime: " + str(round(round(time.time()-self.start_time)/60)) +  " Mins = " + str(round(time.time() - self.start_time))+ " Seconds"




