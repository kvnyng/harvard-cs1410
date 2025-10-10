#!/bin/bash

# =============================================================================
# CLA BUILD AND TEST SCRIPT
# =============================================================================
# 
# This script compiles and tests the CLA (Carry Look-Ahead Adder) module
# 
# Usage: ./build_cla_tests.sh
# =============================================================================

echo "=========================================="
echo "CLA BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test CLA
echo ""
echo "=========================================="
echo "TESTING CLA MODULE"
echo "=========================================="

echo "Compiling CLA module and testbench..."
xvlog -sv source/cla.sv tb/cla_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating CLA testbench..."
    xelab -debug typical cla_tb -s cla_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running CLA simulation..."
        xsim -runall cla_sim
        
        if [ $? -eq 0 ]; then
            echo "✓ CLA simulation completed successfully"
        else
            echo "✗ CLA simulation failed"
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

# Summary
echo ""
echo "=========================================="
echo "BUILD AND TEST SUMMARY"
echo "=========================================="
echo "✓ CLA module: PASSED"
echo ""
echo "CLA logic tested:"
echo "  - 32-bit carry look-ahead addition"
echo "  - Corner cases (0+0, max+max, etc.)"
echo "  - Overflow detection for signed arithmetic"
echo "  - Carry propagation testing"
echo "  - Edge cases and boundary conditions"
echo "  - Random pattern testing"
echo ""
echo "VCD file generated for waveform viewing: cla_tb.vcd"
echo "=========================================="

