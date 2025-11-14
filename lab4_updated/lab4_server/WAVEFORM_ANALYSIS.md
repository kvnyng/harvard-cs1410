# Waveform Analysis Summary

## Test Comparison

### Original Tests (13 tests - ALL PASSING ✓)
- **Address Range**: 0x00400000 - 0x00400038 (15 instructions)
- **Registers Used**: $1-$15 (low registers)
- **Test Type**: Basic functionality verification
- **Status**: All 15 tests passing

### Additional Tests (8 test suites - NOT VERIFIED)
- **Address Range**: 0x0040003C - 0x004000C0 (34 instructions)
- **Registers Used**: $18-$29 (high registers)
- **Test Type**: Edge cases, corner conditions, stress tests
- **Status**: Registers show 'x' (not verified)

## Key Findings from Testbench Output

### PC Execution
- **PC Reached**: 0x004000C4 (confirms all 49 instructions executed)
- **PC Final**: 0x004001F8 (CPU continued executing beyond test instructions)
- **Total Instructions**: 49 (15 original + 34 additional)

### Register Writes Captured
- **Total Writes**: 19 register writes
- **Registers Written**: $1-$15, $2, $3, $11, $12 (original test registers only)
- **Additional Test Registers**: NO writes to $18-$29 found

### Critical Observation
The CPU's PC reached 0x004000C4, which means it executed all instructions including the additional tests. However:
1. **No register writes** to $18-$29 were captured
2. This suggests either:
   - The additional test instructions executed but didn't write to registers
   - The instructions wrote to different registers than expected
   - There's a timing issue with register updates
   - The instructions weren't properly fetched/decoded

## Additional Test Details

### Test 1: Zero Operations (6 instructions @ 0x0040003C-0x00400050)
```
ADDI $18, $0, 0  → $18 = 0
ADDI $19, $0, 0  → $19 = 0
ADD  $19, $18, $19 → $19 = 0
SUB  $19, $18, $19 → $19 = 0
AND  $19, $18, $19 → $19 = 0
OR   $19, $18, $19 → $19 = 0
Expected: $19 = 0
```

### Test 2: Maximum Values (5 instructions @ 0x00400054-0x00400064)
```
ADDI $20, $0, -1  → $20 = 0xFFFFFFFF
ADDI $21, $0, -1  → $21 = 0xFFFFFFFF
ADD  $21, $20, $21 → $21 = 0xFFFFFFFE
AND  $21, $20, $21 → $21 = 0xFFFFFFFE
OR   $21, $20, $21 → $21 = 0xFFFFFFFF
Expected: $21 = 0xFFFFFFFF
```

### Test 3: Large Shift Amounts (4 instructions @ 0x00400068-0x00400074)
```
ADDI $22, $0, 1   → $22 = 1
SLL  $22, $22, 2  → $22 = 4
SLL  $22, $22, 4  → $22 = 64
SRL  $22, $22, 1  → $22 = 32
Expected: $22 = 32
```

### Test 4: Negative Number Operations (4 instructions @ 0x00400078-0x00400084)
```
ADDI $23, $0, -2  → $23 = 0xFFFFFFFE
ADDI $24, $0, 3   → $24 = 3
SUB  $23, $23, $24 → $23 = -5 (0xFFFFFFFB)
SLT  $23, $23, $24 → $23 = 1
Expected: $23 = 1
```

### Test 5: Register $0 Write Protection (3 instructions @ 0x00400088-0x00400090)
```
ADDI $25, $0, 5   → $25 = 5
ADD  $25, $0, $25 → $25 = 5 (trying to write to $0)
ADD  $25, $25, $0 → $25 = 5
Expected: $25 = 5, $0 = 0
```

### Test 6: Sequential Dependency Chain (5 instructions @ 0x00400094-0x004000A4)
```
ADDI $26, $0, 1   → $26 = 1
ADD  $26, $26, $26 → $26 = 2
ADD  $26, $26, $26 → $26 = 4
ADD  $26, $26, $26 → $26 = 8
ADD  $26, $26, $26 → $26 = 16
Expected: $26 = 16
```

### Test 7: XOR Identity and Complement (4 instructions @ 0x004000A8-0x004000B4)
```
ADDI $27, $0, 10  → $27 = 10
XOR  $27, $27, $27 → $27 = 0
ADDI $27, $0, 127 → $27 = 127
ADDI $27, $0, 255 → $27 = 255
Expected: $27 = 255
```

### Test 8: NOR with All Ones (3 instructions @ 0x004000B8-0x004000C0)
```
ADDI $28, $0, -1  → $28 = 0xFFFFFFFF
ADDI $29, $0, -1  → $29 = 0xFFFFFFFF
NOR  $29, $28, $29 → $29 = 0
Expected: $29 = 0
```

## Recommended Waveform Analysis Steps

To analyze the waveform file (`cpu_rtype_sequential_tb.vcd`):

1. **Open with gtkwave** (if available):
   ```bash
   gtkwave cpu_rtype_sequential_tb.vcd
   ```

2. **Key Signals to Monitor**:
   - `cpu_inst.dbg_PC` - Program counter progression
   - `cpu_inst.instruction_reg_inst.q` - Current instruction
   - `cpu_inst.dbg_RegWrite` - Register write enable
   - `cpu_inst.dbg_reg_file_w_addr` - Write address
   - `cpu_inst.dbg_reg_file_w_data` - Write data
   - `cpu_inst.control_unit_inst.current_state` - FSM state

3. **Checkpoints to Verify**:
   - **Time ~276 cycles**: PC should be at 0x004000C4
   - **Instruction Fetch**: Verify instructions at 0x0040003C-0x004000C0 are being fetched
   - **Register Writes**: Check if RegWrite is asserted for instructions writing to $18-$29
   - **FSM States**: Verify S0→S1→S2→S3 transitions for additional test instructions

4. **Potential Issues to Investigate**:
   - Are instructions at 0x0040003C-0x004000C0 being fetched correctly?
   - Is RegWrite being asserted during S3 for additional test instructions?
   - Are the write addresses correct (should be $18-$29)?
   - Is there a timing issue where writes happen but aren't captured?

## Next Steps

1. **Verify Instruction Fetching**: Check if instructions at 0x0040003C are actually in memory
2. **Check Control Signals**: Verify RegWrite, RegDst, MemToReg are correct for additional tests
3. **Verify Register File**: Ensure register file can handle writes to $18-$29
4. **Timing Analysis**: Check if there's a race condition or timing issue

