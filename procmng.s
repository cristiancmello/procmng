	.file	"procmng.c"
	.text
	.section	.rodata
.LC0:
	.string	"Caller PID: %d\n"
.LC1:
	.string	"Parent Caller PID: %d\n"
.LC2:
	.string	"Estou no child e parent!"
.LC3:
	.string	"PID: %d\n"
.LC4:
	.string	"PARENT CONTEXT"
.LC5:
	.string	"Parent of Child PID: %d\n"
	.align 8
.LC6:
	.string	"current_pid \303\251 igual ao caller_pid"
.LC7:
	.string	"My child PID is %d\n"
	.align 8
.LC8:
	.string	"Child Process terminou com status %d\n"
.LC9:
	.string	"\n"
.LC10:
	.string	"CHILD CONTEXT"
.LC11:
	.string	"Child PID: %d"
.LC12:
	.string	"hello"
.LC13:
	.string	"world"
.LC14:
	.string	"MESSAGE=hello"
.LC15:
	.string	"myscript.sh"
.LC16:
	.string	"execve"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	getpid@PLT
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	call	getppid@PLT
	movl	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	call	fork@PLT
	movl	%eax, -68(%rbp)
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	-68(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -80(%rbp)
	cmpl	$0, -68(%rbp)
	je	.L2
	movl	-68(%rbp), %eax
	movl	%eax, -80(%rbp)
.L2:
	cmpl	$0, -68(%rbp)
	je	.L3
	call	getpid@PLT
	movl	%eax, -60(%rbp)
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	movl	-60(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-60(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jne	.L4
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
.L4:
	movl	-80(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -84(%rbp)
	leaq	-84(%rbp), %rax
	movl	$10, %edx
	movq	%rax, %rsi
	movl	$-1, %edi
	call	waitpid@PLT
	movl	-84(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L7
	jmp	.L8
.L3:
	call	getpid@PLT
	movl	%eax, -64(%rbp)
	leaq	.LC10(%rip), %rdi
	call	puts@PLT
	movl	-64(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movw	$29548, -11(%rbp)
	movb	$0, -9(%rbp)
	movq	$0, -48(%rbp)
	leaq	.LC12(%rip), %rax
	movq	%rax, -40(%rbp)
	leaq	.LC13(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -24(%rbp)
	leaq	.LC14(%rip), %rax
	movq	%rax, -56(%rbp)
	leaq	-56(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC15(%rip), %rdi
	call	execve@PLT
	leaq	.LC16(%rip), %rdi
	call	perror@PLT
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	movl	$1, %edi
	call	exit@PLT
.L8:
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
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
