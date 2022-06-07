#include <stdio.h>
#include <stdlib.h>

extern char **environ; // escopo global

int main(int argc, char *argv[], char* envp[]) // envp: escopo local
{
  char** ep;

  for (ep = environ; *ep != NULL; ep++)
    puts(*ep);

  for (ep = envp; *ep != NULL; ep++)
    puts(*ep);

  printf("HOME folder : %s\n", getenv("HOME"));

  exit(EXIT_SUCCESS);
}
