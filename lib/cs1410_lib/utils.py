###########
# IMPORTS #
###########
# Default libs
import os
import sys
import string
import argparse
import importlib

###############
# COLOR TOOLS #
###############
# Define terminal colors
class bcolors:
    ERROR = '\033[91m'
    INFO = '\033[96m'
    WARNING = '\033[93m'
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    BOLD_END = '\033[0m'
    UNDERLINE = '\033[4m'

# Color printing lambdas
eprint = lambda x: print(f"{bcolors.ERROR}{bcolors.BOLD}{x}{bcolors.ENDC}")
hprint = lambda x: print(f"{bcolors.HEADER}{x}{bcolors.ENDC}")
gprint = lambda x: print(f"{bcolors.OKGREEN}{x}{bcolors.ENDC}")
cprint = lambda x: print(f"{bcolors.INFO}{x}{bcolors.ENDC}")

# Various printing functions
def print_error(*x):
    print(f"{bcolors.ERROR}{bcolors.BOLD}ERROR: {bcolors.BOLD_END}{' '.join(list(map(str,x)))}{bcolors.ENDC}")
def print_info(*x): 
    print(f"{bcolors.INFO}{bcolors.BOLD}INFO: {bcolors.BOLD_END}{' '.join(list(map(str,x)))}{bcolors.ENDC}")
def print_warn(*x):
    print(f"{bcolors.WARNING}{bcolors.BOLD}WARNING: {bcolors.BOLD_END}{' '.join(list(map(str,x)))}{bcolors.ENDC}")
def print_header(*x):
    print(f"\n{bcolors.HEADER}{bcolors.BOLD}{' '.join(list(map(str,x)))}{bcolors.ENDC}")

####################
# HELPER FUNCTIONS #
####################
def import_oklib(verbose=False):
    # Detect OS
    if sys.platform.startswith('linux'):
        my_os = "ubuntu_22_04"
    elif sys.platform.startswith('win32') or sys.platform.startswith('cygwin'):
        my_os = "windows"
    elif sys.platform.startswith('darwin'):
        my_os = "macOS"
    else:
        print_error("ERROR: Unknown operating system. Returning ERROR")
        return -1
    my_module = my_os + ".ok"  
    if verbose:
        print_info("Detected OS:", my_os)
        print_info("Loading oklib:", my_module)

    # Import the correct ok library
    try:
        return importlib.import_module(my_module) # similar to "import my_module as ok", but my_module doesn't have to be a string literal
    except ModuleNotFoundError:
        print_error("Module", my_module, "not found")
    except Exception as e:
        print_error(e)
