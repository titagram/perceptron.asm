; === Percettrone Semplice in NASM x86 (32-bit) ===
; Iterates through a truth table of inputs to demonstrate logic gates (OR logic by default).
; Compilazione (Linux): make linux
; Compilazione (Windows): make win

SECTION .data
    ; Input truth table: (x1, x2) pairs
    ; 0,0 -> 0
    ; 0,1 -> 1
    ; 1,0 -> 1
    ; 1,1 -> 1
    inputs db 0, 0,  0, 1,  1, 0,  1, 1
    num_inputs equ 4

    ; Weights and Bias for OR gate logic (w1=1, w2=1, bias=-1 => x1+x2-1 >= 0)
    w1     db 1
    w2     db 1
    bias   db -1

    ; Format string for printf: "Inputs: (x1, x2) -> Output: y\n"
    fmt    db "Inputs: (%d, %d) -> Output: %d", 10, 0

SECTION .text
    ; Define C functions for Windows (adds underscore) or Linux
    %ifdef WIN32
        global _main
        extern _printf
        %define main _main
        %define printf _printf
    %else
        global main
        extern printf
    %endif

main:
    ; Preserve ESI register (callee-saved) as we use it for loop counter
    push esi

    ; Initialize loop counter
    xor esi, esi

loop_start:
    cmp esi, num_inputs
    je loop_end

    ; Calculate array index offset: offset = esi * 2
    mov eax, esi
    shl eax, 1     ; Multiply by 2

    ; Load inputs x1 and x2
    movzx ecx, byte [inputs + eax]     ; x1 into ECX
    movzx edx, byte [inputs + eax + 1] ; x2 into EDX

    ; Calculate weighted sum: sum = (x1 * w1) + (x2 * w2) + bias

    ; Term 1: x1 * w1
    mov eax, ecx           ; EAX = x1
    movsx edi, byte [w1]   ; Sign-extend w1 to 32-bit
    imul eax, edi          ; EAX = x1 * w1

    ; Term 2: x2 * w2
    mov ebx, edx           ; EBX = x2
    movsx edi, byte [w2]   ; Sign-extend w2 to 32-bit
    imul ebx, edi          ; EBX = x2 * w2

    ; Sum terms
    add eax, ebx           ; EAX = (x1*w1) + (x2*w2)

    ; Add bias
    movsx edi, byte [bias] ; Sign-extend bias to 32-bit
    add eax, edi           ; EAX = sum + bias

    ; Activation Function (Step)
    ; If sum >= 0, output = 1, else 0
    cmp eax, 0
    setge al               ; AL = 1 if EAX >= 0, else 0
    movzx eax, al          ; Zero-extend AL to EAX (output)

    ; Print result: printf(fmt, x1, x2, output)
    ; Arguments pushed in reverse order (C declaration)
    push eax               ; Output
    push edx               ; x2
    push ecx               ; x1
    push fmt               ; Format string
    call printf
    add esp, 16            ; Clean up stack (4 arguments * 4 bytes)

    ; Next iteration
    inc esi
    jmp loop_start

loop_end:
    ; Restore ESI
    pop esi

    ; Return 0
    xor eax, eax
    ret
