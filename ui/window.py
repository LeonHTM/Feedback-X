#Customtkinter imports
import customtkinter
from tkinter import Tk

customtkinter.set_appearance_mode("System")  # Modes: system (default), light, dark
customtkinter.set_default_color_theme("ui/violett.json")


class Button(customtkinter.CTkButton):
    def __init__(self, window):
        super().__init__(window, command= self.button_click)
        self.grid(row=0, column=0, padx=20, pady=10)
    def button_click(self):
        print("classes work yippie yeye")


class Windows(customtkinter.CTk):
    def __init__(self, window_width, window_height,x_set,y_set):
        super().__init__()
        
        self.title("")

       

        #Window Gemometry
        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()

        window_width = int(screen_width * window_width)
        window_height = int(screen_height * window_height)
        print(window_height,window_width)

        position_x = int((screen_width * x_set) - (window_width / 2))
        position_y = int((screen_height * y_set) - (window_height / 2))
        self.geometry(f"{window_width}x{window_height}+{position_x}+{position_y}")

        self.button = Button(self)
        
        #test
        """
        # add widgets to app
        self.button = customtkinter.CTkButton(self, command=self.button_click)
        self.button.grid(row=0, column=0, padx=20, pady=10)

    # add methods to app
    def button_click(self):
        print("button click")"""

Window1 = Windows(0.45555,0.52,1/2,1/2)

Window1.mainloop()





