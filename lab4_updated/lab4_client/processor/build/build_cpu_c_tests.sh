#!/bin/bash

# Build script for cpu_tests_tb with c_instr.mem and c_data.mem

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROCESSOR_DIR="$(dirname "$SCRIPT_DIR")"
TB_DIR="$PROCESSOR_DIR/tb"
SOURCE_DIR="$PROCESSOR_DIR/source"
TESTS_DIR="$PROCESSOR_DIR/tests"

cd "$PROCESSOR_DIR"

echo "Building cpu_tests_tb with c_instr.mem and c_data.mem..."

# Compile all source files
xvlog -sv \
    "$SOURCE_DIR/cpu.svh" \
    "$SOURCE_DIR/reg_reset.sv" \
    "$SOURCE_DIR/reg_en.sv" \
    "$SOURCE_DIR/mux.sv" \
    "$SOURCE_DIR/sign_extend.sv" \
    "$SOURCE_DIR/barrel_shifter.sv" \
    "$SOURCE_DIR/alu.sv" \
    "$SOURCE_DIR/reg_file.sv" \
    "$SOURCE_DIR/rw_ram.sv" \
    "$SOURCE_DIR/control_unit.sv" \
    "$SOURCE_DIR/cpu.sv" \
    "$TB_DIR/cpu_tests_tb.sv" \
    -d INSTR_MEM_FILE=\"tests/c_instr.mem\" \
    -d DATA_MEM_FILE=\"tests/c_data.mem\" \
    -d MAX_CYCLES=2000

if [ $? -ne 0 ]; then
    echo "❌ Compilation failed"
    exit 1
fi

echo "✓ Compilation successful"

# Elaborate
xelab -debug typical cpu_tests_tb -s cpu_tests_tb_sim

if [ $? -ne 0 ]; then
    echo "❌ Elaboration failed"
    exit 1
fi

echo "✓ Elaboration successful"

# Run simulation
xsim cpu_tests_tb_sim -runall

if [ $? -ne 0 ]; then
    echo "❌ Simulation failed"
    exit 1
fi

echo "✓ Simulation completed successfully"

