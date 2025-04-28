# libasm
Getting familiar with assembly language
![](goku_kid_buu_meme.gif)

## unknown stuff
* We can say that the assembly language does work with makefiles
* What the hell is Deepthough that is mentioned in the subject of the project?
* How do i write with a 64 bits ASM? (64 is the architecture of the machine) and what is the calling convention?
* What does doing inline ASM mean? and what are .s files?
* The code must be compiled with nasm (correct is the actual compiler of assembly when it doesn't work with C functions)
* What is the Intel syntax and what is the AT&T syntax that i can't use? (intel syntax is the most "modern" utilized since assembly changes  depending on the processors, AT&T was an old way of writing assembly)

Can it be that the 64 bit programming that got mentioned in the subject is related to the fact that with assembly we are working on cpu's and by consequence the cpu works with 64 bits registers?

I can use something called **mov** values or something to manipulate the memory

syscall can be used to make the computer do some operations when called, pratically the kernel it has defined codes to work out.

## Ok torniamo un attimo alla speculazione in italiano va
La cosa difficile è capire come sta manipolazione di registri ci permetta di fare quello che vogliamo.
Come le stampe e la manipolazione delle variabili o qualcosa del genere.
Sappiamo sicuro che lavoriamo con l'architettura 86x64 bits, con l'architettura ARM classica tipo.

Il problema è: come comprendo quando usare **mov**, **lea** ecc, qual'è il processo da seguire per scrivere in assembly? quale logica mi fa utilizzare variabili come rax, rdi, rsi?
come dico a syscall di fare una determinata azione?

Interessante prima di comprendere il linguaggio una piccola guida mi sta intimando a comprendere bene i calcoli tra i numeri binari le sottrazioni e i numeri negativi quando vengno rappresentati.
Alla fine ho dovuto lasciare stare la guida perché utilizzava una vecchia architettura a 32 bits e quindi il codice in assembly era completamente diverso.
Allora parlando con l'intelligenza artificiale ho potuto scoprire lo stile di architettura col quale dobbiamo programmare. IL  quale sarebbe NASM perché viene definito "intel style" e il subject menziona di dover programmare con questo stile quindi deduco che NASM sia appunto sta cosa qua.

Assembly lavora con un comando built-in chiamato ld
la sua sintassi è la seguente:

### rdi, rax, rsi
Starting from a cpu perspective we know that  it is made to perform basic operations for the computer.
So said operation may be, aritmetical, logical, input/output ones.
The problem is where is the data of so said actions stored? In the general purpose registers.
And some of this registers are actually the rdi, rax, and rsi registers that are present to the 64 bits architecture.
* rax -> handles the system call (syscall) number
* rdi -> used to pass the **first argument** to a **function**
* rsi -> used to pass the **second argument** to a **function**
* rdx -> used to pass the **third argument** to a **function**


### small precautions
We are working with nasm now the old way of compiling that we utilized up there could be defined *wrong* in this case because of the subjects assignement on using nasm and i think that is more correct to use it in this case with assembly too. so yeah this way of compiling:
```bash
as asem.s -o asem.o
```
is actually wrong instead now to make the file "hello_world.asm" work we do:
```bash
nasm -f elf64 -o file.o file.asm
```
and this way we create the actual object file for the ld that when used by it, it will create the binary file/executable/input file

```bash
ld -o programName file.o
```

and that's it actually

## Torniamo alla speculazione (passare dati nelle funzioni):
assembly lavora con valori endian. la valutazione in endian determinano l'ordine nel quale il computer i bytes piccolo fact.

Allora cosa interessante nell'architettura 86x64 ci sono dei registri chiamati per essere sempre in quest'ordine i registri che passano dei valori all'interno di una funzione.

rdi - used to pass the first argument to a function.
rsi - used to pass the second argument to a function.
rdx - used to pass the third argument to a function.
r10 - used to pass the fourth argument to a function.
r8 - used to pass the fifth argument to a function.
r9 - used to pass the sixth argument to a function.
**rax** - gestisce il comportamento di syscall

Ma questo si applica solamente con le funzioni chiamate tramite syscall che per quello che dobbiamo fare per questo progetto calza a pennello.

**important fact**
The ELF that we define in a type of file that are compatible with linux.

**What is db?**
DB - byte - 8 bits
DW - word - 2 bytes
DD - doubleword - 4 bytes
DQ - quadword - 8 bytes
DT - 10 bytes
DO - 16 bytes
DY - 32 bytes
DZ - 64 bytes

Cioè è come se dicessimo nel codice dove abbiamo utilizzato db che ogni singola lettera di quella parola equivale ad un byte, questo comporta che prepareremo la parola ad essere grande quanto la sua lunghezza definita grazie a db. Utilizziamo db per definire le nostre variabili


## The stack
Praticamente sarebbe la sezione di memoria che verrebbe interpellata in caso finissimo i _general purpose registers_ uno stack lavora con il sistema LIFO per gestire il flusso di dati che gli vengono inseriti (push) e rimossi (pop).
Il suo funzionamento è in realtà molto basico. in parole povere serve quando non abbiamo i registri predefiniti per gestire i dati e di conseguenza pushiamo in modo "raw" i dati nello stack, ovviamente questo comporta che dovremmo riprenderceli uno ad uno in un ordine un po' bizzarro che corrisponderebbe all'ultimo numero che è stato inserito nello stack fino al primo segue appunto la struttura LIFO (last in first out)

Come ho menzionato implicitamente prima lo stack inserisce dei dati al suo interno con letteralmente le funzioni **push** e li rimuove con **pop**


_importante_
Lo stack cresce verso il basso non verso l'alto a livello figurativo, in più, più roba viene inserita più l'indirizzo è basso? non ho ben capito cosa si intende so solo che si parla del valore dell'address di quel valore inserito nello stack.


## The functions
Allora le funzioni sono anch'esse un po' particolari. Praticamente la cosa principale è che ogni funzione lavora con due/tre _general purpose registers_

sono tre in particolare
**rip** - this register is the so-called instruction pointer. It stores the address of the next instruction the CPU is going to execute. When the CPU meets the call instruction to call a function, it pushes the address of the next instruction to run after the function call to the stack. This is done so the CPU knows where to continue the program's execution after the function call.

**rsp** - this register is called a stack pointer and should point to the top of the stack. After we push something to the stack using the push instruction, the stack pointer address decreases. After we pop something from the stack using the pop instruction, the stack pointer address increases.

**rbp** - this register is the so-called frame pointer or base pointer that points to the stack frame. As mentioned above, each function has its own stack frame, which is a memory area where the function stores local variables and other data.

allora questi tre elementi sono particolari e ci sono **SEMPRE** nelle funzioni create da noi in linguaggio assembly servono a manipolare uno stack che appunto si crea appositamente per le interazioni che avvengono in quella funzione specifica.
però approfondiremo domani champ rileggi il capitolo 2 e comprendi appieno rip, rsp e rbp.

Allora l'idea generale di quei due registri è che rsp ha sempre accesso all'ultima variabile inserita nello stack quindi di per se è un registro dinamico perché è sempre in cambiamento.
E molto importante, vengono utilizzati all'interno delle funzioni perché di fatto il valore di ritorno all'interno delle suddette viene salvato nello stack.
Mi sono perso rip da qualche parte ma penso che tra i tre sia quello meno importante

praticamente è come se fosse una lista e rbp fosse **la testa** di questa lista, questo comporta che avremo sempre accesso alle variabili all'interno dello stack setuppando rbp all'inizio dello stack della funzione con un push
poi come accediamo alle variabili è un po' un'altra storia ancora in teoria servirebbe fare un piccolo calcolo con gli indirizzi per essere capaci di accedere ad ogni variabile all'interno dello stack partendo dalla base **cioè rbp**

<span style="color: red">
porco due mi sono dimenticato che quando lavoriamo coi registri è come se prima di utilizzare call per chiamare una funzione noi stessimo praticamente setuppando gli argomenti che passiamo appunto alla funzione dichiarata da noi, i registri sono gli <b>argomenti cazzzoooooooo</b>
</span>

### Perché pushare rbp nello stack all'inizio di una funzione?
L'operazione iniziale che viene spiegata dove rbp all'inizio quindi il *pushing* di rbp nello stack all'inizio di una funzione che viene chiamata è giustificato, praticamente serve a settare rbp per la funzione corrente essendo un registro "locale" viene usato anche prima in un'altra funzione di conseguenza ci salviamo nello stack il punto in cui rbp è arrivato questo comporta che possiamo poi inzializzarlo per utilizzarlo come base all'interno della nuova funzione fare tutte le operazioni necessarie poi resettare tutto "sputandolo" fuori dallo stack con pop.

<span style="color: blue">
<b>ricorda!</b>
</span>

Essendo che aggiungere valori allo stack li fa andare in indirizzi più bassi per accedere ai registri precedenti l'offset dev'essere negativo sono identificabili come **variabili locali**.
In sintesi: l'idea sarebbe che il rbp faccia quella determinata azione all'inizio di una funzione perché così negli indirizzi più bassi, cioè quelli negativi, esso abbia le variabili locali cioè quelle salvate dal **caller**, d'altro canto se invece delle variabili venissero salvate nello stack esse sarebbero accessibili solamente tramite un **offset positivo** sommato all'indirizzo di rbp

### Gli offset di rbp
Allora se capisco questa cosa ho praticamente masterato le funzioni in assembly.
La domanda è come calcolo l'offset all'interno di rbp per metterci dentro una variabile?


### Considerazioni sulle "funzioni" in assembly
alla fine della giornata le cosidette "funzioni" sono solo delle sezioni, da non confondere con le section stesse, che possiedono una loro "etichetta" (label sarebbe la terminologia adatta), e che vengono chiamate durante l'esecuzione del programma stesso. praticamente quello che succede in assembly è una serie di istruzioni che per conto loro vengono chiamate in un determinato ordine
nel senso: Io devo fare x quindi salto (con jmp) alla sezione x per fare un'operazione che mi serve.
Poi volendo posso tornare indietro (sempre con jmp jne se c'era un check che è andato male) e riparto da dove sono saltato andando verso il basso MA questo non mi impedisce di saltare di nuovo in sezione x oppure se operazione y è avvenuta di uscire grazie ad un altro salto. è un po' strano ma già vedendo la logica del codice "stack_training.asm" capirai

## Debugging sheet
Qui mi segno qualche comando da utilizzare con gdb per capire meglio le operazioni fatte da assembly e non impazzire

Per iniziare dobbiamo compilare quando utilizzamo nasm con la flag -g alla fine perché se no eh so cazzi
quindi

```bash
nasm -f elf64 program.asm -o program.o -g

# di seguito creaimo l'eseguibile con ld

ld -o program program.o

#dopo che abbiamo il programma utilizziamo gdb per una questione personale io l'utilizzo così
gdb -tui -silent program
```
quando saremo in gdb ci sono dei comandi che all'interno di esso possiamo fare, essi sono molto utili secondo me

```bash
#comando che rimuove la parte di codice e la sostituisce con i registri e gli indirizzi di assembly
(gdb) lay asm
#rendo visibile la parte dei registri
(gdb) lay reg
#inizio il debugging
(gdb) start
#esploriamo il codice
(gdb) si
```

possiamo anche manipolare il contenuto dei registri in diretta per cambiare il risultato durante l'esecuzione del programma

```bash
(gdb) set $r10 = 10
```
per diciamo includere quel registro dobbiamo per forza utilizzare il $

```bash
#per vedere i breakpoints disponibili
(gdb) info break
```

**extra**
essendo che gdb lavora con i registri di base con la nomenclatura classica AT&M per cambiarlo ogni volta che viene utilizzato abbiamo fatto un .gdbinit dove abbiamo messo come default startup il comando per vedere con l'architettura intel
```bash
set disassembly-flavor intel
```
Possiamo anche fare dei comandi personalizzati volendo all'interno del .gdbinit file

## Sections
utilized to give instruction to the program, they are mostly used to do different things like for example basic variable declaration or to actually tell to the computer where the program is gonna start.
some basic sections are the following

* data - used for declaring initialized data or constants.
* bss - used for declaring non-initialized variables.
* text - used for the code of the program.
* shstrtab - stores references to the existing sections.

## Arithmetic calculations:
Basic list of arithmetic instructions used in assembly
* ADD - Addition it does the operation on the first two operands that are written after it
* SUB - Subtraction it does the operation on the first two operands that are written after it
* MUL - Unsigned multiplication the result of the operation is stored on the rax and rdx registers
* IMUL - Signed multiplication the result of the operation is stored on the rax and rdx registers
* DIV - Unsigned division the result of the operation is stored on the rax and rdx registers
* IDIV - Signed division the result of the operation is stored on the rax and rdx registers
* INC - Increment by one the defined value
* DEC - Decrement by one the defined value
* NEG - Negation

Very simple and chill to use it seems. I'll try to have one file for this kind of exercise though


## control flow
To put it simply is to handle the if elses statement like in the C language.

First of all we use the *cmp* directive to compare the registers with the given value.
BUT! It can't work by itself because it does the check but it doens't say what to do after, for the result of the control flow statement we need to use other directives.
Example of cmp usage
```c
;; Compare the value of the rax register with 50
cmp rax, 50
```


For handling the "results" we have the **conditional jumps instructions:**
* JE/JZ - Jump if the values are equal.
* JNE/JNZ - Jump if the values are not equal.
* JG - Jump if the first value is greater than the second.
* JGE - Jump if the first value is greater or equal to the second.
* JA - The same as JG, but performs the unsigned comparison.
* JAE - The same as JGE, but performs the unsigned comparison.
* JL - jump if the value is smaller than the second
* jo used in case a register goes in overflow
In fact we have this C code
```c
if (rax != 50) {
    foo();
} else {
    bar();
}
```
that becomes
```assembly
;; Compare rax with 50
cmp rax, 50
;; Jump to the label `.foo` if the value of the `rax` register is not equal to 50
jne .foo
;; Jump to the label `.bar` otherwise
jmp .bar
```

## Other stuff concerning the stack in assembly
Allora, abbiamo scoperto più o meno in generale come funziona lo stack.
Sappiamo che per esempio con **push** inseriamo dati al suo interno con degli indirizzi bassi e con **pop** sputiamo fuori l'ultimo valore che è stato inserito (LIFO).

Teniamo anche conto di **call** e **ret** però, dove call chiama la procedura richiesta salvando come indirizzo di ritorno dekke istruzioni nello stack. **ret** invece, esce dalla procedura data, modifica lo stack rimuovendo l'indirizzo di ritorno e trasferendo nuovamente il "flow" di esecuzione prima di **call**

### more about control flow (jmp and call)
Un'altra cosa che ho avuto modo di scoprire adesso è che la grande differenza di usare l'istruzione **call** al posto di **jmp** è che in parole povere call lo si utilizza per andare da una parte del codice sapendo che quella parte lì possiede l'indirizzo del chiamante nello stack, di conseguenza quando useremo ret alla fine della funzione o "etichetta" se dobbiamo essere precisi, ritorneremo al punto dove la funzione è stata chiamata. invece con jmp non teniamo conto di chi ha chiamato la funzione perché logicamente si vede che vogliamo andare ad un punto precisodel codice e andare avanti da lì senza tornare indietro.

## Logical instructions
Used to perform logical operations.
AND - entrambi le casistiche devono essere vere per rendere vero questa istruzione
OR - basta che una delle due casistiche sia vere per essere anch'esso verò
XOR - funziona solo se uno delle due casistiche è vero se no da sempre falso
NOR - entrambe le casistche devono essere false per fare in modo che questa istruzione sia vera
## cld and the flags reset

Ok ho capito in parole povere ma neanche troppo, **cld** definisce come le stringhe vengono processate quando vengono fatte delle operazioni su di esse cambiando il valore del **df** (direction flag). Esempio stupido, se devo passare una stringa scritta come 'ABC' a un'altro registro con df = 0 la passo praticamente come l'ho scritta se invece df = 1 la passo al contrario e cioè 'CBA', movsb

### Parte 4 recall:



## Studies todo

- [x] what is the definition of linker?
  A linker or link editor is a computer program that combines intermediate software build files such as object and library files into a single executable file such a program or library.
  Pratically we are using ld to make the object created by nasm into an executable it links together the object file to a program
- [x] understanding the mechanics of the functions made by yourself in the assembly language
- [ ] fare un printer in assembly is it possible??? (extra)
- [x] creating ft_strlen, it's pratically a test to see if you finally have a grasp of the function creation thing
- [ ] Scoprire se è possibile collegare più files tra di loro in assembly e all'occorrenza snellire i file senza avere tutte le funzioni in un unico posto
- [ ] Or start reading objdump's, che cos'è? E come può aiutarmi per raggiungere traguardi di grandezza assurdi?


# Avaible "built in" registers
![alt text](image.png)

# extra
Max int for 64bit registers: 9,223,372,036,854,775,807
After that it overflows, overflow meaning is that the value from a positive integer it becomes a negative one and viceversa this is a good criteria to check overflows


# Little planning on what to do next:
* finish the asm guide on github
* then seeing if the knowledge that i got i'm able to do libasm (if not this task goes under the next one)
* studying nasm
* understanding how to use multiple files for an assembly project
