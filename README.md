# libasm
Getting familiar with assembly language

## unknown stuff
* We can say that the assembly language does work with makefiles
* What the hell is Deepthough that is mentioned in the subject of the project?
* How do i write with a 64 bits ASM? and what is the calling convention?
* What does doing inline ASM mean? and what are .s files?
* The code must be compiled with nasm
* What is the Intel syntax and what is the AT&T syntax that i can't use?

Can it be that the 64 bit programming that got mentioned in the subject is related to the fact that with assembly we are working on cpu's and by consequence the cpu works with 64 bits registers?

I can use something called **mov** values or something to manipulate the memory

syscall can be used to make the computer do some operations when called, prastically the kernel it has defined codes to work out.

What's mov used for? For registers I suppose
What are specifically rax, rdi and rdx?
are we with lea "variable"? manipulating the output strings?


## Command used for compiling:
this command is for assembling our program
```bash
as asem.s -o asem.o
```

this command is compiling with gcc the object file
```bash
gcc -o asem asem.o -nostdlib -static
```


## Ok torniamo un attimo alla speculazione in italiano va
La cosa difficile è capire come sta manipolazione di registri ci permetta di fare quello che vogliamo.
Come le stampe e la manipolazione delle variabili o qualcosa del genere.
Sappiamo sicuro che lavoriamo con l'architettura 86x64 bits, con l'architettura ARM classica tipo.

Il problema è: come comprendo quando usare **mov**, **lea** ecc, qual'è il processo da seguire per scrivere in assembly? quale logica mi fa utilizzare variabili come rax, rdi, rsi?
come dico a syscall di fare una determinata azione?

Interessante prima di comprendere il linguaggio una piccola guida mi sta intimando a comprendere bene i calcoli tra i numeri binari le sottrazioni e i numeri negativi quando vengno rappresentati.
Alla fine ho dovuto lasciare stare la guida perché utilizzava una vecchia architettura a 32 bits e quindi il codice in assembly era completamente diverso.
Allora parlando con l'intelligenza artificiale ho potuto scoprire lo stile di architettura col quale dobbiamo programmare. IL  quale sarebbe NASM perché viene definito "intel style" e il subject menziona di dover programmare con questo sitle quindi deduco che NASM sia appunta sta cosa qua.

Asselby lavora con un comando built-in chiamato ld
la sua sintassi è la seguente:

```bash
ld -o output /lib/crt0.o hello.o -lc
```
esso lavora mettendo insieme in questo esempio almeno i due file oggetto /lib/crt0.o hello.o
La cosa è capire come lavora con questi file oggetto e come ld si relaziona con assembly. Però penso che inerente al suo comportamento basta che sappiamo che si relazioni con i file oggetto.

il ld, è praticamente il nostro compilatore, una sorta di punto di inizio che compila per primo il programma
In termini tecnici è un entry point e da dove deve iniziare a eseguire il codice o per meglio dire è da dove deve leggerlo, e per definirlo correttamente si utilizza la terminologia **_start** con il suffisso **global** per dire a ld che è quello l'entry point

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

## Torniamo alla speculazione:
assembly lavora con valori endian. la valutazione in endian determinano l'ordine nel quale il computer i bytes piccolo fact.

Allora cosa interessante nell'architettura 86x64 ci sono dei registri chiamati per essere sempre in quest'ordine i registri che passano dei valori all'interno di una funzione.
rdi - used to pass the first argument to a function.
rsi - used to pass the second argument to a function.
rdx - used to pass the third argument to a function.
r10 - used to pass the fourth argument to a function.
r8 - used to pass the fifth argument to a function.
r9 - used to pass the sixth argument to a function.

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

Cioè è come se dicessimo nel codice dove abbiamo utilizzato db che la ogni singola lettera di quella parola equivale ad un byte, questo comporta che prepareremo la parola ad essere grande quanto la sua lunghezza definita grazie a db. Utilizziamo db per definire le nostre variabili


## The stack
Praticamente sarebbe la sezione di memoria che verrebbe interpellata in caso finissimo i _general purpose registers_ uno stack lavora con il sistema LIFO per gestire il flusso di dati che gli vengono inseriti (push) e rimossi (pop).
Il suo funzionamento è in realtà molto basico. in parole povere serve quando non abbiamo i registri predefiniti per gestire i dati e di conseguenza pushiamo in modo "raw" i dati nello stack, ovviamente questo comporta che dovremmo riprenderceli uno ad uno in un ordino un po' bizzarro che corrisponderebbe all'ultimo numero che è stato inserito nello stack fino al primo

## The functions
Allora le funzioni sono anch'esse un po' particolari. Praticamente la cosa principale è che ogni funzione lavora con due _general purpose registers_

sono tre in particolare
rip - this register is the so-called instruction pointer. It stores the address of the next instruction the CPU is going to execute. When the CPU meets the call instruction to call a function, it pushes the address of the next instruction to run after the function call to the stack. This is done so the CPU knows where to continue the program's execution after the function call.

rsp - this register is called a stack pointer and should point to the top of the stack. After we push something to the stack using the push instruction, the stack pointer address decreases. After we pop something from the stack using the pop instruction, the stack pointer address increases.

rbp - this register is the so-called frame pointer or base pointer that points to the stack frame. As mentioned above, each function has its own stack frame, which is a memory area where the function stores local variables and other data.

allora questi tre elementi sono particolari e ci sono **SEMPRE** nelle funzioni create da noi in linguaggio assembly servono a manipolare uno stack che appunto si crea appositamente per le interazioni che avvengono in quella funzione specifica.
però approfondiremo domani champ rileggi il capitolo 2 e comprendi appieno rip, rsp e rbp

## Studies todo

- [x] what is the definition of linker?
  A linker or link editor is a computer program that combines intermediate software build files such as object and library files into a single executable file such a program or library.
  Pratically we are using ld to make the object created by nasm into an executable it links together the object file to a program
- [ ]
