# FSM Timing Analysis

## Critical Discovery: Instruction Loading Timing Issue

### Timeline of Events:

1. **Lines 265-279**: Testbench loads ORIGINAL instructions (0x00400000-0x00400038)
2. **Line 297**: Testbench waits 100 cycles (CPU starts executing)
3. **Lines 303-313**: Testbench verifies original test results
4. **Line 332+**: Testbench writes ADDITIONAL test instructions (0x0040003C+)

### The Problem:

**The additional test instructions are written AFTER the CPU has already started executing!**

When the CPU reaches address 0x0040003C:
- If the instruction hasn't been written yet, CPU fetches **uninitialized memory** (likely 0x00000000)
- 0x00000000 = NOP (sll $0, $0, 0) in MIPS
- CPU executes NOP, then moves to 0x00400040
- By the time testbench writes the real instruction at 0x0040003C, CPU has already passed it!

### FSM Behavior with NOP (0x00000000):

- Opcode: 0x00 = OP_RTYPE ✓
- Funct: 0x00 = F_SLL ✓
- FSM will execute: S0 -> S1 -> S2_EXECUTE_RTYPE -> S3_RTYPE_WRITEBACK -> S0
- Result: SLL $0, $0, 0 (writes to $0, which is ignored)
- PC increments to 0x00400040
- **CPU skips the instruction that will be written at 0x0040003C!**

### Solution:

**Load ALL instructions BEFORE starting simulation!**

Move all `write_instruction_memory()` calls for additional tests to BEFORE line 297 (before `wait_cycles(100)`).

This ensures:
1. All instructions are in memory before CPU starts
2. CPU can fetch correct instructions sequentially
3. No race condition between testbench writes and CPU fetches
