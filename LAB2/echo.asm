ORG 0x7C00  

mov cx, 0

MainLoop:
    xor ah, ah   
    int 16h  
    
    cmp al, 0Dh
    je  HandleEnter
    cmp al, 08h 
    je  HandleBackspace

    cmp cx, 256
    je OnlyBackspaceEnter

    mov ah, 0Eh 
    int 10h     
    inc cx
    jmp MainLoop 

OnlyBackspaceEnter:
    cmp al, 08h
    je HandleBackspace
    cmp al, 0Dh
    je HandleEnter
    jmp MainLoop

HandleEnter:
    mov ax, 0E0Dh 
    int 10h      
    mov ax, 0E0Ah 
    int 10h      
    mov cx, 0 
    jmp MainLoop

HandleBackspace:
    test cx, cx 
    jz MainLoop 

    dec cx 
    mov ah, 03h 
    int 10h     

    dec dl       
    mov ah, 02h 
    int 10h     
    mov ah, 0Eh 
    mov al, ' '  
    int 10h     
    mov ah, 02h 
    int 10h     

    jmp MainLoop 