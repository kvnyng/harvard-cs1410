#!/bin/bash

# Traffic Light Controller Build and Simulation Script
# This script compiles and runs the TLC testbench

echo "=== Traffic Light Controller Build Script ==="
echo "Starting build and simulation process..."

# Set error handling
set -e

# Clean up any previous simulation files
echo "Cleaning up previous simulation files..."
rm -rf xsim.dir
rm -rf .Xil
rm -f *.log
rm -f *.jou

# Step 1: Compile all SystemVerilog files
echo "Step 1: Compiling SystemVerilog files..."
echo "  - Compiling tlc.svh (macros)"
echo "  - Compiling tlc.sv (main controller)"
echo "  - Compiling timer.sv (timer module)"
echo "  - Compiling clk_divider.sv (clock divider)"
echo "  - Compiling tlc_tb.sv (testbench)"

xvlog -sv source/tlc.svh source/tlc.sv source/timer.sv source/clk_divider.sv tb/tlc_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed"
    exit 1
fi

# Step 2: Elaborate the design
echo ""
echo "Step 2: Elaborating design..."
echo "  - Creating simulation executable: tlc_tb_sim"
echo "  - Enabling debug features"

xelab tlc_tb -s tlc_tb_sim -debug typical

if [ $? -eq 0 ]; then
    echo "✓ Elaboration successful"
else
    echo "✗ Elaboration failed"
    exit 1
fi

# Step 3: Run the simulation
echo ""
echo "Step 3: Running simulation..."
echo "  - Executing comprehensive testbench"
echo "  - Testing all state transitions"
echo "  - Verifying sensor-based timing"
echo "  - Testing reset functionality"

xsim tlc_tb_sim -R

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Simulation completed successfully"
    echo "=== Build and Simulation Complete ==="
else
    echo ""
    echo "✗ Simulation failed"
    exit 1
fi

# Optional: Clean up simulation files after successful run
echo ""
echo "Cleaning up simulation files..."
rm -rf xsim.dir
rm -rf .Xil
rm -f *.log
rm -f *.jou

echo "Build script completed successfully!"
