#!/bin/bash

# =============================================================================
# ADDER MODULES BUILD AND TEST SCRIPT
# =============================================================================
# 
# This script compiles and tests the adder modules:
# 1. full_adder - 1-bit full adder with carry input
# 2. rca32 - 32-bit ripple-carry adder
# 
# Usage: ./build_adder_tests.sh
# =============================================================================

echo "=========================================="
echo "ADDER MODULES BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Test 1: Compile and test full_adder
echo ""
echo "=========================================="
echo "TESTING FULL ADDER MODULE"
echo "=========================================="

echo "Compiling full_adder module and testbench..."
xvlog -sv source/adder.sv tb/full_adder_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating full_adder testbench..."
    xelab -debug typical full_adder_tb -s full_adder_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running full_adder simulation..."
        xsim full_adder_sim -runall
        
        if [ $? -eq 0 ]; then
            echo "✓ full_adder simulation completed successfully"
        else
            echo "✗ full_adder simulation failed"
            exit 1
        fi
    else
        echo "✗ full_adder elaboration failed"
        exit 1
    fi
else
    echo "✗ full_adder compilation failed"
    exit 1
fi

# Test 2: Compile and test rca32
echo ""
echo "=========================================="
echo "TESTING RCA32 MODULE"
echo "=========================================="

echo "Compiling rca32 module and testbench..."
xvlog -sv source/adder.sv tb/rca32_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating rca32 testbench..."
    xelab -debug typical rca32_tb -s rca32_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running rca32 simulation..."
        xsim rca32_sim -runall
        
        if [ $? -eq 0 ]; then
            echo "✓ rca32 simulation completed successfully"
        else
            echo "✗ rca32 simulation failed"
            exit 1
        fi
    else
        echo "✗ rca32 elaboration failed"
        exit 1
    fi
else
    echo "✗ rca32 compilation failed"
    exit 1
fi

# Summary
echo ""
echo "=========================================="
echo "BUILD AND TEST SUMMARY"
echo "=========================================="
echo "✓ full_adder module: PASSED"
echo "✓ rca32 module: PASSED"
echo ""
echo "All adder modules have been successfully tested!"
echo "VCD files generated for waveform viewing:"
echo "  - full_adder_tb.vcd"
echo "  - rca32_tb.vcd"
echo "=========================================="
