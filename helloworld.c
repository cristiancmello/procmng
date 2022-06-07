#include <stdio.h>

char globBuf[1200];

int main(int argc, char const *argv[])
{
  static int array[] = {1, 2, 4};
  int *p = array;

  printf("Hello World!\n");

  return 0;
}
