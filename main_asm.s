.data

.balign 4
prompt: .asciz "Enter two positive integers:\t"

.balign 4
format: .asciz "Prime numbers between %d and %d are:\t"

.balign 4
num_output: .asciz "%d "

.balign 4
scan_pattern: .asciz "%d %d"

.balign 4
number_read_start: .word 0

.balign 4
number_read_end: .word 0

.text



@.global checkPrimeNumber
checkPrimeNumber:                @r0 is incoming #, returns 1 or 0 in r0
    push {r1, r2, r7, lr}

                                @udiv r9, r0, #2

    cmp r0, #2
    bne checkPrimeNumber_checkEven
    mov r0, #1
    b checkPrimeNumber_done

checkPrimeNumber_checkEven:
    ands r1, r0, #1
    beq checkPrimeNumber_notPrime

    mov r7, #3                  @start testing at 3

checkPrimeNumber_loop:
    mul r1, r7, r7
    cmp r1, r0
    ble checkPrimeNumber_testPrime
    mov r0, #1                  @set flag true
    b checkPrimeNumber_done

checkPrimeNumber_testPrime:     @calculate mod

    udiv r1, r0, r7
    mul r2, r1, r7
    subs r1, r0, r2
    beq checkPrimeNumber_notPrime

    add r7, r7, #2
    b checkPrimeNumber_loop

checkPrimeNumber_notPrime:
    mov r0, #0

checkPrimeNumber_done:          @return only the flag to main

    pop {r1, r2, r7, lr}
    bx lr





.global main
main:
    push {lr}

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_scan_pattern         /* r0 ← &scan_pattern */
    ldr r1, address_of_number_read_start    /* r2 ← &number_read */
    ldr r2, address_of_number_read_end    /* r2 ← &number_read */
    bl scanf                                /* call to scanf */

    ldr r1, address_of_number_read_start
    ldr r1, [r1]
    ldr r2, address_of_number_read_end
    ldr r2, [r2]

    add r9, r0, #1                  @counter setup

    ldr r0, address_of_format
    bl printf

main_loop:
    cmp r9, r2
    bge main_done

    mov r0, r9
    bl checkPrimeNumber              @r0 is now the flag
    cmp r0, #1

    bne main_iterate

    ldr r0, address_of_num_output
    mov r1, r9
    bl printf

main_iterate:
    add r9, r9, #1
    b main_loop

main_done:
    mov r0, #0

    pop {lr}
    bx lr                            /* return from main using lr */


address_of_prompt: .word prompt
address_of_scan_pattern: .word scan_pattern
address_of_number_read_start: .word number_read_start
address_of_number_read_end: .word number_read_end
address_of_format: .word format
address_of_num_output: .word num_output

.global printf
.global scanf
