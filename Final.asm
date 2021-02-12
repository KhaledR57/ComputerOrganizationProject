.data
	
	prompt: .asciiz "Please Enter The Number Of The Operation You Want\n"
	addr: .asciiz "1 - Add Request.\n"
	process: .asciiz "2 - Process a Request.\n"
	join: .asciiz "3 - Join Lists.\n"
	empty: .asciiz "4 - Empty all lists.\n"
	update: .asciiz "5 - Update Request Priority.\n"
	processall: .asciiz "6 - Process all requests in all lists.\n"
	search: .asciiz "7 - Search on specific Request use Binary Search on lists.\n"
	tirm: .asciiz "8 - For Exit\n"
	limitex: .asciiz "Size Limit Exceeded"
	done: .asciiz "Done!"
	enterreq: .asciiz "Enter Request Name: "
	enterpir: .asciiz "Enter Request Priority: "
	message1 :  .asciiz  "Request :"
	message2 : .asciiz  "\nPriority: :"
	
	name: .byte
	priority: .word
	choice: .word 8
	
	list1 : .space 160 
	list2 : .space 160
	list3 : .space 160
	list4 : .space 160
	all : .space 640   # Request all[80]
	
.text


main:

whilo:
	 la $a0, prompt     # address of prompt
     li $v0, 4
     syscall
     
     la $a0, addr     # address of addr
     li $v0, 4
     syscall
     
     la $a0, process    # address of process
     li $v0, 4
     syscall
     
     la $a0, join     # address of prompt
     li $v0, 4
     syscall
     
     la $a0, empty     # address of empty
     li $v0, 4
     syscall
     
     la $a0, update     # address of empty
     li $v0, 4
     syscall
     
     la $a0, processall     # address of processall
     li $v0, 4
     syscall
     
     la $a0, search     # address of search
     li $v0, 4
     syscall
     
     la $a0, tirm     # address of tirm
     li $v0, 4
     syscall

				
     li $v0, 5		# read the choice
     syscall
     sw $v0, choice  
     
     lw $t0,choice
     

	choice1:
		bne $t0,1,choice2
		
        jal add_request    
            
		j whilo
	choice2:
		bne $t0,2,choice3
		li $v0,4
		la $a0,process
		syscall
		j whilo
	choice3:
		bne $t0,3,choice4
		li $v0,4
		la $a0,join
		syscall
		j whilo
	choice4:
		bne $t0,4,choice5
		li $v0,4
		la $a0,empty
		syscall
		j whilo
	choice5:
		bne $t0,5,choice6
		li $v0,4
		la $a0,update
		syscall
		j whilo
	choice6:
		bne $t0,6,choice7
		li $v0,4
		la $a0,processall
		syscall
		j whilo
	choice7:
		bne $t0,7,choice8
		li $v0,4
		la $a0,search
		syscall
		j whilo
	choice8:
		bne $t0,8,exit
		li $v0,4
		la $a0,done
		syscall
		
exit:
	li $v0, 10
    syscall
   	jr $ra



add_request:
	li $v0,4
	la $a0,enterpir
	syscall
	
	
    li $v0, 5 # read the priority
    syscall
    move $t0, $v0
	
	li $v0,1
	move $a0,$t0
	syscall


	li $v0,4
	la $a0,enterreq
	syscall
		
    li $v0, 12		# read the character
    syscall
    move $t4,$v0
	
	li $v0,11
	move $a0,$t4
	syscall
	
     
    la  $s1 , list1
	la  $s2 , list2
	la  $s3 , list3
	la  $s4 , list4	    
       
	la $a0 , ($s1)    	# Load list1 address
	jal get_size   	 	# call list1 size
	li $t2, 20      	# max size 20
	move $t1, $v0   	# store list1 size

	li $v0,1
	move $a0,$t1
	syscall 
	
	bgt  $t1 , $t2, else_if_1
while_1:
	li $t3,0         	# int i = 0
	sll $t7 , $t3 , 3 	# t7 = 8 * i
	add $t7 , $t7 , $s1
	lw $t9 , 0($t7)

 	beq $t9 , $0 , end_while_1
	addi $t3 , $t3 , 1
	j while_1
	
	end_while_1 :
	sw $t0, 0($t7)  # store priority
	sb $t4, 4($t7)  # store name
	j exit_add
	
else_if_1:
	la $a0 ,($s2)    	# Load list2 address
	jal get_size   	 	# call list2 size
	li $t2, 20      	# max size 20
	move $t1, $v0   	# store list2 size
	bgt  $t1 , $t2, else_if_2
while_2:
	li $t3,0         	# int i = 0
	sll $t7 , $t3 , 3 	# t7 = 8 * i
	add $t7 , $t7 , $s2
	lw $t9 , 0($t7)

 	beq $t9 , $0 , end_while_2
	addi $t3 , $t3 , 1
	j while_2
	
	end_while_2 :
	sw $t0, 0($t7)  # store priority
	sb $t4, 4($t7)  # store name
	j exit_add
	
	
	
else_if_2:
	la $a0 , ($s3)    	# Load list3 address
	jal get_size   	 	# call list3 size
	li $t2, 20      	# max size 20
	move $t1, $v0   	# store list2 size
	bgt  $t1 , $t2, else_if_3
while_3:
	li $t3,0         	# int i = 0
	sll $t7 , $t3 , 3 	# t7 = 8 * i
	add $t7 , $t7 , $s3
	lw $t9 , 0($t7)

 	beq $t9 , $0 , end_while_3
	addi $t3 , $t3 , 1
	j while_3
	
	end_while_3 :
	sw $t0, 0($t7)  # store priority
	sb $t4, 4($t7)  # store name
	j exit_add
	
	
else_if_3:
	la $a0 , ($s4)    	# Load list4 address
	jal get_size   	 	# call list4 size
	li $t2, 20      	# max size 20
	move $t1, $v0   	# store list2 size
	bgt  $t1 , $t2, exit_add
while_4:
	li $t3,0         	# int i = 0
	sll $t7 , $t3 , 3 	# t7 = 8 * i
	add $t7 , $t7 , $s4
	lw $t9 , 0($t7)

 	beq $t9 , $0 , end_while_4
	addi $t3 , $t3 , 1
	j while_4
	
	end_while_4 :
	sw $t0, 0($t7)  # store priority
	sb $t4, 4($t7)  # store name
	j exit_add	
	
exit_add:
	jr $ra



get_size :   				# Get Size Function returns the number of elements in an array
        addi   $sp,$sp,-8
        sw  $ra,0($sp)
        sw  $a0,4($sp)
        li  $t1,0

Whileo:
        lw  $t2,0($a0)
        beq $t2,$0,endo
        addi    $t1,$t1,1
        addi    $a0,$a0,4
        j   Whileo

endo:    
        move $v0,$t1
        lw  $ra,0($sp)
        lw  $a0,4($sp)
        addi    $sp,$sp,8
        jr  $ra



join_Lists :				#Join List Function

	addi $sp , $sp, -20      # Make room for 5
	sw $a0 , 0($sp)          # first
	sw $a1 , 4($sp)          # second
	sw $s5 , 8($sp)		  	 # l1
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
	lb   $t5 , 4($t9)
	sb   $t5 , 4($t8)
	addi $t5 , $0 , 0     # need to know how access priority
	sw   $t5 , 0($t9)
	j for_loop

     End : 
	li $v0 , 4
	la $a0 , limitex
	syscall
		
Exit :

lw $a0, 0($sp)          #restore a0
lw $a1, 4($sp)          #restore a1
lw $s5 , 8($sp)		 # l1
lw $s6 , 12($sp)         # l2
lw $ra , 16($sp)         # return value
addi $sp, $sp, 20       #restore the stack
jr $ra                  #return to caller 



swap:               	#swap method
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
	jr $ra          	#jump back to the caller



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
	beq $t1, $zero, endif0       # if low >= high, endif

	jal partition           # call partition 
	move $s0, $v0           # pivot, s0= v0

	lw $a1, 4($sp)          #a1 = low
	addi $a2, $s0, -1       #a2 = pi -1
	jal quick_sort           #call quicksort

	addi $a1, $s0, 1        #a1 = pi + 1
	lw $a2, 8($sp)          #a2 = high
	jal quick_sort           #call quicksort

endif0:

	lw $a0, 0($sp)          #restore a0
	lw $a1, 4($sp)          #restore a1
	lw $a2, 8($sp)          #restore a2
	lw $ra, 12($sp)         #restore return address
	addi $sp, $sp, 16       #restore the stack
	jr $ra                  #return to caller 
	
	
	
put_all : 				# put all function
	
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
	lb  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sb  $t8 , 4($t7)
	
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
	lb  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sb  $t8 , 4($t7)
	
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
	lb  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sb  $t8 , 4($t7)
	
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
	lb  $t8 , 4($t5)
	sw  $t6 , 0($t7)
	sb  $t8 , 4($t7)
	
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 1
	j for_four
	
end_if4:
	addi $t1 , $t1 , 1
	j for_four
end_four :



update_priority:              		#void update_priority(char name, int priority) 
   	# prologue                	
   	addi $sp, $sp, -20
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
		bne  $t3, $s0, endif5      # if list4[i].name != name then branch to endif
		lw   $t4, 0($t2)
		sw   $s1, -100($t4)

	endif5:
   		addi $s2, $s2, 1          # i++
   		j    loop		  #jump to label loop
	end_loop:
           
   	# epilogue 
        lw   $s0, 0($sp)          
	lw   $s1, 4($sp)
	lw   $s2, 8($sp)
	lw   $s3, 12($sp)
	lw   $ra, 16($sp)
	addi $sp, $sp, 20
	li $v0, 10
    	syscall
   	jr   $ra
   	
   	
binary_search: #void binary_search(int l, int r, char name)
move $s7 , $ra
addiu $sp, $sp, -24  #6 room in memory       
sw   $a0, 0($sp) #i
sw   $a1, 4($sp) #r
sw   $a2, 8($sp) #name
sw   $s5 , 12($sp)
sw   $s6 , 16($sp)
sw   $ra, 20($sp) #return address

la  $s0 , all
la  $s1 , list1
la  $s2 , list2
la  $s3 , list3
la  $s4 , list4	

#put_all function 
jal put_all # call put_all()
jr $ra
#quick_sort function
addi $s5 , $0 , 0 #$s5 = 0
addi $s6 , $0 , 0 #$s6 = 0
la $a0 , 0($s1)
jal get_size #(get_size(list1)
jr $ra#ignor overloading
move $s5 , $v0#add fiest return value of get size of list1 to $s5


la $a0 , 0($s2)
jal get_size #(get_size(list2)
jr $ra#ignor overloading
add $s5 , $s5 , $v0 #add new return value of get size of list2 to $s5
la $a0 , 0($s3)
jal get_size #(get_size(list3)
jr $ra#ignor overloading
add $s5 , $s5 , $v0 #add new return value of get size of list3 to $s5


la $a0 , 0($s3)
jal get_size #(get_size(list4)
jr $ra #ignor overloading

add $s5 , $s5 , $v0 #add new return value of get size of list4 to $s5
addi $t4 , $t4 , 1 #make t4 =  1 to subtract from s5 in the next step
sub $s5 , $s5 , $t4 #(get_size(list1) + get_size(list2) + get_size(list3) + get_size(list4)) - 1 (second parameter in quick sort)
addi $t0 ,$0 , 0 #(first parameter in quick sort = 0) 

move $a0 , $t0 #send first parameter to quick sort
move $a1 , $s5 #send second parameter to quick sort
jal  quick_sort # call quick_sort
jr $ra #ignor overloading
# first if statment
blt $a1,$a0,Exit # if (r < l) go to exit 
F1:
addi $t0, $0,0 #mid = 0 
addi $t5 , $t5 , 1 #make t5 = 1 to subtract from r in the next step
sub $t1 ,$a1 , $t5 # r-1
addi $t2 , $0 , 2 #2
div $t3 , $t1 , $t2 #(r-1)/2
add $t0 , $a0 , $t3 #i + (r-1)/2

#second if statment  if (all[mid].name == name)
sll $s0 , $t0, 3 #all = 8 * mid
add $s0, $s0 , $s5
lw $t6 , 4($s0)#need to know access 
bne $t6 , $0 , Exit_if1 #if not equal

li $v0 , 4
la $a0 , message1
syscall
#print all[mid].name bas ana me4 3aref :"

li $v0 , 4
la $a0 , message2
syscall
#print all[mid].priority bas ana bardo me4 3aref :(

Exit_if1:#if not equal
#if (all[mid].name > name)
sll $s0 , $t0 , 3 #all = 8 * mid
add $s0 , $s0 , $s6
lw  $t7, 4($s0)#need to know access 
blt $t7 , $0 , Exit_if2 #less than
#return statment
addi $t4 , $t4 , 1 #t4 = 1
sub $t0 , $t0 , $t4 #mid - 1
move $a1 , $t0 
jal binary_search 
jr $s7 #to back to this register again 


Exit_if2:#if less than
#second return statment 
li $t4 , 1 #t4 = 1
add $t0 , $t0 , $t4 #mid + 1
move $a0 , $t0 
jal binary_search 
jr $s7 #to back to this register again 
  
Exit0:
lw $a0 , 0($sp)#restor
lw $a1 , 4($sp)#restor
lw $a2 , 8($sp)#restor
lw $s5 , 12($sp)#restor
lw $s6 , 16($sp)#restor
lw $ra , 20($sp)#restor
addi $sp , $sp , 24 #add 24 in stack pointer
jr $ra 

   	
proccess_all: # process all

	add $a0 , $0 , $s1
	#jal get_size
	add $t0 , $0 , $v0
	
	add $a1 , $0 , $s2
	#jal get_size
	add $t1 , $0 , $v0 
	
	add $a2 , $0 , $s3
	#jal get_size
	add $t2 , $0 , $v0
	
	add $a3 , $0 , $s4
	#jal get_size
	add $t3 , $0 , $v0
	
	add $t4 , $t0 , $t1
	add $t4 , $t4 , $t2
	add $t4 , $t4 , $t3
	
while:
	add $t5 , $0 , 1
	bne $t4 , $t5 ,exitwhile
	#jal process_request        ---------------------------
	j while 
	
exitwhile:	

   	jr   $ra
