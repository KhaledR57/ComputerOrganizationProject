.data
	list1 : .space 160 
	list2 : .space 160
	list3 : .space 160
	list4 : .space 160
	all : .space 640   # Request all[80]
.text

main:

	
	li $v0, 10
    syscall
   	jr $ra

get_size : 
	addi $t8 , $a0 , 0
	addi $t0 , $0 , 0
	addi $t1 , $0 , 0
	addi $t2 , $0 , 20
	addi $t3 , $0 , 1
	addi $t5 , $0 , 0 
for :
	slt $t4 , $t1 , $t2
	bne $t4 , $t3 , Endfor
	
	mult $t7 , $t1 , 5   # t7 = 5 * i 
	add $t7 , $t7 , $t8
	lw  $t9 , 0($t7)

	beq  $t9 , $t5 , endif
	addi $t0 , $t0 , 1
	
endif :
	addi $t1 , $t1 , 1
	j for
Endfor :
	addi $v0 , $t0 , 0 



join_Lists :

	addi $sp , $sp, -20      # Make room for 5
	sw $a0 , 0($sp)          # first
	sw $a1 , 4($sp)          # second
	sw $s5 , 8($sp)		  # l1
	sw $s6 , 12($sp)         # l2
	sw $ra , 16($sp)         # return value
	

	addi $s5 , $0 , 0
	addi $s6 , $0 , 0
	addi $t1 , $0 , 1
	addi $t2 , $0 , 2
	addi $t3 , $0 , 3
	addi $t4 , $0 , 4

	la  $s1 , list1
	la  $s2 , list2
	la  $s3 , list3
	la  $s4 , list4	

	bne $a0 , $t1 , if2
	sw $s5 , 0($s1) 
     j  exit1

   if2 : bne $a0 , $t2 , if3
	sw $s5 , 0($s2) 
     j  exit1

   if3 : bne $a0 , $t3 , if4
	sw $s5 , 0($s3) 
     j  exit1

   if4 : bne $a0 , $t4 , exit1
	sw $s5 , 0($s4) 

  exit1 :

	bne $a1 , $t1 , if5
	sw $s6 , 0($s1) 
     j  exit2

   if5 : bne $a1 , $t2 , if6
	sw $s6 , 0($s2) 
     j  exit2

   if6 : bne $a1 , $t3 , if7
	sw $s6 , 0($s3) 
     j  exit2

   if7 : bne $a1 , $t4 , exit2
	sw $s6 , 0($s4) 

  exit2 :

	
	addi $t2 , $0 , 1    # t2 = 1;
	addi $t3 , $0 , 20   # t3 = 20;


	la $a0 , 0($s5)
	jal get_size
	add $t4 , $0 , $v0

        la $a0 , 0($s6)
	jal get_size
	add $t5 , $0 , $v0
 
	add $t6 , $t4 , $t5
	
	slt $t7 , $t3 , $t6
	beq $t7 , $t2 , End    # blt  $t3 , $t6 , End
	
	
	addi $t0 , $0 , 0    # i = 0;
	addi $t1 , $0 , 0    # j = 0;
	
for_loop :
	slt $t5 , $t0 , $t3
	bne $t2 , $t5 , Exit
	slt $t5 , $t1 , $t3
	bne $t2 , $t5 , Exit
	
while1 : 
	sll $t8 , $t0 , 3       # t8 = 8 * i
	add $t8 , $t8 , $s5 
	lw  $s7 , 0($t8)          # need to know how access priority	
	beq $s7 , $0 , ExitWhile1
	addi $t0 , $t0 , 1
	j while1
ExitWhile1 :

while2 :
	sll $t9 , $t1 , 3     # t9 = 8 * j
	add $t9 , $t9 , $s6 
	lw  $t5 , 0($t9)      # need to know how access priority	
	bne $t5 , $0 , ExitWhile2
	addi $t1 , $t1 , 1
	j while2
ExitWhile2 :

	addi $s7 , $t5 , 0     # need to know how access priority and name   l1[i].priority = l2[j].priority; l1[i].name = l2[j].name;
	lw   $t5 , 4($t9)
	sw   $t5 , 4($t8)
	addi $t5 , $0 , 0     # need to know how access priority
	sw   $t5 , 0($t9)
	j for_loop

     End : 
	li $v0 , 4
	la $a0 , message
	syscall
		
Exit :

lw $a0, 0($sp)          #restore a0
lw $a1, 4($sp)          #restore a1
lw $s5 , 8($sp)		 # l1
lw $s6 , 12($sp)         # l2
lw $ra , 16($sp)         # return value
addi $sp, $sp, 20       #restore the stack
jr $ra                  #return to caller 


swap:               #swap method
	addi $sp, $sp, -12  # Make stack room for three

	sw $a0, 0($sp)      # Store a0
	sw $a1, 4($sp)      # Store a1
	sw $a2, 8($sp)      # store a2

	sll $t1, $a1, 2     #t1 = 4a
	add $t1, $a0, $t1   #t1 = array + 4a
	lw $s3, 0($t1)      #s3  t = array[a]

	sll $t2, $a2, 2     #t2 = 4b
	add $t2, $a0, $t2   #t2 = arr + 4b
	lw $s4, 0($t2)      #s4 = arr[b]

	sw $s4, 0($t1)      #arr[a] = arr[b]
	sw $s3, 0($t2)      #arr[b] = t 


	addi $sp, $sp, 12   #Restoring the stack size
	jr $ra          #jump back to the caller

	partition:          #partition method

	addi $sp, $sp, -16  #Make room for 5

	sw $a0, 0($sp)      #store a0
	sw $a1, 4($sp)      #store a1
	sw $a2, 8($sp)      #store a2
	sw $ra, 12($sp)     #store return address

	move $s1, $a1       #s1 = low
	move $s2, $a2       #s2 = high

	sll $t1, $s2, 2     # t1 = 4*high
	add $t1, $a0, $t1   # t1 = all + 4*high
	lw $t2, 4($t1)      # t2 = all[high].name //pivot

	addi $t3, $s1, -1   #t3, i=low -1
	move $t4, $s1       #t4, j=low
	addi $t5, $s2, -1   #t5 = high - 1

forloop: 
    slt $t6, $t5, $t4   #t6=1 if j>high-1, t7=0 if j<=high-1
    bne $t6, $zero, endfor  #if t6=1 then branch to endfor

    sll $t1, $t4, 2     #t1 = j*4
    add $t1, $t1, $a0   #t1 = all + 4j
    lw $t7, 4($t1)      #t7 = all[j].name

    slt $t8, $t2, $t7   #t8 = 1 if pivot < arr[j], 0 if arr[j]<=pivot
    bne $t8, $zero, endfif  #if t8=1 then branch to endfif
    addi $t3, $t3, 1    #i=i+1

    move $a1, $t3       #a1 = i
    move $a2, $t4       #a2 = j
    jal swap        #swap(arr, i, j)

    addi $t4, $t4, 1    #j++
    j forloop

endfif:
    addi $t4, $t4, 1    #j++
    j forloop       #junp back to forloop

endfor:
    addi $a1, $t3, 1        #a1 = i+1
    move $a2, $s2           #a2 = high
    add $v0, $zero, $a1     #v0 = i+1 return (i + 1);
    jal swap            #swap(arr, i + 1, high);

    lw $ra, 12($sp)         #return address
    addi $sp, $sp, 16       #restore the stack
    jr $ra              #junp back to the caller


quick_sort:
	addi $sp, $sp, -16      # Make room for 4

	sw $a0, 0($sp)          # a0
	sw $a1, 4($sp)          # low
	sw $a2, 8($sp)          # high
	sw $ra, 12($sp)         # return address

	move $t0, $a2           #saving high in t0

	slt $t1, $a1, $t0       # t1=1 if low < high, else 0
	beq $t1, $zero, endif       # if low >= high, endif

	jal partition           # call partition 
	move $s0, $v0           # pivot, s0= v0

	lw $a1, 4($sp)          #a1 = low
	addi $a2, $s0, -1       #a2 = pi -1
	jal quick_sort           #call quicksort

	addi $a1, $s0, 1        #a1 = pi + 1
	lw $a2, 8($sp)          #a2 = high
	jal quick_sort           #call quicksort

endif:


	lw $a0, 0($sp)          #restore a0
	lw $a1, 4($sp)          #restore a1
	lw $a2, 8($sp)          #restore a2
	lw $ra, 12($sp)         #restore return address
	addi $sp, $sp, 16       #restore the stack
	jr $ra                  #return to caller 
	
	
put_all : # put all function
	
	addi $t0 , $0 , 0   # j = 0
	addi $t1 , $0 , 1   # i = 0
	addi $t2 , $0 , 20  # t2 = 20
	addi $t3 , $0 , 1
	addi $t9 , $0 , 0

for_one :
	slt $t4 , $t1 , $t2
	bne $t4 , $t3 , end_one
		
	sll $t5 , $t1 , 3       # t5 = 8 * i
	add $t5 , $t5 , $s1 
	lw  $t6 , 0($t5)
	
	beq $t6 , $t9 , end_if1
	sll $t7 , $t0 , 3      # t7 = 8 * j
	add $t7 , $t7 , $s7
	lw  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sw  $t8 , 4($t7)
	
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 1
	j for_one
end_if1:
	addi $t1 , $t1 , 1
	j for_one
end_one :
    
	addi $t1 , $0 , 0
	addi $t6 , $0 , 0
	addi $t8 , $0 , 0
	
for_two :
	slt $t4 , $t1 , $t2
	bne $t4 , $t3 , end_two
		
	sll $t5 , $t1 , 3       # t5 = 8 * i
	add $t5 , $t5 , $s2 
	lw  $t6 , 0($t5)
	
	beq $t6 , $t9 , end_if2
	sll $t7 , $t0 , 3      # t7 = 8 * j
	add $t7 , $t7 , $s7
	lw  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sw  $t8 , 4($t7)
	
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 1
	j for_two
end_if2:
	addi $t1 , $t1 , 1
	j for_two
end_two :


	addi $t1 , $0 , 0
	addi $t6 , $0 , 0
	addi $t8 , $0 , 0
	
for_three :
	slt $t4 , $t1 , $t2
	bne $t4 , $t3 , end_three
		
	sll $t5 , $t1 , 3       # t5 = 8 * i
	add $t5 , $t5 , $s3 
	lw  $t6 , 0($t5)
	
	beq $t6 , $t9 , end_if3
	sll $t7 , $t0 , 3       # t7 = 8 * j
	add $t7 , $t7 , $s7
	lw  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sw  $t8 , 4($t7)
	
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 1
	j for_three
end_if3:
	addi $t1 , $t1 , 1
	j for_three
end_three :

	addi $t1 , $0 , 0
	addi $t6 , $0 , 0
	addi $t8 , $0 , 0
	
for_four :
	slt $t4 , $t1 , $t2
	bne $t4 , $t3 , end_four
		
	sll $t5 , $t1 , 3       # t5 = 8 * i
	add $t5 , $t5 , $s4 
	lw  $t6 , 0($t5)
	
	beq $t6 , $t9 , end_if4
	sll $t7 , $t0 , 3       # t7 = 8 * j
	add $t7 , $t7 , $s7
	lw  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sw  $t8 , 4($t7)
	
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 1
	j for_four
end_if4:
	addi $t1 , $t1 , 1
	j for_four
end_four :



update_priority:              		#void update_priority(char name, int priority) 
   	# prologue                	
   	addiu $sp, $sp, -20
   	sw   $ra, 16($sp)
	sw   $s3, 12($sp)              
	sw   $s2, 8($sp)
	sw   $s1, 4($sp)
	sw   $s0, 0($sp)

   	# function body
	move $s0, $a0
	move $s1, $a1
	li   $s2, 0               	  # i = 0
	li   $s3, 20		  	  #I considered 20 is $s3 the limit in for loop

	loop:
   		bgt  $s2, $s3, end_loop   # if (i > 20) break from for loop
   		li   $t0, 4		  # each array element is 5 bytes
   		mul  $t0, $s2, $t0        # index -> byte offset
		la   $t1, list1		  #
		add  $t2, $t1, $t0	  #
		lw   $t3, 4($t2)		  #
		bne  $t3, $s0, case2      # if list1[i].name != name then branch to case2
		lw   $t4, 0($t2)		  #
		sw   $s1, -100($t4)

	case2:
		la   $t1, list2		  #
		add  $t2, $t1, $t0	  #
		lw   $t3, 4($t2)	  #
		bne  $t3, $s0, case3      # if list2[i].name != name then branch to case3
		lw   $t4, 0($t2)
		sw   $s1, -100($t4)

	case3:
		la   $t1, list3
		add  $t2, $t1, $t0
		lw   $t3, 4($t2)
		bne  $t3, $s0, case4      # if list3[i].name != name then branch to case4
		lw   $t4, 0($t2)
		sw   $s1, -100($t4)

	case4:
		la   $t1, list4
		add  $t2, $t1, $t0
		lw   $t3, 4($t2)
		bne  $t3, $s0, endif      # if list4[i].name != name then branch to endif
		lw   $t4, 0($t2)
		sw   $s1, -100($t4)

	endif:
   		addi $s2, $s2, 1          # i++
   		j    loop		  #jump to label loop
	end_loop:
           
   	# epilogue 
        lw   $s0, 0($sp)          
	lw   $s1, 4($sp)
	lw   $s2, 8($sp)
	lw   $s3, 12($sp)
	lw   $ra, 16($sp)
	addiu $sp, $sp, 20
	li $v0, 10
    	syscall
   	jr   $ra
   	
   	
proccess: # process all

	addi $a0 , $0 , $s1
	jal get_size
	add $t0 , $0 , $v0
	
	addi $a1 , $0 , $s2
	jal get_size
	add $t1 , $0 , $v0 
	
	addi $a2 , $0 , $s3
	jal get_size
	add $t2 , $0 , $v0
	
	addi $a3 , $0 , $s4
	jal get_size
	add $t3 , $0 , $v0
	
	add $t4 , $t0 , $t1
	add $t4 , $t4 , $t2
	add $t4 , $t4 , $t3
	
while:
	addi $t5 , $0 , 1
	bne $t4 , $t5 ,exitwhile
	jal process_request
	j while 
	
exitwhile:	

	li $v0, 10
    	syscall
   	jr   $ra
