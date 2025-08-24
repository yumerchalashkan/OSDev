void kernel_main() {
    
    unsigned short* video_memory = (unsigned short*)0xB8000;
    
   
    for (int i = 0; i < 80 * 25; i++) {
        video_memory[i] = 0x4020; 
    }
    
    
    video_memory[0] = 0x0F41; 
    video_memory[1] = 0x0F42; 
    video_memory[2] = 0x0F43; 
    
    // Sonsuz döngü
    while (1) {
        asm("hlt");
    }
}