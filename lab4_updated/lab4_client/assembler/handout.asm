main:	addi	$s0, $zero, 5   	# $s0 = 5
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
hello:	slti	$t0, $s3, -40		# oops the rest is omitted ¯\_(ツ)_/¯
