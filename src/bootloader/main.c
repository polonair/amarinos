#include <uefi.h>

#define true  ((boolean_t)(1==1))
#define false ((boolean_t)(!true))

#define NULL_PTR 1

typedef uint32_t error_t;
typedef struct {
    boolean_t ok;
} rootfs_t;

void error_msg(error_t err) {
    if (!err) return;
    else {
        switch(err) {
            case 0: return;
            case NULL_PTR: printf("Null pointer given"); break;
            default: 
                printf("Unknown error"); 
                break;
        }
        while(true);
    }
}

error_t search_rootfs(rootfs_t *rootfs) {
    if (!rootfs) return NULL_PTR;
    return 0;
}

int main() {
    rootfs_t rootfs;

    ST->ConOut->ClearScreen(ST->ConOut);
    printf("Amarin Bootloader v0.0.1\n\n");

    printf("Searching for rootfs... ");
        error_msg(search_rootfs(&rootfs));
        printf("done\n");

    while(true);
    return 0;
}
