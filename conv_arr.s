	.globl conv_arr
	# char*x 	%rdi		1st
	# int n 	%rsi		2nd
	# char*h 	%rdx		3rd
	# int m 	%rcx		4th
	# char*result 	%r8		5th
conv_arr:
	pushq %rbx	# save scratch registers
	pushq %r9
	pushq %r10
	pushq %r11
	pushq %r12
	

	movq $0,%r9 	# r9 = i = 0	
	movq %rsi,%rbx
	addq %rcx,%rbx	# rbx = n+m
	subq $2,%rbx	# rbx = n+m-2
loop:
	cmpq %rbx,%r9	# ret when i > n+m-2
	jg end
	
	pushq %rdi
	movq %r9,%rdi
	incq %rdi
	pushq %rsi
	movq %rcx,%rsi
	call min
test1:
	movq %rax,%r10	# r10 = ladj
	popq %rsi
	popq %rdi
	
	pushq %rdi
	movq %rbx,%rdi	# rdi = m+n-2
	subq %r9,%rdi	# rdi = m+n-2-i
	incq %rdi	# rdi = m+n-(i+1)
	pushq %rsi
	movq %rcx,%rsi	# rsi = m	
	call min
test2:
	movq %rcx,%r11	# r11 = m
	subq %rax,%r11	# r11 = m-min

	popq %rsi
	popq %rdi

	pushq %rsi

	movq %rdx,%rsi	# rsi = h

testrsi1:
	movq %r11,%r12
	imul $8,%r12
	addq %r12,%rsi	# rsi = h + radj
testrsi2:	
	pushq %r11	# save radj

	movq %r9,%r11	# r11 = i
	incq %r11	# r11 = i+1
	subq %r10,%r11	# r11 = i+1-ladj
	movq %r11,%r12
	imul $8,%r11
	addq %rdi,%r11
	movq %rdi,%r12
	movq %r11,%rdi

	popq %r11	# restore radj
	
	pushq %rdx
	movq %r10,%rdx	# rdx = ladj
	subq %r11,%rdx	# rdx = ladj - radj

	movq $0,%r10
	movb (%rdi),%r10b
	movq %r10,(%rdi)
	movq $0,%r10
	movb (%rsi),%r10b
	movq %r10,(%rsi)
	call conv
test3:
	

	movb %al,(%r8,%r9)
test4:
	popq %rdx
	movq %r12,%rdi
	popq %rsi
	incq %r9	# i++

	jmp loop	

end:
	popq %r12	# restore scratch registers
	popq %r11	
	popq %r10
	popq %r9
	popq %rbx
	
	ret

karen:
	pushq %rdi
	pushq %rsi
	movq %r9,%rdi
	incq %rdi
	movq %rcx,%rsi
	call min
	popq %rsi
	popq %rdi
	ret	
