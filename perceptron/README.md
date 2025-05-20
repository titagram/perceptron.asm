# 🧠 Percettrone in Assembly (x86 - NASM)

Questo progetto implementa un semplice **percettrone binario** in linguaggio assembly NASM (32-bit), come esercizio didattico per comprendere i concetti fondamentali delle reti neurali artificiali a basso livello.

---

## 🚀 Funzionamento

Il percettrone prende in input due valori binari (`x1` e `x2`) e calcola: output = step(x1 * w1 + x2 * w2 + bias)

Dove `w1` e `w2` sono i pesi, e `bias` è un valore costante che influenza l'attivazione.

La **funzione di attivazione** è una semplice funzione "step":
- Se la somma è **maggiore o uguale a 0**, il `output` è 1
- Altrimenti, il `output` è 0

---

## 🔧 Registri x86 principali

| Registro | Descrizione                          |
|----------|--------------------------------------|
| `EAX`    | Accumulatore principale              |
| `EBX`    | Registro base                        |
| `ECX`    | Contatore per loop                   |
| `EDX`    | Estensione aritmetica (es. divisioni)|
| `ESP`    | Stack Pointer                        |
| `EBP`    | Base Pointer                         |

Sono registri a 32 bit.
AX è la parte bassa (16 bit) di EAX.
AL e AH sono le due metà di AX: byte basso (Least Significant Byte), e byte alto  (Most Significant Byte).

### Esempio
EAX:  31 ----------- 16 ----------- 8 ----------- 0
      [  ---- AH ----  ]           [ ---- AL ---- ]  → 32 bit totali


---

## ⚙️ Istruzioni Assembly Utilizzate

### 📥 Spostamento dati
mov eax, 5        ; Carica 5 in EAX
mov al, [x1]      ; Carica il valore da memoria

### ➕ Aritmetica
add eax, ebx      ; Somma
sub eax, 1        ; Sottrazione
imul eax, ebx     ; Moltiplicazione con segno

### 🔁 Confronti e salti condizionati
cmp eax, 0        ; Confronto
jl negativo       ; Salta se minore (jump if less)
je uguale         ; Salta se uguale
jmp fine          ; Salto incondizionato

### 📦 Stack
push eax          ; Inserisce eax nello stack
pop eax           ; Recupera da stack

### 🖨️ I/O tramite C standard library
extern printf
push eax
push msg
call printf
add esp, 8        ; Pulisce lo stack

## 🗂️ Struttura del Programma NASM
.data: Dati inizializzati (input, pesi, bias, messaggi)
.bss: Dati non inizializzati (buffer temporanei)
.text: Codice eseguibile

## 💻 Compilazione
nasm -f win32 percettrone.asm -o percettrone.obj
gcc -m32 -o percettrone percettrone.obj
