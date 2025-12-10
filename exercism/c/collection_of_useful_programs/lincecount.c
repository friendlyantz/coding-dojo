#include <stdio.h>

int main()
{
  int character, nl;

  nl = 0;
  while ((character = getchar()) != EOF)
    if (character == '\n') // body of a while
      ++nl;
  printf("%d\n", nl);

  return 0;
}
