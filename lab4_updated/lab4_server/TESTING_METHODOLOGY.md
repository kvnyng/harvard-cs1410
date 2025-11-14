# MIPS Processor Testing Methodology

This document describes the comprehensive testing strategy used to verify the correctness of the MIPS processor implementation. The testing approach follows a bottom-up methodology, starting with individual component verification and progressing to full system integration tests.

## Table of Contents

1. [Overview](#overview)
2. [Individual Component Tests](#individual-component-tests)
3. [Integration Tests](#integration-tests)
4. [Holistic System Tests](#holistic-system-tests)
5. [Custom Benchmarks](#custom-benchmarks)
6. [Test Infrastructure](#test-infrastructure)
7. [Test Results and Validation](#test-results-and-validation)

---

## Overview

The testing methodology is structured in three main phases:

1. **Unit Testing**: Individual components are tested in isolation to verify their functionality
2. **Integration Testing**: Components are tested together to verify correct interaction
3. **System Testing**: Full processor is tested with complete programs against expected outputs

All tests use SystemVerilog testbenches with the Xilinx Vivado simulator (xsim). Test results are automatically validated against expected outputs.

---

## Individual Component Tests

### 1. Control Unit Test (`control_unit_r-type_tb.sv`)

**Purpose**: Verify the finite state machine (FSM) correctly generates control signals for R-type instructions.

**Test Coverage**:
- **State Transitions**: Verifies correct state progression (S0 → S1 → S2 → S0)
- **R-Type Instructions**: Tests all 10 R-type operations:
  - ADD, SUB, AND, OR, XOR, NOR
  - SLT (Set Less Than)
  - SLL, SRL, SRA (Shift operations)
- **Control Signal Verification**: Validates all control signals at each state:
  - `PCWrite`, `IRWrite`, `RegWrite`
  - `ALUSrcA`, `ALUSrcB`, `ALUControl`
  - `RegDst`, `MemToReg`, `PCSrc`
- **Non-R-Type Handling**: Verifies that non-R-type opcodes correctly return to S0 after S1

**Test Execution**:
```bash
./build/build_control_unit_tb.sh
```

**Key Test Cases**:
- Each R-type instruction is tested with specific opcode/funct combinations
- State snapshots are recorded and verified at each clock cycle
- Post-mortem analysis confirms correct FSM behavior

---

### 2. Multiplexer Test (`mux_tb.sv`)

**Purpose**: Verify correct selection behavior of all multiplexers used in the datapath.

**Test Coverage**:
- **4-to-1 Mux (2-bit)**: Tests all selection combinations (sel = 0, 1, 2, 3)
- **2-to-1 Mux (1-bit)**: Tests both selection paths
- **Edge Cases**: Tests with all zeros, all ones, and mixed patterns

**Test Execution**:
```bash
./build/build_mux_tb.sh
```

**Key Test Cases**:
- Each input is selected and verified
- Boundary conditions (sel = 0, sel = max)
- All input combinations

---

### 3. Sign Extender Test (`sign_extend_tb.sv`)

**Purpose**: Verify correct sign extension of 16-bit immediate values to 32 bits.

**Test Coverage**:
- **Positive Values (MSB = 0)**: Upper 16 bits should be zero
- **Negative Values (MSB = 1)**: Upper 16 bits should be ones (0xFFFF)
- **Boundary Cases**: 
  - Zero (0x0000)
  - Maximum positive (0x7FFF = 32767)
  - Minimum negative (0x8000 = -32768)
  - All ones (0xFFFF = -1)

**Test Execution**:
```bash
./build/build_sign_extend_tb.sh
```

**Key Test Cases**:
- `0x0000 → 0x00000000` (zero extension)
- `0x7FFF → 0x00007FFF` (positive, zero-extended)
- `0x8000 → 0xFFFF8000` (negative, sign-extended)
- `0xFFFF → 0xFFFFFFFF` (-1, sign-extended)

---

### 4. Barrel Shifter Test (`barrel_shifter_tb.sv`)

**Purpose**: Verify the barrel shifter correctly performs left shift by 2 positions.

**Test Coverage**:
- **Basic Shifts**: Powers of 2 and simple values
- **Large Values**: 32-bit values with various bit patterns
- **Edge Cases**: Maximum values, all ones, single bit patterns

**Test Execution**:
```bash
./build/build_barrel_shifter_tb.sh
```

**Key Test Cases**:
- `0x00000001 → 0x00000004` (1 << 2 = 4)
- `0x00000010 → 0x00000040` (16 << 2 = 64)
- `0xFFFFFFFF → 0xFFFFFFFC` (all ones shifted)

---

### 5. CPU Main Memory Test (`cpu_main_memory_tb.sv`)

**Purpose**: Verify the unified instruction/data memory (rw_ram) correctly handles reads and writes.

**Test Coverage**:
- **Instruction Memory Loading**: Verifies loading instructions at address 0x00400000
- **Data Memory Access**: Tests read/write operations in data memory space
- **Memory Separation**: Verifies instruction and data memory regions are correctly separated
- **Initialization**: Tests memory initialization from `.mem` files

**Test Execution**:
```bash
./build/build_cpu_memory_tb.sh
```

**Key Test Cases**:
- Write instruction at 0x00400000, read back and verify
- Write data at address 0x00000000, read back and verify
- Verify memory regions don't interfere with each other

---

## Integration Tests

### 1. R-Type Instruction Test (`cpu_rtype_tb.sv`)

**Purpose**: Test individual R-type instructions in isolation within the full CPU context.

**Test Coverage**:
- Each R-type instruction executed individually
- Register file updates verified after each instruction
- Tests both positive and negative results
- Edge cases (zero, overflow, underflow)

**Test Execution**:
```bash
./build/build_cpu_rtype_tb.sh
```

**Key Test Cases**:
- **ADD**: `$1 = $2 + $3` with various operand combinations
- **SUB**: `$1 = $2 - $3` including negative results
- **AND/OR/XOR/NOR**: Bitwise operations with various patterns
- **SLT**: Signed comparison with positive and negative numbers
- **SLL/SRL/SRA**: Shift operations with various shift amounts

---

### 2. Sequential R-Type Test (`cpu_rtype_sequential_tb.sv`)

**Purpose**: Test multiple R-type instructions executed in sequence to verify correct pipeline behavior and register dependencies.

**Test Coverage**:
- **Instruction Sequences**: Multiple R-type instructions chained together
- **Register Dependencies**: Later instructions use results from earlier ones
- **Register File Persistence**: Verifies registers maintain values between instructions
- **Complex Calculations**: Multi-step computations (e.g., `$2 = 5`, `$3 = 3`, `$4 = $2 + $3 = 8`)

**Test Execution**:
```bash
./build/build_cpu_rtype_sequential_tb.sh
```

**Key Test Cases**:
- Sequential ADD operations building up values
- Chained operations: `$2 = 5; $3 = 3; $4 = $2 + $3; $5 = $4 - $1`
- Register file state verification after each instruction

---

## Holistic System Tests

### Test Infrastructure

The holistic tests use `cpu_tests_tb.sv`, a comprehensive testbench that:
- Loads instruction memory from `.mem` files
- Loads data memory from `.mem` files (if provided)
- Executes the program for a maximum number of cycles
- Captures final register file state
- Compares results against expected outputs

**Test Execution**:
```bash
./build/run_all_tests.sh
```

This script automatically:
1. Discovers all test cases in the `tests/` directory
2. Compiles and simulates each test
3. Extracts register values from simulation output
4. Normalizes values (handles hex/decimal conversion)
5. Compares against expected outputs
6. Reports pass/fail status

---

### Provided Benchmarks

#### 1. R-Type Tests (`rtype_tests`)

**Source**: `tests/rtype_tests.asm`, `tests/rtype_tests_instr.mem`

**Description**: Comprehensive test of all R-type instructions in a single program.

**Test Program**:
```assembly
nor $t0, $zero, $zero     # $t0 = 0xFFFFFFFF (-1)
srl $t1, $t0, 31          # $t1 = 1
sll $t2, $t1, 1           # $t2 = 2
or  $t3, $t1, $t2         # $t3 = 3
sll $t4, $t3, 4           # $t4 = 48
sub $t5, $t4, $t1         # $t5 = 47
add $t6, $t5, $t3         # $t6 = 50
xor $t7, $t6, $t3         # $t7 = 49
and $t8, $t6, $t4         # $t8 = 48
nor $t9, $t8, $t3         # $t9 = 0xFFFFFFCC (-52)
sra $s0, $t9, 2           # $s0 = -13
srl $s1, $t9, 2           # $s1 = 0x3FFFFFF3
slt $s2, $t1, $t2         # $s2 = 1
and $s3, $t0, $t1         # $s3 = 1
nop                        # no operation
```

**Expected Results**: Verified against `tests/rtype_tests_out.txt`

**Coverage**:
- All 10 R-type instructions
- Register dependencies
- Signed and unsigned operations
- Shift operations (logical and arithmetic)

---

#### 2. B Test (`b_test`)

**Source**: `tests/b_test.asm`, `tests/b_instr.mem`, `tests/b_data.mem`

**Description**: Tests I-type instructions (ADDI, ANDI, ORI, XORI, SLTI) and data memory interactions.

**Test Program Features**:
- I-type immediate instructions
- Data memory initialization
- Register initialization with immediate values
- Bitwise operations with immediates

**Expected Results**: Verified against `tests/b_test_out.txt`

**Coverage**:
- I-type instruction encoding
- Immediate sign extension
- Data memory loading
- Register file updates from immediate operations

---

#### 3. C Test (`c_test`)

**Source**: `tests/c_test.asm`, `tests/c_instr.mem`, `tests/c_data.mem`

**Description**: More complex test including I-type instructions and some unimplemented instructions (LW, SW, BEQ, BNE, J).

**Test Program Features**:
- I-type instructions
- Memory operations (some unimplemented)
- Control flow instructions (some unimplemented)
- Complex data patterns

**Expected Results**: Verified against `tests/c_test_out.txt`

**Note**: Some registers are ignored in validation due to unimplemented instructions (LW, SW, BEQ, BNE, J) affecting registers 10, 17, 23, 24, 25.

**Coverage**:
- I-type instructions
- Memory addressing
- Partial implementation testing (identifies unimplemented features)

---

#### 4. Dead Registers Test (`dead_registers`)

**Source**: `tests/dead_registers_instr.mem`

**Description**: Fills all registers (except $0) with the pattern `0xFFFFDEAD` to verify register file functionality.

**Test Purpose**:
- Verifies all 31 writable registers can be written
- Confirms register $0 always remains zero
- Tests register file addressing

**Expected Behavior**:
- Registers $1-$31: `0xFFFFDEAD`
- Register $0: `0x00000000` (always zero)

---

## Custom Benchmarks

In addition to the provided benchmarks, several custom test programs were created to exercise specific functionality:

### 1. Sequential R-Type Test Program

**Location**: `tb/asm/rtype_test_instr.mem`

**Purpose**: Tests sequential execution of R-type instructions with register dependencies.

**Test Cases**:
- Multiple ADD operations in sequence
- Register chaining: `$2 = 5; $3 = 3; $4 = $2 + $3`
- Complex calculations using intermediate results

---

### 2. Memory Access Test Program

**Location**: `tb/asm/instr_1.mem`, `tb/asm/data_1.mem`

**Purpose**: Tests instruction and data memory separation and access patterns.

**Test Cases**:
- Instruction memory at 0x00400000
- Data memory at 0x00000000
- Verification that regions don't interfere

---

### 3. Edge Case Test Programs

**Custom test cases created to test**:
- **Zero Operations**: All operands are zero
- **Maximum Values**: Operations with 0x7FFFFFFF and 0x80000000
- **Overflow Conditions**: Addition/subtraction that causes overflow
- **Large Shifts**: Shift amounts at boundaries (0, 31)
- **All Ones Patterns**: Operations with 0xFFFFFFFF

---

## Test Infrastructure

### Build Scripts

Each component has a dedicated build script in `build/`:
- `build_control_unit_tb.sh`: Control unit FSM tests
- `build_cpu_rtype_tb.sh`: Individual R-type instruction tests
- `build_cpu_rtype_sequential_tb.sh`: Sequential R-type tests
- `build_cpu_memory_tb.sh`: Memory subsystem tests
- `build_mux_tb.sh`: Multiplexer tests
- `build_sign_extend_tb.sh`: Sign extender tests
- `build_barrel_shifter_tb.sh`: Barrel shifter tests
- `run_all_tests.sh`: Comprehensive test suite runner

### Test Execution Flow

1. **Compilation**: SystemVerilog files compiled with `xvlog`
2. **Elaboration**: Design elaborated with `xelab` (creates simulation executable)
3. **Simulation**: Testbench executed with `xsim`
4. **Validation**: Output parsed and compared against expected results
5. **Reporting**: Pass/fail status reported for each test

### Output Processing

The test infrastructure includes Python scripts embedded in `run_all_tests.sh` that:
- Extract register values from simulation output
- Normalize values (convert hex to decimal, handle unknown 'x' values)
- Filter out registers affected by unimplemented instructions
- Compare actual vs. expected register states
- Generate detailed diff reports on failures

---

## Test Results and Validation

### Validation Methodology

1. **Register File Comparison**: Final register file state is compared bit-by-bit against expected values
2. **Normalization**: Values are normalized to decimal for consistent comparison
3. **Selective Ignoring**: Registers affected by unimplemented instructions are excluded from comparison
4. **Cycle Counting**: Tests verify execution completes within maximum cycle limits

### Test Results Location

All test results are stored in `test_results/`:
- `*_compile.log`: Compilation logs
- `*_elab.log`: Elaboration logs
- `*_output.txt`: Full simulation output
- `*_regs.txt`: Extracted register values
- `*_expected_regs.txt`: Expected register values
- `*_regs_normalized.txt`: Normalized actual registers
- `*_expected_regs_normalized.txt`: Normalized expected registers

### Success Criteria

A test passes if:
1. Compilation and elaboration succeed without errors
2. Simulation completes within the maximum cycle limit
3. All register values (excluding ignored registers) match expected values exactly
4. No simulation errors or warnings occur

### Known Limitations

- **Unimplemented Instructions**: Tests for C test ignore registers affected by LW, SW, BEQ, BNE, J instructions
- **Cycle Limits**: Some tests have maximum cycle limits to prevent infinite loops
- **Memory Initialization**: Tests assume memory files are correctly formatted

---

## Summary

This testing methodology provides comprehensive coverage of the MIPS processor implementation:

1. **Unit Tests**: Verify individual components work correctly in isolation
2. **Integration Tests**: Verify components work together correctly
3. **System Tests**: Verify the complete processor executes programs correctly
4. **Benchmark Tests**: Validate against provided and custom test programs

The automated test infrastructure ensures consistent, repeatable testing and provides detailed feedback on any failures, making it easy to identify and fix issues during development.

