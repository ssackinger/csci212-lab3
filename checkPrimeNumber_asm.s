.data
.text

.global checkPrimeNumber
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
