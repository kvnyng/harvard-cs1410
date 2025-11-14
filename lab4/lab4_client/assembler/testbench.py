#!/usr/bin/env python3
#
# Testbench for MIPS assembler.py
#
# Usage:
#    python3 testbench.py

import sys
import os
import tempfile
from textwrap import dedent
from assembler import Assembler

class TestBench:
    """Test suite for the MIPS assembler"""
    
    def __init__(self):
        self.tests_passed = 0
        self.tests_failed = 0
        self.failed_tests = []
    
    def run_test(self, test_name, asm_code, expected_output):
        """Run a single test case"""
        temp_file = None
        try:
            # Create temporary file with assembly code
            with tempfile.NamedTemporaryFile(mode='w', suffix='.asm', delete=False) as f:
                f.write(asm_code)
                temp_file = f.name
            
            # Capture output
            import io
            from contextlib import redirect_stdout
            f = io.StringIO()
            with redirect_stdout(f):
                assembler = Assembler()
                assembler.assemble(temp_file)
            actual_output = f.getvalue()
            
            # Clean up
            os.unlink(temp_file)
            temp_file = None
            
            # Compare outputs
            expected_lines = expected_output.strip().split('\n') if expected_output.strip() else []
            actual_lines = actual_output.strip().split('\n') if actual_output.strip() else []
            
            if expected_lines == actual_lines:
                print(f"✓ PASS: {test_name}")
                self.tests_passed += 1
                return True
            else:
                print(f"✗ FAIL: {test_name}")
                print(f"  Expected ({len(expected_lines)} lines):")
                for i, line in enumerate(expected_lines):
                    print(f"    [{i}] {line}")
                print(f"  Got ({len(actual_lines)} lines):")
                for i, line in enumerate(actual_lines):
                    print(f"    [{i}] {line}")
                self.tests_failed += 1
                self.failed_tests.append(test_name)
                return False
                
        except Exception as e:
            print(f"✗ ERROR: {test_name}")
            print(f"  Exception: {e}")
            import traceback
            traceback.print_exc()
            self.tests_failed += 1
            self.failed_tests.append(test_name)
            if temp_file:
                try:
                    os.unlink(temp_file)
                except:
                    pass
            return False
    
    def test_rtype_basic(self):
        """Test basic R-type instructions"""
        asm = """add $s0, $s1, $s2
sub $t0, $t1, $t2
and $a0, $a1, $a2
or $v0, $v1, $zero
xor $t3, $t4, $t5
nor $s3, $s4, $s5
slt $t6, $t7, $t8"""
        
        # Expected values verified against actual assembler output
        expected = """02328020
012a4022
00a62024
00601025
018d5826
02959827
01f8702a"""
        
        return self.run_test("R-type basic instructions", asm, expected)
    
    def test_itype_immediate(self):
        """Test I-type instructions with immediates"""
        asm = dedent("""\
            addi $s0, $zero, 5
            addi $s1, $zero, -10
            andi $t0, $s0, 255
            ori $t1, $zero, 42
            xori $t2, $s0, 15
            slti $t3, $s0, 10
            """).strip()
        
        expected = """20100005
2011fff6
320800ff
3409002a
3a0a000f
2a0b000a"""
        
        return self.run_test("I-type immediate instructions", asm, expected)
    
    def test_shift_instructions(self):
        """Test shift instructions"""
        asm = """sll $t0, $s0, 2
srl $t1, $s1, 3
sra $t2, $s2, 4"""
        
        expected = """00104080
001148c2
00125103"""
        
        return self.run_test("Shift instructions", asm, expected)
    
    def test_load_store(self):
        """Test load and store instructions"""
        asm = """lw $t0, 0($s0)
lw $t1, 4($s1)
sw $t2, 8($s2)
sw $t3, -4($sp)"""
        
        expected = """8e080000
8e290004
ae4a0008
afabfffc"""
        
        return self.run_test("Load/Store instructions", asm, expected)
    
    def test_branch_forward(self):
        """Test forward branch (label after branch)"""
        asm = """addi $s0, $zero, 5
beq $s0, $zero, target
addi $s1, $zero, 10
target: addi $s2, $zero, 15"""
        
        expected = """20100005
12000001
2011000a
2012000f"""
        
        return self.run_test("Forward branch", asm, expected)
    
    def test_branch_backward(self):
        """Test backward branch (loop)"""
        asm = """loop: add $s0, $s1, $s2
addi $s0, $s0, 1
bne $s0, $zero, loop
addi $s1, $zero, 5"""
        
        expected = """02328020
22100001
1600fffd
20110005"""
        
        return self.run_test("Backward branch (loop)", asm, expected)
    
    def test_jump_instructions(self):
        """Test jump instructions"""
        asm = """addi $s0, $zero, 5
j target
addi $s1, $zero, 10
target: addi $s2, $zero, 15
jal subroutine
addi $s3, $zero, 20
subroutine: addi $s4, $zero, 25"""
        
        expected = """20100005
08000003
2011000a
2012000f
0c000006
20130014
20140019"""
        
        return self.run_test("Jump instructions", asm, expected)
    
    def test_jr_instruction(self):
        """Test jr instruction"""
        asm = """jr $ra"""
        
        expected = """03e00008"""
        
        return self.run_test("JR instruction", asm, expected)
    
    def test_nop_instruction(self):
        """Test nop instruction"""
        asm = """nop
addi $s0, $zero, 5
nop"""
        
        expected = """00000000
20100005
00000000"""
        
        return self.run_test("NOP instruction", asm, expected)
    
    def test_registers_by_number(self):
        """Test registers specified by number"""
        asm = """add $16, $17, $18
addi $8, $0, 10
lw $9, 0($16)"""
        
        expected = """02328020
2008000a
8e090000"""
        
        return self.run_test("Registers by number", asm, expected)
    
    def test_multiple_labels(self):
        """Test multiple labels"""
        asm = """start: addi $s0, $zero, 1
middle: addi $s1, $zero, 2
beq $s0, $s1, end
j middle
end: addi $s2, $zero, 3"""
        
        expected = """20100001
20110002
12110001
08000001
20120003"""
        
        return self.run_test("Multiple labels", asm, expected)
    
    def test_comments_and_whitespace(self):
        """Test handling of comments and whitespace"""
        asm = """  # This is a comment
addi $s0, $zero, 5   # Initialize $s0
   addi $s1, $zero, 10
# Another comment
add $s2, $s0, $s1"""
        
        expected = """20100005
2011000a
02119020"""
        
        return self.run_test("Comments and whitespace", asm, expected)
    
    def test_negative_immediates(self):
        """Test negative immediate values"""
        asm = """addi $s0, $zero, -1
addi $s1, $zero, -100
slti $t0, $s0, -50"""
        
        expected = """2010ffff
2011ff9c
2a08ffce"""
        
        return self.run_test("Negative immediates", asm, expected)
    
    def test_large_immediates(self):
        """Test large immediate values"""
        asm = """andi $t0, $s0, 4095
ori $t1, $zero, 65535"""
        
        expected = """32080fff
3409ffff"""
        
        return self.run_test("Large immediates", asm, expected)
    
    def test_complex_loop(self):
        """Test complex loop with multiple branches"""
        asm = """addi $s0, $zero, 0
loop: addi $s0, $s0, 1
lw $t0, 0($s0)
beq $t0, $zero, done
bne $s0, $s1, loop
done: addi $s2, $zero, 100"""
        
        expected = """20100000
22100001
8e080000
11000001
1611fffc
20120064"""
        
        return self.run_test("Complex loop", asm, expected)
    
    def test_benchmark_1(self):
        """Test against benchmark_1.asm"""
        asm = """loop: add $s0, $s1, $s2 # $s0 = $s1 + $s2
lw $t4, 0($s0)
lw $t3, 0($s1)
bne $t3, $t4, loop
addi $s0, $s0, 1 # $0++"""
        
        expected = """02328020
8e0c0000
8e2b0000
156cfffc
22100001"""
        
        return self.run_test("Benchmark 1", asm, expected)
    
    def test_handout(self):
        """Test against handout.asm"""
        asm = """main:	addi	$s0, $zero, 5   	# $s0 = 5
		addi    $s3, $zero, -36 	# $s3 = -36
		add		$s2, $s0, $s3   	# $s2 = $s0 + $s3 = -31
		sub		$t0, $s2, $s0   	# $t0 = $s2 - $s0 = -36
		and		$t4, $t0, $s3
		andi	$t1, $s0, 4095
		or		$t5, $t1, $t0
		ori		$t2, $zero, 40		# $t2 gets 40
		xor		$s5, $zero, $s2
		lw		$t5, 4($t2)
test:	sll		$t1, $s3, 2
hello:	slti	$t0, $s3, -40		# oops the rest is omitted ¯\_(ツ)_/¯"""
        
        expected = """20100005
2013ffdc
02139020
02504022
01136024
32090fff
01286825
340a0028
0012a826
8d4d0004
00134880
2a68ffd8"""
        
        return self.run_test("Handout", asm, expected)
    
    def run_all_tests(self):
        """Run all test cases"""
        print("=" * 60)
        print("MIPS Assembler Test Suite")
        print("=" * 60)
        print()
        
        # Run all tests
        self.test_rtype_basic()
        self.test_itype_immediate()
        self.test_shift_instructions()
        self.test_load_store()
        self.test_branch_forward()
        self.test_branch_backward()
        self.test_jump_instructions()
        self.test_jr_instruction()
        self.test_nop_instruction()
        self.test_registers_by_number()
        self.test_multiple_labels()
        self.test_comments_and_whitespace()
        self.test_negative_immediates()
        self.test_large_immediates()
        self.test_complex_loop()
        self.test_benchmark_1()
        self.test_handout()
        
        # Print summary
        print()
        print("=" * 60)
        print("Test Summary")
        print("=" * 60)
        print(f"Total tests:  {self.tests_passed + self.tests_failed}")
        print(f"Passed:       {self.tests_passed}")
        print(f"Failed:       {self.tests_failed}")
        
        if self.failed_tests:
            print()
            print("Failed tests:")
            for test in self.failed_tests:
                print(f"  - {test}")
        
        print("=" * 60)
        
        return self.tests_failed == 0

if __name__ == "__main__":
    testbench = TestBench()
    success = testbench.run_all_tests()
    sys.exit(0 if success else 1)

