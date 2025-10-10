#!/bin/bash

# =============================================================================
# ALU BUILD AND TEST SCRIPT
# =============================================================================
# 
# This script compiles and tests the ALU module for implemented operations:
# 1. AND - 32-bit bitwise AND operation
# 2. ADD - 32-bit signed addition using RCA
# 3. SUB - 32-bit signed subtraction using two's complement
# 4. SLT - Set Less Than using MSB XOR overflow logic
# 5. SRL - Shift Right Logical (zero-fill)
# 6. SRA - Shift Right Arithmetic (sign-fill)
# 7. SLL - Shift Left Logical (zero-fill)
# 
# Usage: ./build_alu_tests.sh
# =============================================================================

echo "=========================================="
echo "ALU BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test ALU
echo ""
echo "=========================================="
echo "TESTING ALU MODULE"
echo "=========================================="

echo "Compiling ALU module and testbench..."
xvlog -sv source/alu.svh source/primitives32.sv source/adder.sv source/mux.sv source/flags.sv source/slt.sv source/srl.sv source/sra.sv source/sll.sv source/alu.sv tb/alu_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating ALU testbench..."
    xelab -debug typical alu_tb -s alu_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running ALU simulation..."
        xsim alu_sim -runall
        
        if [ $? -eq 0 ]; then
            echo "✓ ALU simulation completed successfully"
        else
            echo "✗ ALU simulation failed"
            exit 1
        fi
    else
        echo "✗ ALU elaboration failed"
        exit 1
    fi
else
    echo "✗ ALU compilation failed"
    exit 1
fi

# Summary
echo ""
echo "=========================================="
echo "BUILD AND TEST SUMMARY"
echo "=========================================="
echo "✓ ALU module: PASSED"
echo ""
echo "Implemented operations tested:"
echo "  - AND: 32-bit bitwise AND"
echo "  - ADD: 32-bit signed addition (RCA)"
echo "  - SUB: 32-bit signed subtraction (two's complement)"
echo "  - SLT: Set Less Than (MSB XOR overflow logic)"
echo "  - SRL: Shift Right Logical (zero-fill)"
echo "  - SRA: Shift Right Arithmetic (sign-fill)"
echo "  - SLL: Shift Left Logical (zero-fill)"
echo ""
echo "Flag testing:"
echo "  - Zero flag: Tested for all operations"
echo "  - Equal flag: Tested for all operations"
echo "  - Overflow flag: Tested for ADD and SUB operations"
echo ""
echo "VCD file generated for waveform viewing: alu_tb.vcd"
echo "=========================================="
