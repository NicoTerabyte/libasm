#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <fcntl.h>
#include <sys/types.h>

extern size_t ft_strlen(const char *s);
extern char *ft_strcpy(char *dst, char *src);
extern int ft_strcmp(const char *s, const char *s2);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
void test_strlen()
{
	assert(ft_strlen("") == 0);
	assert(ft_strlen("hello") == 5);
	assert(ft_strlen("this is a test") == 14);
	printf("✓ Test passed\n");
}

void test_strcpy()
{
	char buffer[100];

	assert(ft_strcpy(buffer, "") == buffer);
	assert(strcmp(buffer, "") == 0);

	assert(ft_strcpy(buffer, "hello") == buffer);
	assert(strcmp(buffer, "hello") == 0);

	printf("✓ ft_strcpy tests passed\n");
}

void test_strcmp()
{

	assert(ft_strcmp("hello", "hello") == 0);
	assert(ft_strcmp("helloldkaldkl", "hello") == 1);
	assert(ft_strcmp("hello", "helloldkaldkl") == -1);
	assert(ft_strcmp("", "") == 0);

	printf("✓ strcmp tests passed\n");
}


void test_write()
{
	if (ft_write(1, "ciao\n", 5) == -1)
		printf("something went wrong\n");
	assert(ft_write(1, "ciao\n", 5) == 5);
	ft_write(1, "dajeroma\n", 25);

	printf("write test passed\n");
}

int main()
{
	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	printf("all tests passed!\n");
	return 0;
}

//search and ask for possible edge cases
//do strcmp and read the medium article
