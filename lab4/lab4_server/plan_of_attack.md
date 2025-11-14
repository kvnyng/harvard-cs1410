# Plan

1. Turn FSM diagram that supports the R-type instructions into a state machine for the control unit in SystemVerilog. Test the state machine against testbench.
2. Create the instruction memory and and data memory, which will be the entrypoint of the design. Test the memory against testbench. Make sure that the memory loaded is being read out properly.
3. Create the register file. Test the register file against testbench. Make sure that the register file is being written to and read from properly.
4. Create the ALU. Test the ALU against testbench. Make sure that the ALU is performing the correct operations.

R-type instructions to support:
- and
- sll
- add
- or
- sra
- sub
- xor
- srl
- nop