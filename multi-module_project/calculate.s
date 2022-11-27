	.intel_syntax noprefix
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB0:
	.cfi_startproc
	endbr64	
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	
	movsd	QWORD PTR -40[rbp], xmm0	# x - первый аргумент функции
	
	pxor	xmm0, xmm0			# prev = 0;
	movsd	QWORD PTR -24[rbp], xmm0
	
	movsd	xmm0, QWORD PTR .LC1[rip]	# now = 1;
	movsd	QWORD PTR -16[rbp], xmm0
	
	movsd	xmm0, QWORD PTR -40[rbp]	# pow_x = x;
	movsd	QWORD PTR -8[rbp], xmm0
	
	jmp	.L2				# while (fabs(now - prev) > 0.0005) {
.L3:

	movsd	xmm0, QWORD PTR -16[rbp]	# 	prev = now;
	movsd	QWORD PTR -24[rbp], xmm0

	movsd	xmm0, QWORD PTR -16[rbp]	# 	now += pow_x;
	addsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0

	movsd	xmm0, QWORD PTR -8[rbp]		# 	pow_x *= x;
	mulsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
.L2:

	movsd	xmm0, QWORD PTR -16[rbp]
	subsd	xmm0, QWORD PTR -24[rbp]
	movq	xmm1, QWORD PTR .LC2[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC3[rip]
	ja	.L3				# }
	

	movsd	xmm0, QWORD PTR -16[rbp]	# return now;
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	calculate, .-calculate
	
	.section	.rodata
	
.LC1:
	.long	0
	.long	1072693248
	.align 16
.LC2:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC3:
	.long	-755914244
	.long	1061184077
	.align 8
