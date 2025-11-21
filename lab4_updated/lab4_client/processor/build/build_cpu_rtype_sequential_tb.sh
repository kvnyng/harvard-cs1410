#!/bin/bash

# CPU Sequential R-Type Instructions Testbench Build and Simulation Script
# This script compiles and runs the CPU sequential R-type testbench

echo "=== CPU Sequential R-Type Instructions Testbench Build Script ==="
echo "Starting build and simulation process..."

# Set error handling
set -e

# Clean up any previous simulation files
echo "Cleaning up previous simulation files..."
rm -rf xsim.dir
rm -rf .Xil
rm -f *.log
rm -f *.jou

# Copy memory files to current directory if they exist
if [ -f "tb/asm/rtype_test_instr.mem" ]; then
    cp tb/asm/rtype_test_instr.mem dead_memory.mem 2>/dev/null || true
fi
if [ -f "tb/asm/rtype_test_data.mem" ]; then
    cp tb/asm/rtype_test_data.mem data.mem 2>/dev/null || true
fi

# Step 1: Compile all SystemVerilog files
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
echo "  - Compiling cpu_rtype_sequential_tb.sv (testbench)"

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
    tb/cpu_rtype_sequential_tb.sv

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed"
    exit 1
fi

# Step 2: Elaborate the design
echo ""
echo "Step 2: Elaborating design..."
echo "  - Creating simulation executable: cpu_rtype_sequential_tb_sim"
echo "  - Enabling debug features"

xelab cpu_rtype_sequential_tb -s cpu_rtype_sequential_tb_sim -debug typical

if [ $? -eq 0 ]; then
    echo "✓ Elaboration successful"
else
    echo "✗ Elaboration failed"
    exit 1
fi

# Step 3: Run the simulation
echo ""
echo "Step 3: Running simulation..."
echo "  - Executing sequential R-type instruction testbench"
echo "  - Testing multiple R-type instructions in sequence"
echo "  - Verifying register file contents after execution"
echo "  - Testing edge cases and boundary conditions"

xsim cpu_rtype_sequential_tb_sim -R

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

