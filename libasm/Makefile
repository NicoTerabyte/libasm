NAME = libasm.a
ASM = nasm
ASMFLAGS = -f elf64
AR = ar rcs
CC = gcc
CFLAGS = -Wall -Wextra -Werror

SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s
OBJ = $(SRC:.s=.o)

TEST_SRC = test.c
TEST_BIN = test_program

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(NAME) $(OBJ)

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

test: $(NAME)
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o $(TEST_BIN)
	./$(TEST_BIN)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) $(TEST_BIN)

re: fclean all

.PHONY: all test clean fclean re
