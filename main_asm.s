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

.global main
main:
    push {lr}

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_scan_pattern         /* r0 ← &scan_pattern */
    ldr r1, address_of_number_read_start    /* r2 ← &number_read */
    ldr r2, address_of_number_read_end    /* r2 ← &number_read */
    bl scanf                                /* call to scanf */

    ldr r0, address_of_number_read_start
    ldr r0, [r0]
    ldr r1, address_of_number_read_end
    ldr r1, [r1]

    add r9, r0, #1                  @counter setup

main_loop:
    cmp r9, r1
    bge main_done

    mov r0, r9
    b checkPrimeNumber              @r0 is now the flag
    cmp r0, #1

    bne main_iterate

    mov r0, address_of_num_output
    mov r1, r9
    bl printf
    b main_loop                     @restart

main_iterate:
    add r9, r9, #1
    b main_loop

main_done:
    mov r0, #0

    pop {lr}
    bx lr                            /* return from main using lr */


address_of_prompt: .word prompt
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_format: .word format
address_of_num_output: .word num_output

.global printf
.global scanf
