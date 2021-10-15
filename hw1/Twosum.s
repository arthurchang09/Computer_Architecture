.data
arr1:     .word 5,4,3,7 # a[5] = {5,4,3,7}
len:      .word 16 # 4*4
target:   .word 11
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
    jal ra, loop1
    
    # Exit Program
    li a7, 10
    ecall
    
loop1:
    lw s4, 0(t0)     # load a[i]
    addi t1,t0,4     # j = i + 1
loop2:
    lw  s5, 0(t1)    # load a[j]
    add s6,s5,s4     # s6 = a[i] + a[j] 
    beq s6,s2, print_ans    # if a[i] + a[j] == target, goto print_ans
    addi t1,t1,4     # j++
    blt t1, s3 loop2 #continue loop2
    
    addi t0,t0,4     # i++
    blt t0,s3,loop1  # continue loop1
    
    # Print NO Answer message
    la a0, str2
    li a7, 4
    ecall
    ret
    
print_ans:
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
    