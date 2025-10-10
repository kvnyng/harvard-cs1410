#!/bin/bash

# SRL Module Build and Test Script
# This script compiles and tests the SRL module

echo "=========================================="
echo "SRL BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test SRL module
echo ""
echo "=========================================="
echo "TESTING SRL MODULE"
echo "=========================================="

echo "Compiling SRL module and testbench..."
xvlog -sv source/mux.sv source/srl.sv tb/srl_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating SRL testbench..."
    xelab -debug typical srl_tb -s srl_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running SRL simulation..."
        xsim -runall srl_sim
        
        if [ $? -eq 0 ]; then
            echo "✓ SRL simulation completed successfully"
        else
            echo "✗ SRL simulation failed"
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
echo "✓ SRL module: PASSED"
echo "SRL logic tested:"
echo "  - Logical right shift (zero-fill)"
echo "  - Various shift amounts (0-31)"
echo "  - Edge cases and boundary conditions"
echo "VCD file generated for waveform viewing: srl_tb.vcd"
echo "=========================================="
