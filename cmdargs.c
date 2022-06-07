#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>
#include <sys/time.h>
#include <sys/resource.h>

extern char* program_invocation_name;
extern char* program_invocation_short_name;

int main(int argc, char *argv[])
{
  // argc: quantos argumentos existem
  // argv: array de ponteiros dos argumentos
  char* null_terminated = argv[argc] == NULL? "sim" : "nao";
  char* program_invoke_name = argv[0];
  printf("argv termina em NULL? %s\n", null_terminated);
  printf("nome do programa invocado: %s\n", program_invoke_name);

  // Echoing args
  int j;
  for (j = 0; j < argc; j++)
    printf("argv[%d] = %s\n", j, argv[j]);

  // Alternativa com aritmética de ponteiro
  char **p;
  for (p = argv; *p != NULL; p++)
    puts(*p);


  printf("PID: %d\n", getpid());

  char *path_name = program_invocation_name;
  char *base_name = program_invocation_short_name;

  printf("program invocation name (path_name): %s\n", path_name);
  printf("program invocation short name (base_name): %s\n", base_name);

  long arg_max = sysconf(_SC_ARG_MAX);
  printf("Quantidade maxima de argumentos suportada: %ld\n", arg_max);
  printf("SUSv3 requer que ARG_MAX seja no minimo: %d\n", _POSIX_ARG_MAX);

  // argv e environ são armazenados no segmento "argv e environ" do processo
  // Logo, podemos obter informações usando a funcao getrlimit()
  struct rlimit rlim;
  getrlimit(RLIMIT_STACK, &rlim);

  printf("Soft Limit do Process Stack: %ld bytes (%d MB)\n", rlim.rlim_cur, rlim.rlim_cur / 1024); // limite "suave" que o próprio processo pode alterar mas nunca ultrapassar
  printf("Hard Limit do Process Stack: %d bytes \n", rlim.rlim_max); // limite "duro" que o processo pode alterar seu valor "soft" (somente superuser alterar este limite)
  // Logo, rlim_cur <= rlim_max e somente superuser pode alterar rlim_max

  // Qual limite para argv e environ? É 1/4 (25%) de rlim.rlim_cur
  // A syscall execve() define argv e environ como parametro
  printf("Limite para argv e environ: %ld bytes (%d MB)\n", rlim.rlim_cur / 4, (rlim.rlim_cur / 4) / 1024);


  printf("\n\n");
  exit(EXIT_SUCCESS);
}
