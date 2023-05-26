/*
unsigned_divide:
    push {r1, r2, lr}
    mov r2, r1
    mov r1, r0

    mov r0, #0

    b .Ldivide_check
    .Ldivide_loop:
        add r0, r0, #1          @add 1 to quotient
        sub r1, r1, r2          @subtract r2 from r1 once
    .Ldivide_check:
        cmp r1, r2
        bhs .Ldivide_loop

    pop {r2}
    bx lr
*/


checkPrimeNumber:                @r0 is incoming #, returns 1 or 0 in r0
    push {r1, r2, r7, lr}

                                @udiv r9, r0, #2

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


/*
                                @mov r3, #2 -- old call if udiv doesnt work                  @divide inputted number by 2
    mov r3, r0                  @copy input num to backup register

    udiv r0, r0, #2             @bl unsigned_divide -- old call if udiv doesnt work
    mul r1, r0, #2
    sub r2, r3, r1

    mov r4, r0

    @for loop from 2 to half of inputted num n

                                @if inputted number mod j is 0

        @update flag to false
        @can exit here because if it evaluates to true one time then its composite regardless
*/

