#include <uefi.h>

int main() {
    ST->ConOut->ClearScreen(ST->ConOut);
    printf("Amarin Bootloader v0.0.1\n\n");

    printf("Searching for rootfs...\n");
    while(1);
    return 0;
}
