	.file	"mem_segments.c"
	.text
	.comm	globBuf,65536,32
	.globl	primes
	.data
	.align 16
	.type	primes, @object
	.size	primes, 16
primes:
	.long	2
	.long	3
	.long	5
	.long	7
	.text
	.type	square, @function
square:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	imull	%eax, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	square, .-square
	.section	.rodata
.LC0:
	.string	"The square of %d is %d\n"
.LC1:
	.string	"The cube of %d is %d\n"
	.text
	.type	doCalc, @function
doCalc:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	square
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$999, -20(%rbp)
	jg	.L5
	movl	-20(%rbp), %eax
	imull	%eax, %eax
	movl	-20(%rbp), %edx
	imull	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	doCalc, .-doCalc
	.section	.rodata
	.align 8
.LC2:
	.string	"ADDRESS OF THE END OF PROGRAM TEXT SEGMENT: %p\n"
	.align 8
.LC3:
	.string	"ADDRESS OF THE END OF USER-INITIALIZED DATA SEGMENT: %p\n"
	.align 8
.LC4:
	.string	"ADDRESS OF THE END OF ZERO-INITIALIZED DATA SEGMENT (bss): %p\n"
.LC5:
	.string	"\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$1024, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movl	key.2847(%rip), %eax
	movl	%eax, %edi
	call	doCalc
	leaq	etext(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	edata(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	end(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	movl	$100000, %edi
	movl	$0, %eax
	call	sleep@PLT
	movl	$0, %edi
	call	exit@PLT
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.data
	.align 4
	.type	key.2847, @object
	.size	key.2847, 4
key.2847:
	.long	9973
	.local	mbuf.2848
	.comm	mbuf.2848,102304000,32
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
