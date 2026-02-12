# Percettrone in Assembly (x86 - NASM)

Questo progetto implementa un semplice **percettrone binario** in linguaggio assembly NASM (32-bit), come esercizio didattico per comprendere i concetti fondamentali delle reti neurali artificiali a basso livello.

## Funzionalità

- Implementa la logica di un singolo neurone (percettrone).
- Esegue un loop su una tabella di verità di 4 input: (0,0), (0,1), (1,0), (1,1).
- Attualmente configurato per simulare una porta logica **OR**.
- Stampa l'input e l'output calcolato per ogni caso.

## Requisiti

- **NASM** (Netwide Assembler)
- **GCC** (con supporto multilib per compilazione a 32-bit su sistemi a 64-bit: `gcc-multilib` su Linux)
- **Make** (opzionale, per semplificare la compilazione)

## Compilazione ed Esecuzione

È incluso un `Makefile` per facilitare la compilazione.

### Linux

```bash
make linux
./perceptron
```

Se sei su un sistema a 64-bit, assicurati di avere `gcc-multilib` installato:
`sudo apt-get install gcc-multilib`

### Windows (MinGW/Cygwin)

```bash
make win
perceptron.exe
```

## Struttura del Codice

Il file principale è `main.asm`.
- Sezione `.data`: Contiene i pesi (`w1`, `w2`), il bias, e la tabella degli input.
- Sezione `.text`: Contiene il ciclo principale che itera sugli input, calcola la somma pesata e applica la funzione di attivazione (step).
- Output: Utilizza `printf` dalla libreria standard C per mostrare i risultati.

### Verifica Python

È incluso uno script Python `simulate.py` per verificare la logica del percettrone.
Puoi eseguirlo con:
```bash
python3 simulate.py
```

## Logica (Esempio OR)

Con pesi `w1=1`, `w2=1` e `bias=-1`:
- (0,0) -> 0*1 + 0*1 - 1 = -1 (<0) -> Output: 0
- (0,1) -> 0*1 + 1*1 - 1 =  0 (>=0) -> Output: 1
- (1,0) -> 1*1 + 0*1 - 1 =  0 (>=0) -> Output: 1
- (1,1) -> 1*1 + 1*1 - 1 =  1 (>=0) -> Output: 1
