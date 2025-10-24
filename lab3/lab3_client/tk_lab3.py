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

###########
# TTK GUI #
###########
class TrafficLightsApp:
    def __init__(self, root, dev):
        self.root = root
        self.dev = dev
        self.rst = 0
        self.setup_gui()
        self.update_periodically()  # Start periodic updates
        

    # Existing code ...

    # Method to continuously update lights and timer
    def update_periodically(self):
        # Get inputs from the device
        # Update lights and timer
        self.update_lights()
        self.timer.config(text=str(self.get_timer_out()))

        # Schedule the next update after 1000 milliseconds (1 second)
        self.root.after(1000, self.update_periodically)



    def setup_gui(self):
        #self.root.title("Traffic Lights Intersection")

        # Timer
        timer_frame = ttk.Frame(self.root, padding="10 10 10 10")
        timer_frame.grid(row=0, column=3)
        ttk.Label(timer_frame, text="Timer").grid(row=0, column=0)
        timer_value = self.get_timer_out()
        self.timer = ttk.Label(timer_frame, text=str(timer_value), relief="solid", width=5)
        self.timer.grid(row=1, column=0)

        # Input toggles
        input_frame = ttk.Frame(self.root, padding="10 10 10 10")
        input_frame.grid(row=2, column=3, sticky="n")
        ttk.Label(input_frame, text="INPUTS", font=("Arial", 12, "bold"), foreground="blue").grid(row=0, column=0, columnspan=2)

        
        self.clickrst_toggle = ttk.Label(input_frame, text="RST", relief="solid", width=5)
        self.clickrst_toggle.grid(row=4, column=1)
        self.clickrst_toggle.bind("<Button-1>", lambda e: self.toggle(self.rst, self.car_ns_toggle, self.car_ew_toggle, 1))

        self.car_ns_toggle = ttk.Label(input_frame, text="0", relief="solid", width=5)
        self.car_ns_toggle.grid(row=2, column=1)
        self.car_ns_toggle.bind("<Button-1>", lambda e: self.toggle(self.car_ns_toggle, self.car_ns_toggle, self.car_ew_toggle, 0))
        ttk.Label(input_frame, text="CAR NS:").grid(row=2, column=0)

        self.car_ew_toggle = ttk.Label(input_frame, text="0", relief="solid", width=5)
        self.car_ew_toggle.grid(row=3, column=1)
        self.car_ew_toggle.bind("<Button-1>", lambda e: self.toggle(self.car_ew_toggle, self.car_ns_toggle, self.car_ew_toggle, 0))
        ttk.Label(input_frame, text="CAR EW:").grid(row=3, column=0)

        # East-West traffic light
        # frame_ew = ttk.Frame(self.root, padding="10 10 10 10")
        # frame_ew.grid(row=1, column=1)
        # ttk.Label(frame_ew, text="East-West PED | CAR", font=("Arial", 12, "bold")).grid(row=0, column=0)

        self.traffic_light_ew = ttk.Frame(self.root, padding="10 10 10 10")
        self.traffic_light_ew.grid(row=2, column=0)
        self.create_traffic_light(self.traffic_light_ew, self.get_light_ew(), False)

        """
        ped_light_ew = ttk.Frame(self.root, padding="10 10 10 10")
        ped_light_ew.grid(row=2, column=0)
        self.ped_light_ew_label = self.create_pedestrian_light(ped_light_ew, self.get_ped_ew())
        ttk.Label(ped_light_ew, text="Ped (EW)").grid(row=1, column=0)
        """
        
        self.ped_light_ew = ttk.Frame(self.root, padding="10 10 10 10")
        self.ped_light_ew.grid(row=3, column=0)
        self.create_ped_light(self.ped_light_ew, self.get_sig_ew())
        ttk.Label(self.ped_light_ew, text="Ped (EW)").grid(row=1, column=0)

        # North-South traffic light
        # frame_ns = ttk.Frame(self.root, padding="10 10 10 10")
        # frame_ns.grid(row=0, column=0)
        # ttk.Label(frame_ns, text="North-South PED | CAR", font=("Arial", 12, "bold")).grid(row=0, column=0)

        self.traffic_light_ns = ttk.Frame(self.root, padding="10 10 10 10")
        self.traffic_light_ns.grid(row=0, column=1)
        self.create_traffic_light(self.traffic_light_ns, self.get_light_ns(), True) 

        """
        ped_light_ns = ttk.Frame(self.root, padding="10 10 10 10")
        ped_light_ns.grid(row=2, column=3)
        self.ped_light_ns_label = self.create_pedestrian_light(ped_light_ns, self.get_ped_ns())
        ttk.Label(ped_light_ns, text="Ped (NS)").grid(row=1, column=0)
        """

        self.ped_light_ns = ttk.Frame(self.root, padding="10 10 10 10")
        self.ped_light_ns.grid(row=0, column=2)
        self.create_ped_light(self.ped_light_ns, self.get_sig_ns())
        ttk.Label(self.ped_light_ns, text="Ped (NS)").grid(row=1, column=0)

        self.intersection_frame = ttk.Frame(self.root)
        self.intersection_frame.grid(row=1, column=1, columnspan=2, rowspan=2)
        self.intersection = Canvas(self.intersection_frame, width=100, height=100, bg='grey')
        self.intersection.pack()

    """
    # Function to get pedestrian light status for North-South
    def get_ped_ns(self):
        # Return 0 for OFF and 1 for ON
        ped_ns = self.dev.getWire(0x23, 0x2)
        if ped_ns == 2:
            return 1
        else:
            return 0

    # Function to get pedestrian light status for East-West
    def get_ped_ew(self):
        # Return 0 for OFF and 1 for ON
        ped_ns = self.dev.getWire(0x23, 0xffffffff)
        if ped_ns == 1:
            return 1
        else:
            return 0
    """
        
    # Function to get ped light status for North-South
    def get_sig_ns(self):
        ped_sigs = self.dev.getWire(0x23, 0xffffffff) 
        sig_ns = (ped_sigs >> 2) & 0b11
        # mask then move over 2 bits and then grab the 4 bits
        if sig_ns == 0:
            return "amber"
        elif sig_ns == 1:
            return "orange"
        elif sig_ns == 2:
            return "white"
        else:
            print(f"Error: sig_ns value = {sig_ns}")
            exit(1)
        
    # Function to get ped light status for East-West
    def get_sig_ew(self):
        ped_sigs = self.dev.getWire(0x23, 0xffffffff) 
        sig_ew = (ped_sigs & 0b11)
        # mask then grab the 4 bits
        if sig_ew == 0:
            return "amber"
        elif sig_ew == 1:
            return "orange"
        elif sig_ew == 2:
            return "white"
        else:
            print(f"Error: sig_ew value = {sig_ew}")
            exit(1)

    # Function to get timer value
    def get_timer_out(self):
        timer = self.dev.getWire(0x20, 0xffffffff) 
        return timer  # Example value, replace with actual logic

    # Function to get traffic light status for North-South
    def get_light_ns(self):
        light_ns = self.dev.getWire(0x22, 0xffffffff) 
        if light_ns == 0:
            return "red"
        elif light_ns == 1:
            return "yellow"
        if light_ns == 2:
            return "green"
        else:
            print(f"Error: light_ns value = {light_ns}")
            exit(1)

    # Function to get traffic light status for East-West
    def get_light_ew(self):
        light_ew = self.dev.getWire(0x21, 0xffffffff) 
        if light_ew == 0:
            return "red"
        elif light_ew == 1:
            return "yellow"
        if light_ew == 2:
            return "green"
        else:
            print(f"Error: light_ew value = {light_ew}")
            exit(1)

    # Function to create a traffic light
    def create_traffic_light(self, frame, light_color, sideways):
        colors = {"red": ("red", "black", "black"),
                  "yellow": ("black", "yellow", "black"),
                  "green": ("black", "black", "green")}
        red_color, yellow_color, green_color = colors[light_color]

        red_light = Canvas(frame, width=30, height=30, bg='black')
        red_light.grid(row=0, column=0)
        red_light.create_oval(6, 6, 28, 28, fill=red_color)
        
        yellow_light = Canvas(frame, width=30, height=30, bg='black')
        yellow_light.grid(row=0 if sideways else 1, column=1 if sideways else 0)
        yellow_light.create_oval(6, 6, 28, 28, fill=yellow_color)
        
        green_light = Canvas(frame, width=30, height=30, bg='black')
        green_light.grid(row=0 if sideways else 2, column=2 if sideways else 0)
        green_light.create_oval(6, 6, 28, 28, fill=green_color)
 
    # Function to create a traffic light
    def create_ped_light(self, frame, light_color):
        colors = {"amber": ("red", "black", "black"),
                  "orange": ("orange", "orange", "black"),
                  "white": ("white", "black", "white")}
        amber_color, orange_color, white_color = colors[light_color]

        amber_light = Canvas(frame, width=30, height=30, bg='black')
        amber_light.grid(row=0, column=0)
        amber_light.create_oval(6, 6, 28, 28, fill=amber_color)
        
        # orange_light = Canvas(frame, width=30, height=30, bg='black')
        # orange_light.grid(row=1, column=0)
        # orange_light.create_oval(5, 5, 25, 25, fill=orange_color)
        
        # white_light = Canvas(frame, width=30, height=30, bg='black')
        # white_light.grid(row=2, column=0)
        # white_light.create_oval(5, 5, 25, 25, fill=white_color)

    """
    # Function to create a pedestrian light
    def create_pedestrian_light(self, frame, status):
        light_text = "ON" if status == 1 else "OFF"
        light = ttk.Label(frame, text=light_text, relief="solid", width=5)
        light.grid(row=0, column=0)
        return light
    """

    # Function to send inputs
    # def send_inputs(self, car_ns, car_ew, ped):
    #     # Logic to handle the inputs
    #     print("Inputs sent: PED={}, CAR_NS={}, CAR_EW={}".format(ped, car_ns, car_ew))
    #     self.update_lights(car_ns, car_ew, ped)

    def send_inputs(self, car_ns, car_ew, click_rst):
        self.dev.setWire(0x00, car_ns, 0xffffffff) 
        self.dev.setWire(0x01, car_ew, 0xffffffff)
        self.dev.setWire(0x02, click_rst, 0xffffffff) 
        print("Inputs sent: CLICK_RST={}, CAR_NS={}, CAR_EW={}".format(click_rst, car_ns, car_ew))
        self.update_lights()

    # Function to toggle between 0 and 1 and send inputs
    def toggle(self, label, car_ns_label, car_ew_label, rst):
        # no need to update the button on the screen for rst
        if not rst:
            current_value = int(label['text'])
            new_value = (current_value + 1) % 2
            label.config(text=str(new_value))
        else:
            self.rst = (self.rst + 1) % 2
        self.send_inputs(int(car_ns_label['text']), int(car_ew_label['text']), self.rst)

    # Function to update lights based on inputs
    def update_lights(self):
        traffic_light_ns_color = self.get_light_ns()
        traffic_light_ew_color = self.get_light_ew()
        pedestrian_light_ns_color = self.get_sig_ns()
        pedestrian_light_ew_color = self.get_sig_ew()

        self.intersection.delete("all")
        self.intersection.create_rectangle(20, 0, 85, 100, fill="black")
        self.intersection.create_rectangle(0, 20, 100, 85, fill="black")

        # Update North-South traffic light
        for widget in self.traffic_light_ns.winfo_children():
            widget.destroy()
        self.create_traffic_light(self.traffic_light_ns, traffic_light_ns_color, True)
        if (traffic_light_ns_color != 'red'):
            self.intersection.create_rectangle(45, 0, 60, 100, fill=traffic_light_ns_color);

        # Update East-West traffic light
        for widget in self.traffic_light_ew.winfo_children():
            widget.destroy()
        self.create_traffic_light(self.traffic_light_ew, traffic_light_ew_color, False)
        if (traffic_light_ew_color != 'red'):
            self.intersection.create_rectangle(0, 45, 100, 60, fill=traffic_light_ew_color);

        # Update North-South pedestrian light
        # self.ped_light_ns_label.config(text="ON" if pedestrian_light_ns_status == 1 else "OFF")
        for widget in self.ped_light_ns.winfo_children():
            widget.destroy()
        self.create_ped_light(self.ped_light_ns, pedestrian_light_ns_color)
        if (pedestrian_light_ns_color != 'amber'):
            self.intersection.create_rectangle(0, 20, 20, 85, fill=pedestrian_light_ns_color);
            self.intersection.create_rectangle(85, 20, 105, 85, fill=pedestrian_light_ns_color);

        # Update East-West pedestrian light
        # self.ped_light_ew_label.config(text="ON" if pedestrian_light_ew_status == 1 else "OFF")
        for widget in self.ped_light_ew.winfo_children():
            widget.destroy()
        self.create_ped_light(self.ped_light_ew, pedestrian_light_ew_color)
        if (pedestrian_light_ew_color != 'amber'):
            self.intersection.create_rectangle(20, 0, 85, 20, fill=pedestrian_light_ew_color);
            self.intersection.create_rectangle(20, 85, 85, 105, fill=pedestrian_light_ew_color);
        
        

#############
# FUNC DEFS #
#############
def reset(dev):
    #clk_div_rst
	dev.setWire(0x03, 0xFF, 0x01)
	dev.setWire(0x03, 0x00, 0x01)
    #timer_rst
	dev.setWire(0x04, 0xFF, 0x01)
	dev.setWire(0x04, 0x00, 0x01)


########
# MAIN #
########
def main():

    #Declare and init device
    dev = xem.Device(True)
    result = dev.Initialize()
    dev.setupClock() 

    #Deploy bitstream to FPGA
    bitfile = "tlc_top.bit"
    if (dev.downloadFile(bitfile) == False):
        exit(1)

    reset(dev)
    root = Tk()
    app = TrafficLightsApp(root, dev)
    root.mainloop()

if __name__ == "__main__":
    main()
