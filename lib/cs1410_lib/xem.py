###########
# IMPORTS #
###########
# Default libs
import os
import sys

# OK and CS1410 libs
import cs1410_lib.utils as cs1410
ok = cs1410.import_oklib(verbose=True)

class Device:
	def __init__(self, verbose=False):
		self.verbose = verbose
		return

	def __print(self, *obj, sep=' ', end='\n', file=sys.stdout, flush=False):
		if (self.verbose == True):
			print(*obj, sep=sep, end=end, file=file, flush=flush)

	def listDevices(self):
		return ok.FrontPanelDevices();

	def Initialize(self, serial=None):
		device = self.listDevices()
		if (device.GetCount() == 0):
			self.__print("No connected devices found!")
			return False
		
		if (serial == None):
			self.xem = device.Open() #Open the first device
		else:
			self.xem = device.Open(serial)

		if not self.xem:
			self.__print("Could not open the device!")
			return False
		
		return True

	def getInfo(self):
		# Get some general information about the device.
		self.devInfo = ok.okTDeviceInfo()
		if (self.xem.NoError != self.xem.GetDeviceInfo(self.devInfo)):
			print("Unable to retrieve device information.")
			return None
		
		return self.devInfo
	
	def setupClock(self):
		self.xem.LoadDefaultPLLConfiguration()

	def downloadFile(self, filename):
		# Download the configuration file.
		if (self.xem.NoError != self.xem.ConfigureFPGA(filename)):
			self.__print("Configuration failed.")
			return False
		return True

	def checkFrontPanel(self):
		# Check for FrontPanel support in the FPGA configuration.
		if (self.xem.IsFrontPanelEnabled() == False):
			self.__print("FrontPanel support is not available.")
			return False
		return True
	
	def pipeSize(self):
		if ~hasattr(self, 'devInfo'):
			self.getInfo();
		try:
			if (self.devInfo.deviceInterface == ok.OK_INTERFACE_USB2):
				return 2
			elif (self.devInfo.deviceInterface == ok.OK_INTERFACE_PCIE):
				return 8
			elif (self.devInfo.deviceInterface == ok.OK_INTERFACE_USB3):
				return 16
			else:
				return 2
		except:
			return 2
	
	def setWire(self, id, value, mask=0xffffffff):
		self.xem.SetWireInValue(id, value, mask)
		self.xem.UpdateWireIns()
	
	def getWire(self, id, mask=0xffffffff):
		self.xem.UpdateWireOuts()
		return self.xem.GetWireOutValue(id)
	
	def setTrigger(self, id, bit):
		self.xem.ActivateTriggerIn(id, bit)
	
	def checkTrigger(self, id, mask):
		self.xem.UpdateTriggerOuts()
		return self.xem.IsTriggered(id, mask)
	
	def writeBuffer(self, id, buffer):
		if (len(buffer) <= self.pipeSize()):
			extra = self.pipeSize() - len(buffer)
		else:
			#extra = len(buffer) % self.pipeSize() #yasmine commented out
			extra = self.pipeSize() - len(buffer) % self.pipeSize() #and replaced with this
		buffer += bytearray(extra) #Make buffer multiple of data-width (in bytes)
		self.xem.WriteToPipeIn(id, buffer) #Use this directly, no need to have x4 words, even if less than 4 words
	
	def writeString(self, id, text):
		buffer = bytearray(text.encode("ascii"))
		print("into hw")
		print(buffer)
		self.writeBuffer(id, buffer)
	
	def readBuffer(self, id, length):
		if (length <= self.pipeSize()):
			extra = self.pipeSize() - length
		else:
			extra = length % self.pipeSize()
		buffer = bytearray(length + extra) #Make buffer multiple of data-width (in bytes)
		self.xem.ReadFromPipeOut(id, buffer) #can define the number of bytes directly through the buffer bytedepth 
		return buffer[0:length]
	
	def readString(self, id, length):
		buffer = self.readBuffer(id, length)
		return buffer.decode("ascii")
		return buffer
