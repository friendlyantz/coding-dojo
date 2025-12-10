#include <stdio.h>

#define MAXLINE 1000

char line[MAXLINE];
char save[MAXLINE];
int max;

int get_line(void);
void copy(void);

int main()
{
  int len;

  extern int max;
  extern char save[];
  max = 0;

  while ((len = get_line()) > 0)
    if (len > max)
    {
      max = len;
      copy();
    }
  if (max > 0)
    printf("%s\n", save);
  return 0;
}

int get_line(void)
{
  int c, i;

  for (i = 0; i < MAXLINE - 1 && (c = getchar()) != EOF && c != '\n'; ++i)
    line[i] = c;
  if (c == '\n')
  {
    line[i] = c;
    ++i;
  }
  line[i] = '\0';
  return (i);
}

void copy(void)
{
  int i;

  extern char line[], save[];
  i = 0;
  while ((save[i] = line[i]) != '\0')
    ++i;
}
