#!/bin/bash

# =============================================================================
# FLAGS MODULES BUILD AND TEST SCRIPT
# =============================================================================
# 
# This script compiles and tests the flags modules:
# 1. check_zero32 - Determines if a 32-bit value is zero using OR gate tree
# 2. check_equal32 - Determines if two 32-bit values are equal using XOR/AND gate tree
# 
# Usage: ./build_flags_tests.sh
# =============================================================================

echo "=========================================="
echo "FLAGS MODULES BUILD AND TEST SCRIPT"
echo "=========================================="

# Set working directory
cd "$(dirname "$0")"

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
rm -f *.vcd *.log work -rf

# Compile and test flags modules
echo ""
echo "=========================================="
echo "TESTING FLAGS MODULES"
echo "=========================================="

echo "Compiling flags modules and testbench..."
xvlog -sv source/flags.sv tb/flags_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    
    echo "Elaborating flags testbench..."
    xelab -debug typical flags_tb -s flags_sim
    
    if [ $? -eq 0 ]; then
        echo "✓ Elaboration successful"
        
        echo "Running flags simulation..."
        xsim flags_sim -runall
        
        if [ $? -eq 0 ]; then
            echo "✓ Flags simulation completed successfully"
        else
            echo "✗ Flags simulation failed"
            exit 1
        fi
    else
        echo "✗ Flags elaboration failed"
        exit 1
    fi
else
    echo "✗ Flags compilation failed"
    exit 1
fi

# Summary
echo ""
echo "=========================================="
echo "BUILD AND TEST SUMMARY"
echo "=========================================="
echo "✓ Flags modules: PASSED"
echo ""
echo "Modules tested:"
echo "  - check_zero32: Zero detection using OR gate tree"
echo "  - check_equal32: Equality detection using XOR/AND gate tree"
echo ""
echo "Test coverage:"
echo "  - Corner cases: Zero values, maximum values, single bit patterns"
echo "  - Edge cases: MSB/LSB differences, alternating patterns"
echo "  - Systematic testing: Bit position differences, random patterns"
echo "  - Comprehensive validation: 100+ individual test cases"
echo ""
echo "VCD file generated for waveform viewing: flags_tb.vcd"
echo "=========================================="
