// kernel.c – minimal kernel for Worksheet 2 (Task 1)

extern int add_two(int x, int y);
extern int sum_two(int x, int y);

#include "input_buffer.h"

void kernel_main(unsigned int magic)
{
    // Requirement: check loader.asm passed 0xCAFEBABE
    if (magic == 0xCAFEBABE)
    {
        // Simple arithmetic tests
        int a = 5;
        int b = 7;

        int result1 = add_two(a, b);
        int result2 = sum_two(a, b);

        // At this stage we cannot print yet.
        // For debugging, we store results in unused variables.
        volatile int r1 = result1;
        volatile int r2 = result2;
        // --- Task 2: Test input buffer API ---
        input_buffer_init();

        // Simulate characters as if typed by keyboard
        input_buffer_put('h');
        input_buffer_put('i');
        input_buffer_put('\n');

        // Read them back using readline()
        char line[32];
        int len = readline(line, sizeof(line));

        // Stop compiler optimising them away
        volatile int debug_len = len;
        (void)debug_len;

        // Kernel does nothing else yet.
        while (1) {}
    }
    else
    {
        while (1) {} // failed magic number
    }
}
