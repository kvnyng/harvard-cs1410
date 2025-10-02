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
    bitfile = "mux_top.bit"
    if (dev.downloadFile(bitfile) == False):
        exit(1)

    #Tkinter GUI
    # Create the main window and pass it to the ToggleBoxApp class
    root = Tk()
    app = ToggleBoxApp(root, dev)
    root.mainloop()

#############
# FUNC DEFS #
#############
def send_inputs(dev, a, b, c, d, sel):
    
    dev.setWire(0x00, a, 0xffffffff) 
    dev.setWire(0x01, b, 0xffffffff)
    dev.setWire(0x02, c, 0xffffffff) 
    dev.setWire(0x03, d, 0xffffffff)
    dev.setWire(0x04, sel, 0xffffffff)



def read_output(dev):
    f = dev.getWire(0x20, 0xffffffff) 

    return f

###########
# TTK GUI #
###########
class ToggleBoxApp:
    def __init__(self, root, dev):
        self.root = root
        self.root.title("Toggle Boxes")
        self.dev = dev
        
        self.labels = {}
        label_names = ['a', 'b', 'c', 'd', 'sel']
        for name in label_names:
            label = ttk.Label(root, text=f"{name}: 0", font=("Arial", 14), relief="raised", width=15)
            label.value = 0
            label.bind("<Button-1>", self.toggle_input)
            label.pack(pady=10)
            self.labels[name] = label

        
        # Output label setup
        self.output_label = ttk.Label(root, text="Output: 0", font=("Arial", 14), relief="raised", width=15)
        self.output_label.pack(pady=10)
        self.update_output()

    def toggle_input(self, event):
        label = event.widget
        name = label.cget('text').split(':')[0]
        if name == 'sel':
            # Toggle sel between 0, 1, 2, 3 and display in binary format
            label.value = (label.value + 1) % 4
            display_value = format(label.value, '02b')  # Binary format with 2 digits
        else:
            # Toggle a, b, c, d between 0 and 1
            label.value = 1 - label.value
            display_value = label.value
        
        label.config(text=f"{name}: {display_value}")
        self.update_output()

    def update_output(self):
        if len(self.labels) == 5:
            a = self.labels['a'].value
            b = self.labels['b'].value
            c = self.labels['c'].value
            d = self.labels['d'].value
            sel = self.labels['sel'].value
            send_inputs(self.dev, a, b, c, d, sel)
            result = read_output(self.dev)
            self.output_label.config(text=f"Output: {int(result)}")

if __name__ == '__main__':
    main()
