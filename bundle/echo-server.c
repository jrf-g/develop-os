#include <stdio.h>
#include <termios.h>
#include <unistd.h>

char getch() {
    char c;
    struct termios old, new;

    tcgetattr(STDIN_FILENO, &old);
    new = old;
    new.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &new);

    read(STDIN_FILENO, &c, 1);

    tcsetattr(STDIN_FILENO, TCSANOW, &old);
    return c;
}

int main() {
    char c = getch();
    printf("%c", c);
}
