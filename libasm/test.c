#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <stdlib.h>

extern size_t ft_strlen(const char *s);
extern char *ft_strcpy(char *dst, char *src);
extern int ft_strcmp(const char *s, const char *s2);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
extern ssize_t ft_read(int fd, const void *buf, ssize_t count);
extern char* ft_strdup(const char *str);

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
	assert(ft_strcmp("helloldkaldkl", "hello") >= 1);
	assert(ft_strcmp("hello", "helloldkaldkl") <= -1);
	assert(ft_strcmp("", "") == 0);

	printf("✓ strcmp tests passed\n");
}


void test_write()
{
	if (ft_write(1, "ciao\n", 5) == -1)
		printf("something went wrong\n");
	assert(ft_write(1, "ciao\n", 5) == 5);
	ft_write(1, "dajeroma\n", 9);

	printf("✓ write test passed\n");
}

void test_read()
{
	int fd = open("testFile.txt", O_RDONLY);
	char	buffer[1000];
	size_t	bytes_read;
	if (fd < 0)
	{
		printf("sei goofy e scemo, error on opening the file\n");
		return ;
	}

	while ((bytes_read = ft_read(fd, buffer, 10)) > 0)
	{
		buffer[bytes_read] = '\0';
		printf("read string %s\n", buffer);
	}

	close(fd);
	if (fd < 0)
	{
		printf("stiamo alla frutta\n");
		return ;
	}
}

void test_strdup()
{
	char	*strToDup = "ciao bello";
	char	*dupStr;

	dupStr = ft_strdup(strToDup);
	if (!dupStr)
	{
		printf("the test didn't went well\n");
		free(dupStr);
		return ;
	}
	printf("duplicated string: %s\n", dupStr);
	free(dupStr);
}

int main()
{
	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	test_strdup();
	printf("all tests passed!\n");
	return 0;
}

//search and ask for possible edge cases
//do strcmp and read the medium article
