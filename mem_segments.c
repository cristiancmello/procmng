#include <stdio.h>
#include <stdlib.h>

extern char etext, edata, end;

char globBuf[65536];            /* ZERO-INITIALIZED DATA SEGMENT (bss) */
int primes[] = { 2, 3, 5, 7 };  /* INITIALIZED DATA SEGMENT */

static int square(int x)        /* PARAM ALOCADO NA STACK FRAME para square() */
{
  int result;                   /* ALOCADO NA STACK FRAME PARA square() */

  result = x * x;
  return result;                /* VALOR DE RETORNO PASSADO VIA register */
}

static void doCalc(int val)     /* PARAM ALOCADO NA STACK FRAME PARA doCalc() */
{
  printf("The square of %d is %d\n", val, square(val));

  if (val < 1000) {
    int t;                      /* ALOCADO NA STACK FRAME PARA doCalc() */

    t = val * val * val;
    printf("The cube of %d is %d\n", val, t);
  }
}

int main(int argc, char** argv) /* PARAMETROS ALOCADOS NA STACK FRAME PARA main() */ 
{
  static int key = 9973;        /* USER-INITIALIZED DATA SEGMENT */
  static char mbuf[102304000];  /* ZERO-INITIALIZED DATA SEGMENT (bss) */
  char* p;                      /* ALOCADO NA STACK FRAME PARA main() */

  p = malloc(1024);             /* ALOCADO NO SEGMENTO HEAP */

  doCalc(key);

  printf("ADDRESS OF THE END OF PROGRAM TEXT SEGMENT: %p\n", &etext);
  printf("ADDRESS OF THE END OF USER-INITIALIZED DATA SEGMENT: %p\n", &edata);
  printf("ADDRESS OF THE END OF ZERO-INITIALIZED DATA SEGMENT (bss): %p\n", &end);

  printf("\n\n");

  sleep(100000);

  exit(EXIT_SUCCESS);
}