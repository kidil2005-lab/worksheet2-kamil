Worksheet 2 – Bootloader & Simple Kernel

This worksheet focuses on creating a very small 32-bit kernel and getting it to boot using GRUB.
The aim was to understand the early stages of the boot process and how assembly connects to C inside a minimal operating system environment.
The project ended up being split into a few main tasks, which build on each other.

Task 1 – Bootloader

For Task 1, I wrote a simple GRUB-compatible bootloader in assembly (loader.asm).
The bootloader runs in 32-bit protected mode and sets the required magic value 0xCAFEBABE into the EAX register.
After that, it calls the C function kernel_main(), which becomes the entry point for the rest of the kernel.

A custom linker script (link.ld) was also required so that GRUB knows where to load the kernel image and how to place the different sections in memory.
This ensures that the assembly and C code link together correctly.

Task 2 – Kernel Behaviour (C Code)

The kernel is intentionally minimal.
Inside kernel_main(), the code first checks whether the correct magic value was passed in from the bootloader.

Two small C functions (add_two and sum_two) were created to demonstrate calling functions from inside the kernel.
Their results are stored in variables, mainly to show that the kernel is running logic successfully, even though it cannot print text yet.

After these operations, the kernel stays in an infinite loop because there is no further functionality at this stage.

Task 3 – Building & Packaging the Kernel

Task 3 involved using a Makefile to bring everything together:

Compile all C files

Assemble the bootloader

Link everything into a single kernel.elf

Build a bootable ISO using GRUB tools

The GRUB configuration file is located here:

iso/boot/grub/grub.cfg


This file tells GRUB how to boot kernel.elf and sets up a simple menu entry.

Repository Structure
worksheet2/
│
├── boot/
│   └── loader.asm
│
├── src/
│   ├── kernel.c
│   ├── add.c
│   └── sum.c
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
Sometimes the server wouldn’t accept my SSH key or seemed unavailable.
Because of that, most of the coding and setup was done locally first, and I planned to run the final build (make and make run) on csctcloud once the connection issues were resolved.

This didn’t affect the actual code or structure, but it caused a slight delay in testing.

Summary

Overall, this worksheet helped me understand:

How a bootloader hands control to a kernel

How assembly and C interact in a low-level environment

How to use a custom linker script and Makefile to build a kernel

How GRUB loads and executes a simple operating system

Even though the kernel is small, it demonstrates the fundamental ideas behind operating system bootstrapping.
