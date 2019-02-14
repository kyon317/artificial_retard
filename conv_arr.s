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

	movq $0,%r9 	# r9 = i = 0	
	movq %rsi,%rbx
	addq %rcx,%rbx	# rbx = n+m
	subq $2,%rbx	# rbx = n+m-2
loop:
	cmpq %rbx,%r9	# ret when i > n+m-2
	jg end
	call karen
	movq %rax,%r10	# r10 = ladj
	movq %r9,%r11	# r11 = i
	pushq %r9
	movq %rbx,%r9	# r9 = m+n-2
	addq %r11,%r9	# r9 = m+n-i-2

	call karen
	movq %rax,%r11	# r11 = radj
	popq %r9	# restore i
	pushq %rsi

	movq %rdx,%rsi	# rsi = h
	pushq %rdx
	movq %r11,%rdx
	imul $8,%rdx
	addq %rdx,%rsi	# h = h+radj
	popq %rdx
	
	pushq %r11

	movq %r9,%r11	# r11 = i
	incq %r11	# r11 = i+1
	subq %r10,%r11	# r11 = i+1-ladj
	imul $8,%r11	
	addq %rdi,%r11  # x = x + (i+1-ladj)

	pushq %rdi
	movq %r11,%rdi	
	popq %r11
	
	pushq %rdx
	movq %r10,%rdx	# rdx = ladj
	subq %r11,%rdx	# rdx = ladj - radj

	call conv

	movq %rax,(%r8,%r9)
	popq %rdx
	popq %rdi
	popq %rsi
	incq %r9	# i++

	jmp loop	

end:
	popq %r11	# restore scratch registers
	popq %r10
	popq %r9
	popq %rbx
	#movq (%r8),%rax
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
