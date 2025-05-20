; === Percettrone XOR semplificato in NASM x86 (32-bit) ===
; Compilazione: nasm -f win32 percettrone.asm && gcc -m32 -o percettrone percettrone.obj
; Esecuzione: ./percettrone

SECTION .data
    ; Input binari: prova con x1 = 1, x2 = 1
    x1     db 1        ; Primo input
    x2     db 1        ; Secondo input

    ; Pesi interi
    w1     db 1        ; Peso associato a x1
    w2     db 1        ; Peso associato a x2

    ; Bias (es. -1 => attivazione solo se entrambi 1)
    bias   db -1

    output db 0        ; Output finale (0 o 1)
    nl     db 10, 0    ; Newline per la stampa
    msg    db "Output: ", 0

SECTION .bss
    result resb 1      ; Memoria per risultato temporaneo

SECTION .text
    extern  printf
    global  main

main:
    ; Carica input e pesi nei registri
    mov al, [x1]       ; AL = x1
    imul al, [w1]      ; AL = x1 * w1

    mov bl, [x2]       ; BL = x2
    imul bl, [w2]      ; BL = x2 * w2

    add al, bl         ; AL = (x1 * w1) + (x2 * w2)
    add al, [bias]     ; AL += bias

    ; === Funzione di attivazione step ===
    ; Se AL >= 0 → output = 1
    ; Altrimenti → output = 0
    cmp al, 0
    jl negativo        ; Salta se AL < 0

    ; Positivo o zero → output = 1
    mov byte [output], 1
    jmp stampa

negativo:
    ; AL < 0 → output = 0
    mov byte [output], 0

stampa:
    ; Stampa: "Output: X\n"
    push eax                ; Salva EAX
    push dword [output]     ; Valore output
    push msg                ; Testo messaggio
    call printf
    add esp, 8              ; Pulisce lo stack (2 argomenti)
    
    ; Stampa newline
    push nl
    call printf
    add esp, 4

    ; Exit
    pop eax
    ret
