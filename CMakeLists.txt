cmake_minimum_required(VERSION 3.16)
project(SimpleKernel C ASM)


set(CMAKE_C_COMPILER gcc)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i386)


set(CMAKE_C_FLAGS "-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -ffreestanding")


set(CMAKE_EXE_LINKER_FLAGS "-m elf_i386 -Ttext 0x1000")


add_executable(kernel.elf kernel.c)


add_custom_command(
    TARGET kernel.elf POST_BUILD
    COMMAND objcopy -O binary kernel.elf kernel.bin
    COMMENT "Converting ELF to binary"
)


add_custom_target(test
    COMMAND qemu-system-i386 -kernel kernel.bin
    DEPENDS kernel.elf
    COMMENT "Running kernel in QEMU"
)


set_property(DIRECTORY PROPERTY ADDITIONAL_MAKE_CLEAN_FILES "kernel.bin")