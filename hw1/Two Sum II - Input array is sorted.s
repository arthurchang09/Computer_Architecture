.data
arr1:     .word 4,5,8,12 # a[4] = {4,5,8,12}
len:      .word 16 # 4*4
target:   .word 12
comma:    .string ", "
str:      .string "The answer is "
str2:     .string "No answer."
.text
main:
    la a0 arr1    # load address of the array
    lw a1 target  # load the value of target
    lw a2 len     # load the value of len
    add a2,a2,a0  # turn a2 into the end of array 
    jal ra, func
    
    # Exit Program
    li a7, 10
    ecall
func: 
    addi t0,a0,0    # i = 0
    addi t1,a2,-4   # j = len -1    
loop1:
    bge t0,t1 No_ans # i < j continue the loop
    lw t2,0(t0)      # load a[i]
    lw t3,0(t1)      # load a[j]
    add t4,t2,t3     # t4 = a[i] + a[j]
    beq t4,a1 print_ans # if a[i] + a[j] == target, goto print ans
    blt t4,a1 small
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
    sub s4,t0,a0 
    sub s5,t1,a0 
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
