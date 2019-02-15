	.globl conv_arr
	# char*x 	%rdi		1st
	# int n 	%rsi		2nd
	# char*h 	%rdx		3rd
	# int m 	%rcx		4th
	# char*result 	%r8		5th

conv_arr:
	pushq %r10	# save scratch register
	pushq %r9
	pushq %rdi	# rsp+24	*x
	pushq %rsi	# rsp+16	n 15
	pushq %rdx	# rsp+8		*h
	pushq %rcx	# rsp		m 3
	

	movq $0,%r9 		# r9 = i = 0	
	movq 16(%rsp),%r10	
	addq (%rsp),%r10	# r10 = n+m
	subq $2,%r10		# r10 = n+m-2
loop:

	cmpq %r10,%r9		# end loop when i > n+m-2
	jg end
	movq %r9,%rdi		# rdi = i+1
	incq %rdi
	movq (%rsp),%rsi	# rsi = m
	call min
	movq %rax,%rdx		# rdx = ladj 
	movq %rdi,%rcx
	movq %r10,%rdi
	subq %r9,%rdi		# rdi = m+n-i-2
	incq %rdi		# rdi = m+n-i-1
	call min
	subq %rax,%rsi		# rsi = radj
	movq 24(%rsp),%rdi	# rdi = x
	addq %rcx,%rdi		# rdi = x+i+1
	subq %rdx,%rdi		# rdi = x + (i+1-ladj)
	subq %rsi,%rdx		# rdx = ladj - radj	
	addq 8(%rsp),%rsi	# rsi = h+radj
	call conv
	movb %al,(%r8,%r9)	# result = conv(x + (i+1-ladj), h + radj, ladj-radj)
	incq %r9
	jmp loop	

end:
	
	popq %rcx	#restore registers
	popq %rdx
	popq %rsi
	popq %rdi
	popq %r9
	popq %r10

	ret
