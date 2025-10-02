###########
# IMPORTS #
###########
# Default libs
import string
import sys
import argparse
from datetime import datetime

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

    debug = False 

    #Declare and init device
    dev = xem.Device(True)
    result = dev.Initialize()
    dev.setupClock() 

    #Deploy bitstream to FPGA
    bitfile = "logic_analyzer_wrapper.bit" # TODO: Update this line to point to _your_ bit file
    if (dev.downloadFile(bitfile) == False):
        cs1410.print_error("Could not push bitstream file to FPGA. Is it plugged in? Do you have the correct bitstream")
        exit(1)

    # TTK Gui
    root = Tk()
    app = Lab1bTTK(root, dev)
    root.mainloop()

###########
# TTK GUI #
###########
class Lab1bTTK:
    def __init__(self, root, dev):
        # Initialize
        self.root = root
        self.dev = dev
        self.root.title("CS1410 Lab1b")

        # Configure TTK style
        self.style = ttk.Style()
        self.style.configure('NoBorder.TLabel', borderwidth=0, relief='solid')

        # Create object grid -- all widgets will be placed in this grid
        mainframe = ttk.Frame(root, padding="3 3 12 12")
        mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
        root.columnconfigure(0, weight=1)
        root.rowconfigure(0, weight=1)

        # Buttons config
        self.buttons = []
        ## RESET
        reset_button = ttk.Button(mainframe, text="RESET", width=15, command=lambda i=self.dev: self.reset_fsm(i)) 
        reset_button.grid(row=0, column=0, padx=10, pady=5, sticky=N)
        self.buttons.append(reset_button)
        ## START
        start_button = ttk.Button(mainframe, text="START", width=15, command=lambda i=self.dev: self.start_fsm(i)) 
        start_button.grid(row=0, column=1, padx=10, pady=5, sticky=N)
        self.buttons.append(start_button)

        # Checkbox config
        self.write_logfile = BooleanVar(value=False)
        self.logfile="lab1b_results.log"
        checkbox = ttk.Checkbutton(mainframe, text="Write log file", variable=self.write_logfile, onvalue=True, offvalue=False)
        checkbox.grid(row=1,column=0,columnspan=2,padx=10,pady=10,sticky=N)

        # Output titles setup
        output_titles = ttk.Label(mainframe, text="Cycle\tBuffer Values", anchor="w", font=("TkDefaultFont",12))
        output_titles.grid(row=2,column=0,columnspan=2,padx=10,pady=10,sticky=S)

        # Output label setup
        self.labels = []
        self.values = []
        row_num = 0
        for idx in range(16):
            row_num = idx+3
            cyc = 15 - idx
            self.values.append(0)
            l = ttk.Label(mainframe, text=f"{cyc:02d}\t{self.values[idx]:016b}", anchor="center", style="NoBorder.TLabel", font=("TkFixedFont",12))
            l.grid(row=row_num, column=0, columnspan=2, padx=10, pady=10, sticky=S)
            #l.config(background="gray")
            self.labels.append(l)

        # Title label setup
        self.title_label = ttk.Label(mainframe, text="CS1410 Lab 1b", anchor="center", style="NoBorder.TLabel", font=("TkDefaultFont",18))
        self.title_label.grid(row=row_num+1, column=0, columnspan=2, padx=10, pady=10) # note use of columnspan

        # Initial reset of FSM
        self.reset_fsm(dev) 

    def update_values(self, dev):
        # Read the WireOuts
        idx = 0
        for addr in range(32,48):
            self.values[idx] = dev.getWire(addr)
            idx = idx + 1
        for i in range(16):
            l = self.labels[i]
            val = self.values[i]
            cyc = 15 - i 
            l.configure(text=f"{cyc:02d}\t{val:016b}")
        if self.write_logfile.get() == True:
            print("INFO: Attempting to open logfile: {}".format(self.logfile))
            curr_time = datetime.now().strftime("%m-%d-%Y %H:%M:%S")
            with open(self.logfile, 'a') as OUT: # open in append mode -- will be created if DNE
                print("##########################\n# LOGIC ANALYZER RESULTS #\n##########################", file=OUT)
                print("Time: {}".format(curr_time), file=OUT)
                print("Notes:", file=OUT)
                print("cycle", "\tvalue", file=OUT)
                for j in range(16):
                    cyc = 15 - j
                    print(f"{cyc:02d}", f"\t\t{self.values[j]:016b}", file=OUT)
                print("\n\n", file=OUT)
        return

    def reset_fsm(self, dev):
        dev.setTrigger(0x40, 1)
        print("INFO: Reset the FSM")
        self.update_values(dev)
        return
    
    def start_fsm(self,dev):
        dev.setTrigger(0x40, 0)
        print("INFO: Started the FSM")
        cnt = 0
        while True:
            cnt = cnt + 1
            trig = dev.checkTrigger(0x60, 0x00000001) 
            if trig:
                print("INFO: Received output trigger")
                break;
        self.update_values(dev)
        return

if __name__ == '__main__':
    main()
