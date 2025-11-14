# CPU Implementation Review

## Critical Issues

### 1. **Branch Logic Not Connected (CRITICAL)**
**Location:** Lines 62-64
**Issue:** The branch logic assignments are commented out, causing `PCEn` to be undefined/X
```systemverilog
// assign branch_and_zero = Branch & alu_zero;
// assign PCEn = branch_and_zero | PCWrite;
```
**Impact:** PC_Reg enable will be X, causing the CPU to not function properly
**Fix:** Uncomment these lines and place them AFTER the control unit and ALU are instantiated (after line 355)

### 2. **Duplicate Signal Declarations**
**Location:** 
- `Branch`: Declared at line 52 AND line 330
- `alu_zero`: Declared at line 53 AND line 267
**Issue:** Multiple declarations of the same signal
**Impact:** Compiler error or undefined behavior
**Fix:** Remove the early declarations (lines 52-53) since they're properly declared later

## Data Flow Issues

### 3. **Unused/Redundant Signal**
**Location:** Line 313-314
**Issue:** `data_addr` is declared and assigned but not used
```systemverilog
logic [31:0] data_addr;
assign data_addr = ALUResult;
```
**Note:** The IorD mux (line 87) uses `alu_out_for_addr` which is connected to `ALUOut`, not `data_addr`
**Impact:** Dead code, but doesn't break functionality
**Recommendation:** Remove if not needed for debugging

### 4. **Placeholder Signal Pattern**
**Location:** Lines 86, 144, 304, 308
**Issue:** Using placeholder signals (`alu_out_for_reg`, `alu_out_for_addr`) that are later assigned
**Status:** This is actually fine - it's a valid pattern to avoid forward references
**Note:** Could be simplified by moving ALU_Reg instantiation earlier, but current approach works

## Signal Naming Consistency

### 5. **Inconsistent Naming**
- `Register_File_A` / `Register_File_B` - Could be `RegFile_A` / `RegFile_B` for brevity
- `ALUResult` vs `alu_result` - `ALUResult` is used consistently now (good)
- `PC_prime` - Good naming convention
- `SignImm` - Good naming

## Data Flow Verification

### ✅ Correct Data Paths:

1. **Instruction Fetch:**
   - PC → IorD mux (0) → addr → main_memory → mem_r_data → instruction_reg ✓

2. **PC Update:**
   - ALUResult/ALUOut → PCSrc_Select → PC_prime → PC_Reg → PC ✓

3. **Register File Read:**
   - instruction_reg[25:21] → reg_file_r0_addr → Register_File_A ✓
   - instruction_reg[20:16] → reg_file_r1_addr → Register_File_B ✓

4. **ALU Operations:**
   - Register_File_A/PC → SrcA_select → ALU x ✓
   - Register_File_B/4/SignImm/shifted_imm → SrcB_select → ALU y ✓
   - ALU → ALUResult → ALU_Reg → ALUOut ✓

5. **Memory Access:**
   - ALUOut → IorD mux (1) → addr → main_memory ✓
   - Register_File_B → w_data → main_memory ✓

6. **Writeback:**
   - ALUOut/data_reg → MemToReg mux → reg_file_w_data → register file ✓

## Recommendations

1. **IMMEDIATE FIX:** Uncomment branch logic assignments (lines 63-64) and move after control unit instantiation
2. **IMMEDIATE FIX:** Remove duplicate signal declarations (lines 52-53)
3. **OPTIONAL:** Remove unused `data_addr` signal if not needed
4. **OPTIONAL:** Consider renaming `Register_File_A/B` to `RegFile_A/B` for consistency

## Summary

The CPU datapath structure is **mostly correct**, but has **2 critical issues** that must be fixed:
1. Branch logic not connected (PCEn will be X)
2. Duplicate signal declarations (will cause compilation errors)

All other issues are minor or stylistic.

