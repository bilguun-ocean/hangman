#include <stdio.h>
main()
{
  int old_number, current_number, next_number;
  old_number = 1;
  current_number = 1;
  printf("1\n");
  while (current_number < 100) {
    printf("%i\n", current_number);
    next_number = old_number + current_number;

    old_number = current_number;
    current_number = next_number;
  }
}