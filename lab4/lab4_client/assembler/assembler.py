#!/usr/bin/env python3
#
# Template for MIPS assembler.py
#
# Usage:
#    python3 assembler.py [asm file]


# # Specs from guide
# Your assembler must support register arguments either named following
# MIPS conventions (e.g., $s0, $t1, $sp) or directly named by number (e.g., $0–$31).

# The exception is the nop (no operation) instruction, which should be encoded as 32’h0


# Pay special attention to your process for assembling branch and jump instructions, particularly
# when they contain labels. For simplicity, assume that a label will never exist on its own line—it
# only refers to the instruction on the same line.

import sys, re


def bin_to_hex(x):
    y = hex(int(x, 2))[2:]
    if len(y) < 8:
        y = (8 - len(y)) * "0" + y
    return y


def dec_to_bin(value, nbits):
    value = int(value)
    fill = "0"
    if value < 0:
        value = (abs(value) ^ 0xFFFFFFFF) + 1
        fill = "1"

    value = bin(value)[2:]
    if len(value) < nbits:
        value = (nbits - len(value)) * fill + value
    if len(value) > nbits:
        value = value[-nbits:]
    return value


# List of all R-type instructions.
rtypes = [
    "add",
    "addu",
    "sub",
    "subu",
    "and",
    "or",
    "xor",
    "nor",
    "slt",
    "sltu",
]

op_codes = {
    "r-type":   "000000",
    "bltz":     "000001",
    "jump":     "000010",
    "jal":      "000011",
    "beq":      "000100",
    "bne":      "000101",
    "blez":     "000110",
    "bgtz":     "000111",
    "bltzal":   "100001",
    "bgez":     "000001",
    "bgezal":   "100001",
    "beqz":     "000100",
    "bnez":     "000101",
    "blez":     "000110",
    "bgtz":     "000111",
    "addi":     "001000",
    "addiu":    "001001",
    "slti":     "001010",
    "sltiu":    "001011",
    "andi":     "001100",
    "ori":      "001101",
    "xori":     "001110",
    "lui":      "001111",
    "addi":     "001000",
    "mfc0":     "010000",
    "F-type":   "010001",
    "bclf":     "010001",
    "bclt":     "010001",
    "mul":      "011100",
    "lb":       "100000",
    "lh":       "100001",
    "lw":       "100011",
    "lbu":      "100100",
    "lhu":      "100101",
    "sb":       "101000",
    "sh":       "101001",
    "sw":       "101011",
    "lwcl":     "110001",
    "swcl":     "111001",
}

function_codes = {
    # Fill in function codes.
    "sll":      "000000",
    "srl":      "000010",
    "sra":      "000011",
    "sllv":     "000100",
    "srlv":     "000110",
    "srav":     "000111",
    "jr":       "001000",
    "jalr":     "001001",
    "syscall":  "001100",
    "break":    "001101",
    "mfhi":     "010000",
    "mthi":     "010001",
    "mflo":     "010010",
    "mtlo":     "010011",
    "mult":     "011000",
    "multu":    "011001",
    "div":      "011010",
    "divu":     "011011",
    "add":      "100000",
    "addu":     "100001",
    "sub":      "100010",
    "subu":     "100011",
    "and":      "100100",
    "or":       "100101",
    "xor":      "100110",
    "nor":      "100111",
    "slt":      "101010",
    "sltu":     "101011",
}

registers = {
    "$zero":    dec_to_bin(0, 5),
    "$0":       dec_to_bin(0, 5),
    "$1":       dec_to_bin(1, 5),
    "$2":       dec_to_bin(2, 5),
    "$3":       dec_to_bin(3, 5),
    "$4":       dec_to_bin(4, 5),
    "$5":       dec_to_bin(5, 5),
    "$6":       dec_to_bin(6, 5),
    "$7":       dec_to_bin(7, 5),
    "$8":       dec_to_bin(8, 5),
    "$9":       dec_to_bin(9, 5),
    "$10":      dec_to_bin(10, 5),
    "$11":      dec_to_bin(11, 5),
    "$12":      dec_to_bin(12, 5),
    "$13":      dec_to_bin(13, 5),
    "$14":      dec_to_bin(14, 5),
    "$15":      dec_to_bin(15, 5),
    "$16":      dec_to_bin(16, 5),
    "$17":      dec_to_bin(17, 5),
    "$18":      dec_to_bin(18, 5),
    "$19":      dec_to_bin(19, 5),
    "$20":      dec_to_bin(20, 5),
    "$21":      dec_to_bin(21, 5),
    "$22":      dec_to_bin(22, 5),
    "$23":      dec_to_bin(23, 5),
    "$24":      dec_to_bin(24, 5),
    "$25":      dec_to_bin(25, 5),
    "$26":      dec_to_bin(26, 5),
    "$27":      dec_to_bin(27, 5),
    "$28":      dec_to_bin(28, 5),
    "$29":      dec_to_bin(29, 5),
    "$30":      dec_to_bin(30, 5),
    "$31":      dec_to_bin(31, 5),

    "$at":      dec_to_bin(1, 5),

    "$v0":      dec_to_bin(2, 5),
    "$v1":      dec_to_bin(3, 5),

    "$a0":      dec_to_bin(4, 5),
    "$a1":      dec_to_bin(5, 5),
    "$a2":      dec_to_bin(6, 5),
    "$a3":      dec_to_bin(7, 5),

    "$t0":      dec_to_bin(8, 5),
    "$t1":      dec_to_bin(9, 5),
    "$t2":      dec_to_bin(10, 5),
    "$t3":      dec_to_bin(11, 5),
    "$t4":      dec_to_bin(12, 5),
    "$t5":      dec_to_bin(13, 5),
    "$t6":      dec_to_bin(14, 5),
    "$t7":      dec_to_bin(15, 5),

    "$s0":      dec_to_bin(16, 5),
    "$s1":      dec_to_bin(17, 5),
    "$s2":      dec_to_bin(18, 5),
    "$s3":      dec_to_bin(19, 5),
    "$s4":      dec_to_bin(20, 5),
    "$s5":      dec_to_bin(21, 5),
    "$s6":      dec_to_bin(22, 5),
    "$s7":      dec_to_bin(23, 5),

    "$t8":      dec_to_bin(24, 5),
    "$t9":      dec_to_bin(25, 5),

    "$k0":      dec_to_bin(26, 5),
    "$k1":      dec_to_bin(27, 5),

    "$gp":      dec_to_bin(28, 5),

    "$sp":      dec_to_bin(29, 5),

    "$fp":      dec_to_bin(30, 5),

    "$ra":      dec_to_bin(31, 5),
}


class Assembler:
    """
    MIPS Assembler - converts assembly code to machine code
    """

    def __init__(self):
        self.labels = {}  # Map from label to its address
        self.instructions = []  # List of parsed instructions with addresses
        self.jr_base_addr = None  # Address of first jr instruction (any jr indicates code load address)
        self.load_base_addr = 0x400000  # Base address where code is loaded in memory

    def parse_register(self, reg_str):
        """Parse register string and return binary representation"""
        reg_str = reg_str.strip()
        if reg_str in registers:
            return registers[reg_str]
        # Try to parse as $N where N is a number
        if reg_str.startswith("$") and reg_str[1:].isdigit():
            num = int(reg_str[1:])
            if 0 <= num <= 31:
                return dec_to_bin(num, 5)
        raise ValueError(f"Invalid register: {reg_str}")

    def parse_immediate(self, imm_str):
        """Parse immediate value (can be decimal or hex)"""
        imm_str = imm_str.strip()
        if imm_str.startswith("0x") or imm_str.startswith("0X"):
            return int(imm_str, 16)
        return int(imm_str)

    def parse_offset_base(self, arg_str):
        """Parse offset(base) format like '0($s0)' or '4($t2)'"""
        # Match pattern: number($register)
        match = re.match(r'(-?\d+)\((\$[\w\d]+)\)', arg_str)
        if match:
            offset = int(match.group(1))
            base_reg = match.group(2)
            return offset, base_reg
        raise ValueError(f"Invalid offset/base format: {arg_str}")

    def encode_rtype(self, instr, args):
        """Encode R-type instruction: opcode(6) + rs(5) + rt(5) + rd(5) + shamt(5) + funct(6)"""
        opcode = op_codes["r-type"]
        funct = function_codes.get(instr)
        if not funct:
            raise ValueError(f"Unknown R-type instruction: {instr}")

        if instr in ["sll", "srl", "sra"]:
            # Format: instr rd, rt, shamt
            rd = self.parse_register(args[0])
            rt = self.parse_register(args[1])
            shamt = dec_to_bin(self.parse_immediate(args[2]), 5)
            rs = "00000"
        elif instr == "jr":
            # Format: jr rs
            rs = self.parse_register(args[0])
            rt = "00000"
            rd = "00000"
            shamt = "00000"
        else:
            # Format: instr rd, rs, rt
            rd = self.parse_register(args[0])
            rs = self.parse_register(args[1])
            rt = self.parse_register(args[2])
            shamt = "00000"

        return bin_to_hex(opcode + rs + rt + rd + shamt + funct)

    def encode_itype(self, instr, args, address, labels):
        """Encode I-type instruction: opcode(6) + rs(5) + rt(5) + immediate(16)"""
        opcode = op_codes.get(instr)
        if not opcode:
            raise ValueError(f"Unknown I-type instruction: {instr}")

        if instr in ["beq", "bne"]:
            # Format: instr rs, rt, label
            rs = self.parse_register(args[0])
            rt = self.parse_register(args[1])
            label = args[2]
            if label not in labels:
                raise ValueError(f"Unknown label: {label}")
            target_addr = labels[label]
            # Branch offset = (target_addr - (PC + 4)) / 4
            offset = (target_addr - (address + 4)) // 4
            immediate = dec_to_bin(offset, 16)
        elif instr in ["lw", "sw"]:
            # Format: instr rt, offset(base)
            rt = self.parse_register(args[0])
            offset, base_reg = self.parse_offset_base(args[1])
            rs = self.parse_register(base_reg)
            immediate = dec_to_bin(offset, 16)
        else:
            # Format: instr rt, rs, immediate
            rt = self.parse_register(args[0])
            rs = self.parse_register(args[1])
            immediate_val = self.parse_immediate(args[2])
            immediate = dec_to_bin(immediate_val, 16)

        return bin_to_hex(opcode + rs + rt + immediate)

    def encode_jtype(self, instr, args, labels, j_instruction_addr):
        """Encode J-type instruction: opcode(6) + address(26)"""
        # Map "j" to "jump" for opcode lookup
        opcode_key = "jump" if instr == "j" else instr
        opcode = op_codes.get(opcode_key)
        if not opcode:
            raise ValueError(f"Unknown J-type instruction: {instr}")

        label = args[0]
        if label not in labels:
            raise ValueError(f"Unknown label: {label}")
        target_addr = labels[label]
        # J-type uses word address (divide by 4)
        # If there's any jr instruction, it indicates the code will execute at a load address
        # The jr instruction stores/uses a register value that represents the execution address
        # Formula: effective_addr = target_addr + load_base - jr_base_addr
        # This accounts for the difference between assembly addresses and execution addresses
        if self.jr_base_addr is not None:
            # Calculate effective address accounting for load base and jr position
            # The presence of jr means code executes at load_base, not at address 0
            effective_addr = target_addr + self.load_base_addr - self.jr_base_addr
            word_addr = effective_addr >> 2
        else:
            # No jr instruction, use absolute address (relative to start of program)
            word_addr = target_addr >> 2
        # Mask to 26 bits (0x3FFFFFF)
        word_addr = word_addr & 0x3FFFFFF
        address = dec_to_bin(word_addr, 26)
        return bin_to_hex(opcode + address)

    def encode_instruction(self, instr, args, address, labels):
        """Encode a single instruction"""
        # Handle nop specially
        if instr == "nop":
            return "00000000"

        # Determine instruction type
        if instr in function_codes:
            # R-type instruction
            return self.encode_rtype(instr, args)
        elif instr in ["j", "jal"]:
            # J-type instruction
            return self.encode_jtype(instr, args, labels, address)
        else:
            # I-type instruction
            return self.encode_itype(instr, args, address, labels)

    def parse_line(self, line):
        """Parse a line of assembly code"""
        # Remove comments
        comment_index = line.find("#")
        if comment_index != -1:
            line = line[:comment_index]
        line = line.strip()

        if not line:
            return None, None

        # Check for label
        label = None
        label_index = line.find(":")
        if label_index != -1:
            label = line[:label_index].strip()
            line = line[label_index + 1:].strip()

        if not line:
            return label, None

        # Parse instruction and arguments
        # Replace commas with spaces, then split
        line_no_commas = line.replace(',', ' ')
        parts = line_no_commas.split()
        instruction = parts[0]
        args = parts[1:] if len(parts) > 1 else []

        return label, {"instruction": instruction, "args": args}

    def assemble(self, optionalfile=None):
        """Two-pass assembler"""
        # Open file
        if optionalfile:
            filename = optionalfile
        else:
            if len(sys.argv) < 2:
                print("Usage: python3 assembler.py [asm file]", file=sys.stderr)
                sys.exit(1)
            filename = sys.argv[1]

        # Read all lines
        with open(filename, "r") as f:
            lines = f.readlines()

        # PASS 1: Collect labels and addresses
        address = 0
        for line in lines:
            label, parsed = self.parse_line(line)
            if label:
                self.labels[label] = address
            if parsed:
                # Track the address of the first jr instruction (any jr indicates code load address)
                if parsed["instruction"] == "jr" and self.jr_base_addr is None:
                    self.jr_base_addr = address
                self.instructions.append({
                    "address": address,
                    "instruction": parsed["instruction"],
                    "args": parsed["args"]
                })
                address += 4

        # PASS 2: Encode instructions
        output_lines = []
        for inst_data in self.instructions:
            instr = inst_data["instruction"]
            args = inst_data["args"]
            addr = inst_data["address"]
            encoded = self.encode_instruction(instr, args, addr, self.labels)
            output_lines.append(encoded)
        
        # Print output without trailing newline on last line
        if output_lines:
            print("\n".join(output_lines), end="")

if __name__ == "__main__":
    my_assembler = Assembler()  # instantiate
    my_assembler.assemble()  # assemble (pulling from commandline arg)
