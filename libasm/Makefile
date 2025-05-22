NAME = libasm.a
ASM = nasm
ASMFLAGS = -f elf64
AR = ar rcs
CC = gcc
CFLAGS = -Wall -Wextra -Werror

SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJ = $(SRC:.s=.o)

TEST_SRC = test.c
TEST_BIN = test_program

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(NAME) $(OBJ) # ar rcs libasm.a file1.o file2.o ...

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@  # nasm -f elf64 file.s -o file.o

#the -L flag is for link the assemlby library to the c code
#so it can use the function in the static library
#the -lasm flag is to say to the linker to search for the
#libasm.a library and to use that, i think it's a way to say to use
#an assembly library
test: $(NAME)
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o $(TEST_BIN)
	./$(TEST_BIN)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) $(TEST_BIN)

re: fclean all

.PHONY: all test clean fclean re
