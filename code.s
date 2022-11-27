	.file	"code.c"
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

.LC4:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"Error when working with files"
	.align 8
.LC7:
	.string	"Since no input and output files are specified, stdin and stdout will be used"
.LC8:
	.string	"%lf"
	.align 8
.LC10:
	.string	"Input value must be in range (-1, 1)"	
.LC11:
	.string	"%lf\n"
	
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64	
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48				# Выделяем память под переменные
	
	mov	DWORD PTR -36[rbp], edi		# argc
	mov	QWORD PTR -48[rbp], rsi		# argv
	
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	
	xor	eax, eax
	cmp	DWORD PTR -36[rbp], 3		# if (argc == 3) {
	jne	.L6
	
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx			# rsi = "r" - второй аргумент
	mov	rdi, rax			# rdi = argv[1] - первый аргумент
	call	fopen@PLT			# 	in = fopen(argv[1], "r");
	mov	QWORD PTR -24[rbp], rax
	
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx			# rsi = "w" - второй аргумент
	mov	rdi, rax			# rdi = argv[2] - первый аргумент
	call	fopen@PLT			# 	out = fopen(argv[2], "w");
	mov	QWORD PTR -16[rbp], rax
	
	cmp	QWORD PTR -24[rbp], 0		# 	if (in == NULL || out == NULL) {
	je	.L7
	cmp	QWORD PTR -16[rbp], 0
	jne	.L8
.L7:
	lea	rax, .LC6[rip]
	mov	rdi, rax			# rdi = "Error when working with files\n" - первый аргумент	
	call	puts@PLT			# 		printf("Error when working with files\n");
	mov	eax, 1				# 		return 1;
	jmp	.L13				# 	}
.L6:
	lea	rax, .LC7[rip]
	mov	rdi, rax			# rdi = "Since no input and output files are specified, stdin and stdout will be used\n" - первый аргумент
	call	puts@PLT			# 	printf("Since no input and output files are specified, stdin and stdout will be used\n");
	
	mov	rax, QWORD PTR stdin[rip]	# 	in = stdin;
	mov	QWORD PTR -24[rbp], rax

	mov	rax, QWORD PTR stdout[rip]	# 	out = stdout;
	mov	QWORD PTR -16[rbp], rax
.L8:						# }

	lea	rdx, -32[rbp]			# rdx = &x - третий аргумент
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC8[rip]
	mov	rsi, rcx			# rsi = "%lf" - второй аргумент
	mov	rdi, rax			# rdi = in - первый аргумент
	mov	eax, 0
	call	__isoc99_fscanf@PLT		# fscanf(in, "%lf", &x);
	
	movsd	xmm0, QWORD PTR -32[rbp]	# if (x >= 1 || x <= -1) {
	movsd	xmm1, QWORD PTR .LC1[rip]
	comisd	xmm0, xmm1
	jnb	.L10
	movsd	xmm1, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR .LC9[rip]
	comisd	xmm0, xmm1
	jb	.L15
	
.L10:
	lea	rax, .LC10[rip]
	mov	rdi, rax			# rdi = "Input value must be in range (-1, 1)\n" - первый аргумент
	call	puts@PLT			# 	printf("Input value must be in range (-1, 1)\n");
	mov	eax, 1				# 	return 1;
	jmp	.L13				# }
.L15:

	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax			# xmm0 = x - первый аргумент
	call	calculate
	movq	rax, xmm0
	
	mov	rdx, QWORD PTR -16[rbp]
	movq	xmm0, rax			# xmm0 = calculate(x)
	lea	rax, .LC11[rip]
	mov	rsi, rax			# rsi = "%lf\n" - второй аргумент
	mov	rdi, rdx			# rdi = out - первый аргумент
	mov	eax, 1
	call	fprintf@PLT			# fprintf(out, "%lf\n", calculate(x));

	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax			# rdi = in - первый аргумент
	call	fclose@PLT			# fclose(in);

	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax			# rdi = out - первый аргумент
	call	fclose@PLT			# fclose(out);

	mov	eax, 0				# return 0;
	
.L13:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	main, .-main
	
	.section	.rodata
	.align 8
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
.LC9:
	.long	0
	.long	-1074790400
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
