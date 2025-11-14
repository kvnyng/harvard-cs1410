#!/bin/bash

# CPU Main Memory Testbench Build and Simulation Script
# This script compiles and runs the CPU memory testbench

echo "=== CPU Main Memory Testbench Build Script ==="
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
echo "  - Compiling cpu.svh (macros and definitions)"
echo "  - Compiling rw_ram.sv (memory module)"
echo "  - Compiling cpu.sv (CPU module with memory)"
echo "  - Compiling cpu_main_memory_tb.sv (testbench)"

xvlog -sv source/cpu.svh source/rw_ram.sv source/cpu.sv tb/cpu_main_memory_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed"
    exit 1
fi

# Step 2: Elaborate the design
echo ""
echo "Step 2: Elaborating design..."
echo "  - Creating simulation executable: cpu_main_memory_tb_sim"
echo "  - Enabling debug features"

xelab cpu_main_memory_tb -s cpu_main_memory_tb_sim -debug typical

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
echo "  - Testing instruction memory loading"
echo "  - Testing data memory loading"
echo "  - Verifying memory read/write operations"

xsim cpu_main_memory_tb_sim -R

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

