	.globl conv_arr
	# char*x 	%rdi		1st
	# int n 	%rsi		2nd
	# char*h 	%rdx		3rd
	# int m 	%rcx		4th
	# char*result 	%r8		5th

conv_arr:
	pushq %rdi	# rsp+24	*x
	pushq %rsi	# rsp+16	n 15
	pushq %rdx	# rsp+8		*h
	pushq %rcx	# rsp		m 3
	

	movq $0,%r9 		# r9 = i = 0	
	movq 16(%rsp),%r10	
	addq (%rsp),%r10	# r10 = n+m
	subq $2,%r10		# r10 = n+m-2
loop:
	
	cmpq %r10,%r9		
	jg end
	movq %r9,%rdi
	incq %rdi
	movq (%rsp),%rsi
test1:
	call min
test2:
	movq %rax,%rdx		# rdx = ladj 
test3:
	movq %rdi,%rcx
	movq %r10,%rdi
	subq %r9,%rdi		# rdi = m+n-i-2
	incq %rdi		# rdi = m+n-i-1
test4:	
	call min
test5:	
	subq %rax,%rsi		# rsi = radj
		
	movq 24(%rsp),%rdi	# rdi = x
	addq %rcx,%rdi		# rdi = x+i+1
	subq %rdx,%rdi		# rdi = x + (i+1-ladj)
	subq %rsi,%rdx		# rdx = ladj - radj	
	addq 8(%rsp),%rsi	# rsi = h+radj
test6:	
	call conv
	movb %al,(%r8,%r9)
test7:
	incq %r9
	xorq %rax,%rax
	

	jmp loop	

end:
	
	popq %rcx
	popq %rdx
	popq %rsi
	popq %rdi
	xorq %rax,%rax
test8:
	ret

