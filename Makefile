CC = gcc
CFLAGS = -m32 -c -ffreestanding -nostdlib

all: kernel.iso


kernel.o: kernel.c
	$(CC) $(CFLAGS) kernel.c -o kernel.o


boot.o: boot.s
	as --32 boot.s -o boot.o


kernel.elf: boot.o kernel.o
	ld -m elf_i386 -T linker.ld boot.o kernel.o -o kernel.elf


kernel.iso: kernel.elf
	mkdir -p iso/boot/grub
	cp kernel.elf iso/boot/
	echo 'menuentry "My Simple Kernel" {' > iso/boot/grub/grub.cfg
	echo '    multiboot /boot/kernel.elf' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue -o kernel.iso iso


test: kernel.iso
	qemu-system-i386 -cdrom kernel.iso -m 32M -nographic


clean:
	rm -rf *.o *.elf *.iso iso/

.PHONY: all test clean