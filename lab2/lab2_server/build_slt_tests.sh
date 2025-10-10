#!/bin/bash

# SLT Module Build and Test Script
# This script compiles and tests the SLT module

echo "=========================================="
echo "SLT BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test SLT module
echo ""
echo "=========================================="
echo "TESTING SLT MODULE"
echo "=========================================="

echo "Compiling SLT module and testbench..."
xvlog -sv source/slt.sv tb/slt_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating SLT testbench..."
    xelab -debug typical slt_tb -s slt_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running SLT simulation..."
        xsim -runall slt_sim
        
        if [ $? -eq 0 ]; then
            echo "✓ SLT simulation completed successfully"
        else
            echo "✗ SLT simulation failed"
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
echo "✓ SLT module: PASSED"
echo "SLT logic tested:"
echo "  - MSB XOR overflow logic for signed comparison"
echo "  - 32-bit output with LSB as SLT result"
echo "  - All upper bits set to 0"
echo "VCD file generated for waveform viewing: slt_tb.vcd"
echo "=========================================="
