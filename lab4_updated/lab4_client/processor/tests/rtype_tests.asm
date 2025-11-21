nor $t0, $zero, $zero     # $t0 = 0xFFFFFFFF (-1)
srl $t1, $t0, 31          # $t1 = 0xFFFFFFFF >> 31 = 1
sll $t2, $t1, 1           # $t2 = 1 << 1 = 2
or  $t3, $t1, $t2         # $t3 = 1 | 2 = 3
sll $t4, $t3, 4           # $t4 = 3 << 4 = 48
sub $t5, $t4, $t1         # $t5 = 48 - 1 = 47
add $t6, $t5, $t3         # $t6 = 47 + 3 = 50
xor $t7, $t6, $t3         # $t7 = 50 ^ 3 = 49
and $t8, $t6, $t4         # $t8 = 50 & 48 = 48
nor $t9, $t8, $t3         # $t9 = ~(48 | 3) = ~51 = 0xFFFFFFCC (-52)
sra $s0, $t9, 2           # $s0 = (-52) >> 2 (arith) = -13
srl $s1, $t9, 2           # $s1 = 0xFFFFFFCC >> 2 = 0x3FFFFFF3
slt $s2, $t1, $t2         # $s2 = (1 < 2) ? 1 : 0 = 1
and $s3, $t0, $t1         # $s3 = (-1) & 1 = 1
nop                       # no operation (alias sll $zero,$zero,0)