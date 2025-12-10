# --------------------------------------------------
# Makefile for Worksheet 2 - Part 1 (Pass-level)
# --------------------------------------------------

CC = gcc
LD = ld
NASM = nasm

CFLAGS = -m32 -ffreestanding -fno-pic -fno-stack-protector -nostdlib -fno-builtin
LDFLAGS = -m elf_i386

SRC = src
BOOT = boot

CFILES = $(SRC)/kernel.c $(SRC)/sum.c $(SRC)/add.c $(SRC)/input_buffer.c
OFILES = $(CFILES:.c=.o)

all: kernel.iso

# Compile .c files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble the bootloader
loader.o: $(BOOT)/loader.asm
	$(NASM) -f elf32 $(BOOT)/loader.asm -o loader.o

# Link everything into a kernel ELF
kernel.elf: loader.o $(OFILES) link.ld
	$(LD) $(LDFLAGS) -T link.ld loader.o $(OFILES) -o kernel.elf

# Create ISO directory
iso:
	mkdir -p iso/boot/grub

# Copy kernel + GRUB config
iso/boot/kernel.elf: kernel.elf | iso
	cp kernel.elf iso/boot/kernel.elf
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo 'menuentry "MyKernel" { multiboot /boot/kernel.elf }' >> iso/boot/grub/grub.cfg

# Build ISO
kernel.iso: iso/boot/kernel.elf
	grub-mkrescue -o kernel.iso iso

# Run in QEMU
run: kernel.iso
	qemu-system-i386 -cdrom kernel.iso

clean:
	rm -f *.o *.elf kernel.iso
	rm -rf iso
