#include <stdio.h>
#include <stdlib.h>
#define _BACKTRACE_SIZE 12

extern void testfinal(unsigned int[], int);

void print_stack_trace(int frame_count) {
    printf("Stack trace:\n");
    unsigned int stack_addrs[_BACKTRACE_SIZE] = {0};
    testfinal(stack_addrs, frame_count);
    for (int i = 0; i < frame_count; i++) {
        int frame_addr = stack_addrs[i];
        if (!frame_addr) {
            break;
        }

        printf("[%d] (0x%08x) [%d]\n", i, frame_addr, frame_addr);
    }
}

void main() {
    print_stack_trace(12);
}
