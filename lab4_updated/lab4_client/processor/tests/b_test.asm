# Construct 3 step by step
nor $s6, $zero, $zero    # Bitwise NOR $t0 and $t1 (NOT(0 OR 0) = -1) into $t6 (all 1s)
srl $s7, $s6, 30         # shift $t6 by 30 to the right; $t6 = 3
add $t0, $s7, $s7        # $t0 = 6
sub $t1, $t0, $s7        # Subtract $t6 from $t0, store in $t1 (6 - 3 = 3)

# Arithmetic operations
add $t2, $t1, $t0        # Add $t1 + $t0, store in $t2 (9)
sub $t3, $t1, $t0        # Subtract $t1 from $t0, store in $t2 (6 - 3 = 3)

# Bitwise logical operations
and $t3, $t0, $t1        # Bitwise AND $t0 and $t1 (6 AND 3 = 2)
or $t4, $t0, $t1         # Bitwise OR $t0 and $t1 (6 OR 3 = 7)
xor $t5, $t0, $t1        # Bitwise XOR $t0 and $t1 (6 XOR 3 = 5)

# Shift operations
sll $t6, $t0, 3          # Shift left logical $t0 by 1 (6 << 3 = 48)
nor $t7, $zero, $zero    # contruct all 1s in $t7
srl $s0, $t7, 28         # Shift right logical $t0 by 1 ($t7 >> 28 = 12)
sra $s1, $t7, 28         # Shift right arithmetic $t0 by 1 ($t7 >> 28 = 12)

# Set on less than
slt $s2, $t0, $t1        # Set $s2 to 1 if $t0 < $t1 (6 < 3 = false, $s2 = 0)