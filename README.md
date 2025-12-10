Worksheet 2 – Bootloader & Simple Kernel

This worksheet focuses on creating a very small 32-bit kernel and getting it to boot using GRUB.
The aim was to understand the early stages of the boot process and how assembly connects to C inside a minimal operating system environment.
The work is split into several tasks that build on each other.

Task 1 – Bootloader

For Task 1, I wrote a simple GRUB-compatible bootloader in assembly (loader.asm).
The bootloader runs in 32-bit protected mode and sets the required magic value 0xCAFEBABE into EAX.
It then calls the kernel entry point, kernel_main().

A custom linker script (link.ld) arranges the memory layout so that GRUB can correctly load the kernel image.
This ensures that the assembly and C code link together correctly.

Task 2 – Kernel Behaviour (Part 1)

The initial kernel is intentionally minimal.
Inside kernel_main(), the code:

Checks whether the correct magic value was passed from the bootloader

Calls two simple C functions (add_two and sum_two)

Stores the results for debugging (the kernel cannot print yet)

After these operations, the kernel enters an infinite loop, as no further functionality is implemented at this stage.

Task 3 – Input Buffer & Readline (Part 2)

This task expands the kernel by adding a basic input system implemented in C.

I created two new files:

input_buffer.h

input_buffer.c

This implemented a circular buffer to store characters as if they were typed from a keyboard.

The main features added:

✔ input_buffer_init()

Resets the buffer state.

✔ input_buffer_put()

Simulates receiving characters (normally from a keyboard interrupt).
In my kernel, I manually inserted 'h', 'i', and '\n'.

✔ getc()

Returns one character from the buffer or -1 if empty.

✔ readline()

Reads characters until a newline or a maximum length is reached.
The result is stored into a user-provided buffer.

Inside kernel_main(), I tested this API by:

Initialising the buffer

“Typing” characters using input_buffer_put()

Reading them back with readline()

Using a dummy variable to prevent compiler optimisation

This confirms that the kernel can process input, even though it still cannot print the results.

Task 4 – Building & Packaging the Kernel

A Makefile was used to bring everything together:

Compile all C files

Assemble the bootloader

Link everything into a single kernel.elf

Build a bootable ISO using GRUB tools

The GRUB configuration file is located at:

iso/boot/grub/grub.cfg


This tells GRUB how to boot the kernel and sets up a simple menu entry.

Repository Structure
worksheet2/
│
├── boot/
│   └── loader.asm
│
├── src/
│   ├── kernel.c
│   ├── add.c
│   ├── sum.c
│   ├── input_buffer.h
│   └── input_buffer.c
│
├── iso/
│   └── boot/
│       └── grub/
│           └── grub.cfg
│
├── link.ld
└── Makefile

Notes About Development

During this worksheet I had a few issues connecting to csctcloud.
Sometimes the server would not accept my SSH key or appeared unavailable.
Because of this, most development and setup was done locally first, and I planned to run the final build (make and make run) on csctcloud once server access was restored.

This didn’t affect the actual code, but it slightly delayed testing.

Summary

This worksheet helped me understand:

How a bootloader hands control to a kernel

How assembly and C interact in a low-level environment

How to implement a circular input buffer inside a kernel

How to use a custom linker script and Makefile to build a kernel

How GRUB loads and executes a simple operating system

Even though the kernel is small, it demonstrates the fundamental ideas behind operating system bootstrapping and basic input handling.