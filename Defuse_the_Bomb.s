.data
arr1:     .word 5,7,1,4 # a[4] = {5,7,1,4}
len:      .word 16 # 4*4
target:   .word 3
comma:    .string " "
str:      .string "The answer is "
str2:     .string "No answer."
.text
main:
    la a0 arr1    # load address of the array
    lw a1 target  # load the value of target
    lw a2 len     # load the value of len
    add a2,a2,a0  # turn a2 into the the address of end of array 
    addi a3,a2 -4 # a3 is the address of the last element in array
    jal ra, func
    
    # Exit Program
    li a7, 10
    ecall
    
    
func:
    mv s9 a0 
    beq a1,x0 Zero  # if k == 0, goto Zero
    blt a1,x0 small # if k < 0, goto small
large:
    sub t0, a2,a0    # t0 is the number of times that the loop must run
    addi t1,a0 0        # set t1 the address of a[0]
loop_large:
    addi t0,t0 -4
    mv s0,a1    # s0 = target, which count the times that the inner loop has run
    mv s1,t1    # s1 = the address of the number needs to be added
    addi s2,x0 0
loop_in_large:
    addi s0,s0 -1
    addi s1,s1 4        # s1 = address of the next element
    blt s1 a2 less_than_end # if s1 is smaller than address of the end array a
    add s1,x0,s9
less_than_end:
    lw s3,(0)s1    # load value in s1
    add s2,s2,s3    # add value in s1
    
    bne s0,x0 loop_in_large
    #print result
    mv a0,s2
    li a7, 1
    ecall
    
    la a0, comma
    li a7, 4
    ecall
    
    addi t1,t1 4
    bne t0,x0 loop_large
    ret
    
    
small:
    sub t0, a2, a0    # t0 is the number of times that the loop must run
    addi t1,a0 0        # set t1 the address of a[0]
loopsmall:
    addi t0,t0 -4
    mv s0,a1    # s0 = target, which count the times that the inner loop has run
    mv s1,t1    # s1 = the address of the number needs to be added
    addi s2,x0 0
loop_in_small:
    addi s0,s0,1 # 
    addi s1,s1,-4     # s1 = address of the previous element
    bge s1,s9 gre_than_arr # if s1 is larger than address of array a
    add s1,x0,a3    # if s1 is smaller than address of a, 
                    # move it to the last element of the array. 
gre_than_arr:
    lw s3,(0)s1    # load value in s1
    add s2,s2,s3    # add value in s1
    
    bne s0,x0 loop_in_small
    #print result
    mv a0,s2
    li a7, 1
    ecall
    
    la a0, comma
    li a7, 4
    ecall
    
    addi t1,t1 4
    bne t0,x0 loopsmall    
    ret
    
Zero:
    sub t0, a2,a0
    # Print 0s
loop0:
    
    mv a0,x0
    li a7, 1
    ecall
    
    la a0, comma
    li a7, 4
    ecall
    
    addi t0,t0, -4
    
    bne t0,x0 loop0
    ret
