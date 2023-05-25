
unsigned_divide:
    push {r2}
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

checkPrimeNumber
    push {r1-r4, lr}

    mov r2, r0
    mov r3, #2                  @divide inputted number by 2
    bl unsigned_divide

    mov r4, r0

    @for loop from 2 to half of inputted num n

    @if inputted number mod j is 0

        @update flag to false
        @can exit here because if it evaluates to true one time then its composite regardless

    @return only the flag to main
