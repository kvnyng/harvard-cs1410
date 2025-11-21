#!/bin/bash

# Build script for CPU reset testbench

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

echo "Building CPU Reset Testbench..."

# Clean up previous simulation files
rm -rf xsim.dir
rm -rf .Xil
rm -f *.log
rm -f *.jou
rm -f dead_memory.mem
rm -f data.mem

# Compile
echo "Compiling..."
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
    tb/cpu_reset_tb.sv

if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Elaborate
echo "Elaborating..."
xelab cpu_reset_tb -s cpu_reset_tb_sim -debug typical

if [ $? -ne 0 ]; then
    echo "Elaboration failed"
    exit 1
fi

# Run simulation
echo "Running simulation..."
xsim cpu_reset_tb_sim -R

echo "Simulation complete"


