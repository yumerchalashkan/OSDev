.set MULTIBOOT_MAGIC,    0x1BADB002
.set MULTIBOOT_FLAGS,    0x00000003
.set MULTIBOOT_CHECKSUM, -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)


.section .multiboot
.align 4
.long MULTIBOOT_MAGIC
.long MULTIBOOT_FLAGS  
.long MULTIBOOT_CHECKSUM


.section .bss
.align 16
stack_bottom:
.skip 16384  # 16 KB stack
stack_top:


.section .text
.global _start
.type _start, @function

_start:
    
    mov $stack_top, %esp
    
    
    call kernel_main
    
    
    cli
1:  hlt
    jmp 1b