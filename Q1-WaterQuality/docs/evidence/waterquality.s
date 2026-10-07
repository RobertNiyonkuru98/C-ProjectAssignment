	.file	"waterquality.c"
	.text
	.globl	temperature_deviation
	.type	temperature_deviation, @function
temperature_deviation:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -4(%rbp)
	movss	-4(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	.LC1(%rip), %xmm1
	andps	%xmm1, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	temperature_deviation, .-temperature_deviation
	.globl	turbidity_penalty
	.type	turbidity_penalty, @function
turbidity_penalty:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -4(%rbp)
	movss	-4(%rbp), %xmm0
	movss	.LC2(%rip), %xmm1
	divss	%xmm1, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	turbidity_penalty, .-turbidity_penalty
	.globl	water_quality_index
	.type	water_quality_index, @function
water_quality_index:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movss	%xmm0, -20(%rbp)
	movss	%xmm1, -24(%rbp)
	movl	-20(%rbp), %eax
	movd	%eax, %xmm0
	call	temperature_deviation
	movd	%xmm0, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	movd	%eax, %xmm0
	call	turbidity_penalty
	movd	%xmm0, %eax
	movl	%eax, -4(%rbp)
	movss	-8(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	addss	-4(%rbp), %xmm1
	movss	.LC3(%rip), %xmm0
	subss	%xmm1, %xmm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	water_quality_index, .-water_quality_index
	.section	.rodata
.LC5:
	.string	"Good"
.LC7:
	.string	"Warning"
.LC8:
	.string	"Critical"
	.text
	.globl	classify_quality
	.type	classify_quality, @function
classify_quality:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -4(%rbp)
	movss	-4(%rbp), %xmm0
	comiss	.LC4(%rip), %xmm0
	jb	.L15
	leaq	.LC5(%rip), %rax
	jmp	.L10
.L15:
	movss	-4(%rbp), %xmm0
	comiss	.LC6(%rip), %xmm0
	jb	.L16
	leaq	.LC7(%rip), %rax
	jmp	.L10
.L16:
	leaq	.LC8(%rip), %rax
.L10:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	classify_quality, .-classify_quality
	.section	.rodata
	.align 8
.LC9:
	.string	"|-|-|-|WATER QUALITY MONITORING REPORT|-|-|-|\n"
.LC10:
	.string	" Sensor readings"
.LC11:
	.string	"\nTemperature : %8.2f \302\260C\n"
.LC12:
	.string	"Turbidity : %8.2f NTU\n"
.LC13:
	.string	" Index calculation"
	.align 8
.LC14:
	.string	"\nTemperatureDeviation = (%.2f - 25) = %.2f \302\260C\n"
	.align 8
.LC15:
	.string	"TurbidityPenalty = (%.2f / 2) = %.2f \302\260C\n"
	.align 8
.LC16:
	.string	"Index = 100 - (%.2f + %2.f) = %.2f\n"
.LC17:
	.string	"  Result"
	.align 8
.LC18:
	.string	"\nWater Quality Index :  %8.2f\n"
.LC19:
	.string	"Status:  %s\n"
	.align 8
.LC20:
	.string	"====================================================="
	.text
	.globl	print_report
	.type	print_report, @function
print_report:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movss	%xmm0, -4(%rbp)
	movss	%xmm1, -8(%rbp)
	movss	%xmm2, -12(%rbp)
	movl	$10, %edi
	call	putchar@PLT
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	pxor	%xmm3, %xmm3
	cvtss2sd	-4(%rbp), %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	pxor	%xmm4, %xmm4
	cvtss2sd	-8(%rbp), %xmm4
	movq	%xmm4, %rax
	movq	%rax, %xmm0
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$10, %edi
	call	putchar@PLT
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	-4(%rbp), %eax
	movd	%eax, %xmm0
	call	temperature_deviation
	cvtss2sd	%xmm0, %xmm0
	pxor	%xmm5, %xmm5
	cvtss2sd	-4(%rbp), %xmm5
	movq	%xmm5, %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	leaq	.LC14(%rip), %rax
	movq	%rax, %rdi
	movl	$2, %eax
	call	printf@PLT
	movl	-8(%rbp), %eax
	movd	%eax, %xmm0
	call	turbidity_penalty
	cvtss2sd	%xmm0, %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	-8(%rbp), %xmm6
	movq	%xmm6, %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	leaq	.LC15(%rip), %rax
	movq	%rax, %rdi
	movl	$2, %eax
	call	printf@PLT
	pxor	%xmm7, %xmm7
	cvtss2sd	-12(%rbp), %xmm7
	movsd	%xmm7, -24(%rbp)
	movl	-8(%rbp), %eax
	movd	%eax, %xmm0
	call	turbidity_penalty
	pxor	%xmm3, %xmm3
	cvtss2sd	%xmm0, %xmm3
	movsd	%xmm3, -32(%rbp)
	movl	-4(%rbp), %eax
	movd	%eax, %xmm0
	call	temperature_deviation
	pxor	%xmm4, %xmm4
	cvtss2sd	%xmm0, %xmm4
	movq	%xmm4, %rax
	movsd	-24(%rbp), %xmm2
	movsd	-32(%rbp), %xmm1
	movq	%rax, %xmm0
	leaq	.LC16(%rip), %rax
	movq	%rax, %rdi
	movl	$3, %eax
	call	printf@PLT
	movl	$10, %edi
	call	putchar@PLT
	leaq	.LC17(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	pxor	%xmm2, %xmm2
	cvtss2sd	-12(%rbp), %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	leaq	.LC18(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	-12(%rbp), %eax
	movd	%eax, %xmm0
	call	classify_quality
	movq	%rax, %rsi
	leaq	.LC19(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	print_report, .-print_report
	.section	.rodata
.LC21:
	.string	"Water Quality Sensor Input"
.LC22:
	.string	"\n Enter temperature (\302\260C): "
.LC23:
	.string	"%f"
	.align 8
.LC24:
	.string	"Error: Temperature must be a number."
.LC25:
	.string	"Enter turbidity (NTU): "
	.align 8
.LC26:
	.string	"Error: turbidity must be a runner"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC21(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	.LC22(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-20(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC23(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L19
	leaq	.LC24(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L22
.L19:
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC23(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L21
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L22
.L21:
	movss	-16(%rbp), %xmm0
	movl	-20(%rbp), %eax
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	water_quality_index
	movd	%xmm0, %eax
	movl	%eax, -12(%rbp)
	movss	-16(%rbp), %xmm0
	movl	-20(%rbp), %eax
	movss	-12(%rbp), %xmm1
	movaps	%xmm1, %xmm2
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	print_report
	movl	$0, %eax
.L22:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L23
	call	__stack_chk_fail@PLT
.L23:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1103626240
	.align 16
.LC1:
	.long	2147483647
	.long	0
	.long	0
	.long	0
	.align 4
.LC2:
	.long	1073741824
	.align 4
.LC3:
	.long	1120403456
	.align 4
.LC4:
	.long	1117782016
	.align 4
.LC6:
	.long	1114636288
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
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
