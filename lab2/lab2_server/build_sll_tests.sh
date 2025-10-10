#!/bin/bash

# SLL Module Build and Test Script
# This script compiles and tests the SLL module

echo "=========================================="
echo "SLL BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test SLL module
echo ""
echo "=========================================="
echo "TESTING SLL MODULE"
echo "=========================================="

echo "Compiling SLL module and testbench..."
xvlog -sv source/mux.sv source/sll.sv tb/sll_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating SLL testbench..."
    xelab -debug typical sll_tb -s sll_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running SLL simulation..."
        xsim -runall sll_sim
        
        if [ $? -eq 0 ]; then
            echo "✓ SLL simulation completed successfully"
        else
            echo "✗ SLL simulation failed"
            exit 1
        fi
    else
        echo "✗ Elaboration failed"
        exit 1
    fi
else
    echo "✗ Compilation failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "BUILD AND TEST SUMMARY"
echo "=========================================="
echo "✓ SLL module: PASSED"
echo "SLL logic tested:"
echo "  - Logical left shift (zero-fill on right)"
echo "  - Equivalent to multiplication by powers of 2"
echo "  - Various shift amounts (0-31)"
echo "  - Edge cases and overflow conditions"
echo "VCD file generated for waveform viewing: sll_tb.vcd"
echo "=========================================="

