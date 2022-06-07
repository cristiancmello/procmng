#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <wait.h>

void type_prompt(void);

int read_prompt(char* prompt);
char* read_command(char* cmdname, char* params[]);

int main(int argc, char const *argv[])
{
  printf("Welcome to my Mini Shell :D [CTRL+D to exit]\n\n");

  while (1)
  {
    char prompt[50] = "";

    type_prompt();
    int s = read_prompt(prompt);
    
    if (s == -1) {
      printf("Bye bye :(\n");
      exit(EXIT_SUCCESS);
    }

    char* cmdread = read_command(prompt, 0);
    if (cmdread == NULL) {
      fprintf(stderr, "Command not found");
      printf("\n");
      continue;
    }

    pid_t pid = fork();

    if (pid != 0) {
      // parent code
      int status;
      waitpid(-1, &status, 0);

      printf("Process exited with status %d", status);
    } else {
      // swap child process stack
      char* params[] = { NULL };
      char* envp[] = { NULL };

      char cmdname[50] = "";

      strcat(cmdname, cmdread);
      strcat(cmdname, ".sh");

      execve(cmdname, params, envp);
      perror("execve");
      exit(EXIT_FAILURE);
    }

    printf("\n");
  }

  return 0;
}

void type_prompt(void) {
  printf("> ");
}

int read_prompt(char* prompt) {
  int s = fscanf(stdin, "%s", prompt);
  return s;
}

char* read_command(char* cmdname, char* params[]) {
  if (!strcmp(cmdname, "date")) {
    return "date";
  } else if (!strcmp(cmdname, "pstree")) {
    return "pstree";
  } else {
    return NULL;
  }
}