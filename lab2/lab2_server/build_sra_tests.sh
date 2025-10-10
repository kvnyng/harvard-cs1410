#!/bin/bash

# SRA Module Build and Test Script
# This script compiles and tests the SRA module

echo "=========================================="
echo "SRA BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test SRA module
echo ""
echo "=========================================="
echo "TESTING SRA MODULE"
echo "=========================================="

echo "Compiling SRA module and testbench..."
xvlog -sv source/mux.sv source/sra.sv tb/sra_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating SRA testbench..."
    xelab -debug typical sra_tb -s sra_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running SRA simulation..."
        xsim -runall sra_sim
        
        if [ $? -eq 0 ]; then
            echo "✓ SRA simulation completed successfully"
        else
            echo "✗ SRA simulation failed"
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
echo "✓ SRA module: PASSED"
echo "SRA logic tested:"
echo "  - Arithmetic right shift (sign-preserving)"
echo "  - Positive numbers: Fill with 0s (like SRL)"
echo "  - Negative numbers: Fill with 1s (preserve sign)"
echo "  - Various shift amounts (0-31)"
echo "  - Edge cases and boundary conditions"
echo "VCD file generated for waveform viewing: sra_tb.vcd"
echo "=========================================="

