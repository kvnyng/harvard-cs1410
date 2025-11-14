#!/usr/bin/env python3
#
# Template for MIPS assembler.py
#
# Usage:
#    python3 assembler.py [asm file]

import sys, re

def bin_to_hex(x):
    y = hex(int(x,2))[2:]
    if len(y) < 8:
        y = (8-len(y))*"0" + y
    return y

def dec_to_bin(value, nbits):
    value = int(value)
    fill = "0"
    if value < 0:
        value = (abs(value) ^ 0xffffffff) + 1
        fill = "1"

    value = bin(value)[2:]
    if len(value) < nbits:
        value = (nbits-len(value))*fill + value
    if len(value) > nbits:
        value = value[-nbits:]
    return value

rtypes = [
    # List of all R-type instructions.
]

op_codes = {
    # Fill in mapping from instruction to its opcode.
}

function_codes = {
    # Fill in function codes.
}

registers = {
    '$zero' : dec_to_bin(00, 5),
    # Fill out the rest of the registers.
}


class Assembler():
    '''
    TODO -- Assembler Description
    '''

    def assemble(self, optionalfile=None):
        labels = {}        # Map from label to its address.
        parsed_lines = []  # List of parsed instructions.
        address = 0        # Track the current address of the instruction.
        line_count = 0     # Number of lines.

        if optionalfile:
            f = open(optionalfile, "r")
        else:
            me, fname = sys.argv
            f = open(fname, "r")

        for line in f:
            line_count = line_count + 1

            # Stores attributes about the current line of code, like its label, line
            # number, instruction, and arguments.
            line_attr = {}

            # Handle comments, whitespace.

            if line:
                # We'll get you started here with line_count.
                line_attr['line_number'] = line_count

                # Handle labels
                # Parse the rest of the instruction and its register arguments.

                # Finally, add this dict to the complete list of instructions.
                parsed_lines.append(line_attr)
        f.close()

        machine = ""  # Current machine code word.

        for line in parsed_lines:
            if line['instruction'] == 'nop':
                print(8*'0')
            elif line['instruction'] in rtypes:
                print("r-type instructions here\n")
                # Encode an R-type instruction.
            else:
                # Encode a non-R-type instruction.
                print("non-r-type instructions here\n")



if __name__ == "__main__":
    my_assembler = Assembler()  # instantiate
    my_assembler.assemble()     # assemble (pulling from commandline arg)
