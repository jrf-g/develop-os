#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <string.h>

int main() {
    int fd = 3;  // systemd passes the socket as FD 3

    char buf[1024];
    ssize_t n;

    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        write(fd, buf, n);   // echo back
    }

    return 0;
}
