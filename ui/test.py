#Customtkinter imports
import customtkinter



customtkinter.set_appearance_mode("System")  # Modes: system (default), light, dark
customtkinter.set_default_color_theme("ui/violett.json")  # Themes: blue (default), dark-blue, green

app = customtkinter.CTk()  # create CTk window like you do with the Tk window
app.geometry("400x240")
app.title("Feedback X")

def button_function():
    print("button pressed")

def button2_function():
    print("magei")

# Use CTkButton instead of tkinter Button
button = customtkinter.CTkButton(master=app, text="button1", command=button_function)
button2 = customtkinter.CTkButton(master=app, text="2button2", command=button2_function)

label = customtkinter.CTkLabel(master=app, text="Feedback X", fg_color="transparent")

button.place(relx=0.5, rely=0.5, anchor=customtkinter.CENTER)
button2.place(relx=0.25, rely=0.25, anchor=customtkinter.CENTER)
label.place(relx=0.5, rely=0.05, anchor=customtkinter.CENTER)

app.mainloop() # okok