#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char const *argv[])
{
  // getpid: sempre retorna com sucesso o ID do processo caller
  pid_t caller_pid = getpid(); // (A) pid_t é um int
  printf("Caller PID: %d\n", caller_pid);

  // PID_MAX: obter a maior valor permitido pelo kernel, execute "cat /proc/sys/kernel/pid_max"
  // Exemplo: 32767 upper total 32768. Em sistemas 64 bits esse valor pode ser ainda maior

  pid_t parent_caller_id = getppid();
  printf("Parent Caller PID: %d\n", parent_caller_id);

  // CHILD ÓRFÃO: se o process child perder seu "parent", ou seja, ficar órfão, parent PID = 1 (mesmo do processo init que o adota)

  // pstree : descobrir a hierarquia dos processos. Perceba que pai de todos é sempre "init"
  // Exemplo: init─┬─init───init─┬─zsh─┬─bash───pstree (parent de pstree é bash, seu avô é zsh e etc)

  // fork: syscall para criar processo child
  pid_t pid = fork();
  // Todo código abaixo está TANTO no contexto do child process quanto no seu parent. Logo haverá duplicação.
  printf("Estou no child e parent!\n");
  printf("PID: %d\n", pid); // child recebe PID 0 do fork

  // OBSERVE MENSAGENS DUPLICADAS ABAIXO. EXEMPLOS:
  // PID: 0 -> o child recebe do fork PID 0
  // PID: 2344 (!= 0) -> o parent recebe o PID do child

  pid_t child_pid = -1;
  if (pid != 0) child_pid = pid; // (B) Capturar o child PID para informar ao seu parent

  // Como desviar o código de maneira que child e parent executem códigos diferentes?
  if (pid != 0) {
    // Contexto exclusivo ao parent
    pid_t current_pid = getpid();

    printf("PARENT CONTEXT\n");
    printf("Parent of Child PID: %d\n", current_pid);

    // Atestar que current pid é igual ao caller_pid capturado em (A)
    if (current_pid == caller_pid) printf("current_pid é igual ao caller_pid\n");

    // Parent pode informar o child pid capturado em (B)
    printf("My child PID is %d\n", child_pid);


    // syscall waitpid: esperar pelo término do process child
    // parametros
    // pid: pid do processo; -1 para esperar por qualquer child process
    // *status: ponteiro do status. Quando processo terminar, status recebe status da execução do child process
    // options: suporta WNOHANG, WUNTRACED e WCONTINUED e combinações. 
    //          É possivel ate retornar imediatamente se mesmo assim tiver child executando
    int status = -1;
    waitpid(-1, &status, WUNTRACED | WCONTINUED);
    
    printf("Child Process terminou com status %d\n", status);
    printf("\n\n");
  } else {
    // Contexto exclusivo ao child
    pid_t current_pid = getpid();

    printf("CHILD CONTEXT\n");
    printf("Child PID: %d", current_pid);

    char command[] = "ls";
    char* params_argv[] = { NULL, "hello", "world", NULL };
    char* environp[] = { "MESSAGE=hello" };

    // syscall execve: executa um programa. Troca a imagem do kernel do processo.
    // A stack do processo é substituída pelo programa chamado.
    // Entradas:
    // filename: nome do arquivo com programa a ser chamado
    // argv: lista de valores de argumentos a serem passados ao programa
    // envp: lista de valores de ambiente (variáveis de ambiente, PATH) passado ao programa
    // Saídas:
    //   FALHA:   A função execve retorna caso ocorra falha
    //   SUCESSO: A função execve não retorna caso ocorra tudo bem
    execve("myscript.sh", params_argv, environp);
    perror("execve"); // print do erro da syscall caso ocorra

    printf("\n\n");
    exit(EXIT_FAILURE); // informa ao status que child saiu com falha
  }



  return 0;
}
