.data
arr1:     .word 4,5,8,12 # a[5] = {4,5,8,12}
len:      .word 16 # 4*4
target:   .word 16
comma:    .string ", "
str:      .string "The answer is "
str2:     .string "No answer."
.text
main:
    la s0 arr1    #load address of the array
    lw s2 target
    lw s3 len
    add s3,s3,s0    
    addi t0,s0,0    # i = 0
    addi t1,s3,-4   # j = len -1
    jal ra, loop1
    
    # Exit Program
    li a7, 10
    ecall
    
loop1:
    bge t0,t1 No_ans # i < j continue the loop
    lw t2,0(t0)      # load a[i]
    lw t3,0(t1)      # load a[j]
    add t4,t2,t3     # t4 = a[i] + a[j]
    beq t4,s2 print_ans # if a[i] + a[j] == target, goto print ans
    blt t4,s2 small
    addi t1,t1,-4    # j--
    j loop1
small:
    addi t0,t0,4    # i++
    j loop1
    ret
No_ans:
    la a0, str2
    li a7, 4
    ecall
    ret
print_ans:
    # transform the address into the number of position in the array
    sub s4,t0,s0 
    sub s5,t1,s0 
    srli s4,s4,2 
    srli s5,s5,2 
    addi s4,s4,1
    addi s5,s5,1
    # Print answer
    la a0, str
    li a7, 4
    ecall
    mv a0,s4
    li a7, 1
    ecall
    la a0, comma
    li a7, 4
    ecall
    mv a0, s5
    li a7, 1
    ecall
    ret
