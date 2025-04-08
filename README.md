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

## Studies todo

- [ ] what is the definition of linker?
