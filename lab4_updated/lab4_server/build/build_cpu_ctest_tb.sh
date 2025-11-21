#!/bin/bash

# CPU C-Test Testbench Build and Simulation Script
# This script compiles and runs the CPU c_test testbench with comparison

echo "=== CPU C-Test Testbench Build Script ==="
echo "Starting build and simulation process..."

# Set error handling
set -e

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Clean up any previous simulation files
echo "Cleaning up previous simulation files..."
rm -rf xsim.dir
rm -rf .Xil
rm -f *.log
rm -f *.jou

# Step 1: Compile all SystemVerilog files
echo ""
echo "Step 1: Compiling SystemVerilog files..."
echo "  - Compiling cpu.svh (macros and definitions)"
echo "  - Compiling reg_en.sv (register with enable)"
echo "  - Compiling reg_reset.sv (register with reset)"
echo "  - Compiling reg_file.sv (register file)"
echo "  - Compiling alu.sv (ALU)"
echo "  - Compiling rw_ram.sv (memory)"
echo "  - Compiling mux.sv (multiplexers)"
echo "  - Compiling sign_extend.sv (sign extender)"
echo "  - Compiling barrel_shifter.sv (barrel shifter)"
echo "  - Compiling control_unit.sv (control unit FSM)"
echo "  - Compiling cpu.sv (CPU module)"
echo "  - Compiling cpu_ctest_tb.sv (testbench)"

xvlog -sv \
    source/cpu.svh \
    source/reg_en.sv \
    source/reg_reset.sv \
    source/reg_file.sv \
    source/alu.sv \
    source/rw_ram.sv \
    source/mux.sv \
    source/sign_extend.sv \
    source/barrel_shifter.sv \
    source/control_unit.sv \
    source/cpu.sv \
    tb/cpu_ctest_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed"
    exit 1
fi

# Step 2: Elaborate the design
echo ""
echo "Step 2: Elaborating design..."
echo "  - Creating simulation executable: cpu_ctest_tb_sim"
echo "  - Enabling debug features"

xelab cpu_ctest_tb -s cpu_ctest_tb_sim -debug typical

if [ $? -eq 0 ]; then
    echo "✓ Elaboration successful"
else
    echo "✗ Elaboration failed"
    exit 1
fi

# Step 3: Run the simulation
echo ""
echo "Step 3: Running simulation..."
echo "  - Executing c_test testbench"
echo "  - Loading instructions from tests/c_instr.mem"
echo "  - Loading data from tests/c_data.mem"
echo "  - Comparing against tests/c_test_out.txt"
echo ""

xsim cpu_ctest_tb_sim -R

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

