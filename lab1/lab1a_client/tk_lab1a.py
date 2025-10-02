###########
# IMPORTS #
###########
# Default libs
import string
import sys
import argparse

# OK and CS1410 libs
sys.path.insert(0,"../../lib")
import cs1410_lib.utils as cs1410
ok = cs1410.import_oklib(verbose=True)
import cs1410_lib.xem as xem

# TK (GUI) libs
from tkinter import *
from tkinter import ttk

########
# MAIN #
########
def main():
    #Declare and init device
    dev = xem.Device(True)
    result = dev.Initialize()
    dev.setupClock() 

    #Deploy bitstream to FPGA
    bitfile = "blackbox_wrapper.bit" # TODO: Point this to _your_ bitstream (at the end of the lab)
    if (dev.downloadFile(bitfile) == False):
        cs1410.print_error("Could not push bitstream file to FPGA. Is it plugged in? Do you have the correct bitstream")
        exit(1)

    # TTK Gui
    root = Tk()
    app = ToggleBoxApp(root, dev)
    root.mainloop()

#############
# FUNC DEFS #
#############
# Set okWireIn values
def send_inputs(dev, in1, in2, in3):
    dev.setWire(0x00, in1, 0xffffffff) 
    dev.setWire(0x01, in2, 0xffffffff)
    dev.setWire(0x02, in3, 0xffffffff) 

# Read okWireOut values
def read_output(dev):
    out = dev.getWire(0x20, 0xffffffff) 
    return out

###########
# TTK GUI #
###########
class ToggleBoxApp:
    def __init__(self, root, dev):
        # Initialize
        self.root = root
        self.dev = dev
        self.root.title("CS1410 Lab1a")

        # Configure button style
        self.style = ttk.Style()
        ## Unset -> gray background, sends 0 to FPGA
        self.style.configure("Unset.TButton", background="gray")
        self.style.map("Unset.TButton", background=[('active', 'gray'), ('!disabled', 'gray')]) # this prevents button from changing color on mouse hover
        ## Set -> green background, sends 1 to FPGA
        self.style.configure("Set.TButton", background="green")
        self.style.map("Set.TButton", background=[('active', 'green'), ('!disabled', 'green')]) # this prevents button from changing color on mouse hover

        # Create object grid -- all widgets will be placed in this grid
        mainframe = ttk.Frame(root, padding="3 3 12 12")
        mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
        root.columnconfigure(0, weight=1)
        root.rowconfigure(0, weight=1)

        # Make input buttons
        self.buttons = []
        for i in range(3): 
            # Initialize as Unset buttons
            button = ttk.Button(mainframe, text=f"Input {i+1}: 0", style="Unset.TButton", width=15, command=lambda i=i: self.toggle_input(i)) 
            button.grid(row=i, column=0, padx=10, pady=5, sticky=N)
            self.buttons.append(button)

        # Output label setup
        # TODO: Make this prettier
        self.output_label = ttk.Label(mainframe, text="Output: 0", anchor="center", relief="solid", width=15)
        self.output_label.grid(row=1, column=1, padx=10, pady=5, sticky=E)
        self.output_label.config(background="gray")

        # Title label setup
        self.style.configure('NoBorder.TLabel', borderwidth=0, relief='solid')
        self.title_label = ttk.Label(mainframe, text="CS1410 Lab 1a", anchor="center", style="NoBorder.TLabel", font=("TkDefaultFont",18))
        self.title_label.grid(row=3, column=0, columnspan=2, padx=10, pady=10) # note use of columnspan

        # Initialize output value
        self.update_output()

    def toggle_input(self, index):
        button = self.buttons[index]
        curr_style = button.cget("style")
        if curr_style == "Set.TButton":
            button.config(text=f"Input {index+1}: 0", style="Unset.TButton")
        else:
            button.config(text=f"Input {index+1}: 1",style="Set.TButton")
        self.update_output()

    def update_output(self):
        # Get values from all labels
        if len(self.buttons) == 3:
            # Read the button styles as a proxy for okWireIn values
            s1, s2, s3 = [button.cget("style") for button in self.buttons]
            in1 = 0 if (s1 == "Unset.TButton") else 1
            in2 = 0 if (s2 == "Unset.TButton") else 1
            in3 = 0 if (s3 == "Unset.TButton") else 1
            send_inputs(self.dev, in1, in2, in3)
            result = read_output(self.dev)
            self.output_label.config(text=f"Output: {int(result)}")
            if result == 1:
                self.output_label.config(background="green")
            else:
                self.output_label.config(background="gray")

if __name__ == '__main__':
    main()
