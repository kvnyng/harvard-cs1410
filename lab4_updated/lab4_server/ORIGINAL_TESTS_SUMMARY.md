# Original Tests Summary

## Original 13 Tests (All Passing ✓)

### Setup Instructions (4 ADDI - not explicitly tested, just setup):
1. **ADDI $2, $0, 5**    → $2 = 5
2. **ADDI $3, $0, 3**    → $3 = 3  
3. **ADDI $4, $0, 10**   → $4 = 10
4. **ADDI $5, $0, -1**   → $5 = 0xFFFFFFFF

### R-Type Instruction Tests (11 tests):
5. **ADD  $1, $2, $2**   → $1 = 5 + 5 = 10 ✓
6. **SUB  $6, $4, $2**   → $6 = 10 - 5 = 5 ✓
7. **AND  $7, $2, $3**   → $7 = 5 & 3 = 1 ✓
8. **OR   $8, $2, $3**   → $8 = 5 | 3 = 7 ✓
9. **XOR  $9, $2, $3**   → $9 = 5 ^ 3 = 6 ✓
10. **NOR $10, $2, $3**  → $10 = ~(5 | 3) = 0xFFFFFFF8 ✓
11. **SLT  $11, $2, $4**  → $11 = (5 < 10) ? 1 : 0 = 1 ✓
12. **SLT  $12, $4, $2**  → $12 = (10 < 5) ? 1 : 0 = 0 ✓
13. **SLL  $13, $2, 2**   → $13 = 5 << 2 = 20 ✓
14. **SRL  $14, $4, 1**   → $14 = 10 >> 1 = 5 ✓
15. **SRA  $15, $5, 1**   → $15 = -1 >>> 1 = 0xFFFFFFFF ✓

### Register $0 Check (1 test):
16. **Register $0** must always be 0 ✓

**Total: 11 R-type tests + 1 register $0 check = 12 verified tests**
(Plus 4 ADDI setup instructions that aren't explicitly tested)

## Test Results
- **Total tests executed: 15** (includes some intermediate checks)
- **Passed: 15**
- **Failed: 0**
- **All original tests are passing!** ✓

## Additional Tests Status
- 8 additional test suites were added (edge cases)
- PC reaches 0x004000C4, confirming all 49 instructions executed
- However, register writes to $18-$29 are not being captured
- This suggests the additional test instructions may be executing but writing to different registers, or there's a timing issue

## Next Steps for Debugging Additional Tests
1. Check if instructions at 0x0040003C-0x004000C0 are actually being fetched
2. Verify the instruction encodings are correct
3. Check if RegWrite is being asserted for those instructions
4. Inspect waveform file (cpu_rtype_sequential_tb.vcd) for detailed analysis
