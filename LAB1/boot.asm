ORG 0x7C00 ; Set origin to 7C00H, where BIOS loads the boot sector

; Method 1: Write character as TTY (0EH)
mov AH, 0Eh ; Write character to TTY
mov AL, 'I' ; Character to write
int 10h    ; Call BIOS video 

; Move cursor to next row (02H)
mov AH, 02h
mov BH, 0 ; Page number 
mov DH, 1 ; Row number
mov DL, 0 ; Column number
int 10h

; Method 2: Write character (0aH)
mov AH, 0aH
mov AL, 'G'
int 10h

; Move cursor to next row
mov AH, 02h
mov BH, 0
mov DH, 2
mov DL, 0
int 10h

; Method 3: Write character/attribute (09h)
mov AH, 09h  
mov AL, 'O'  
mov BL, 0x07 ; Attribute for color (standard gray on black)
mov CX, 1    ; Number of times to write the character
int 10h      

; Move cursor to next row
mov AH, 02h
mov BH, 0
mov DH, 3
mov DL, 0
int 10h

; Method 4: Display character + attribute (1302H)
mov AH, 13h
mov AL, 2
mov BH, 0
mov BL, 0x04   ; Color attribute: red
mov DH, 4 
mov DL, 0 
mov CX, 1      ; Number of times to write the character
lea BP, [MsgMethod4]
int 10h

; Method 5: Display character + attribute & update cursor (1303H)
mov AH, 13h
mov AL, 3
mov BH, 0
mov BL, 0x0A   ; Color attribute: light green
mov DH, 5
mov DL, 0
mov CX, 1
lea BP, [MsgMethod5]
int 10h

; Method 6: Display string (1300H)
mov AH, 13h
mov AL, 0
mov BH, 0
mov BL, 0x04 ; Standard color
mov DH, 6
mov DL, 0
lea BP, MsgMethod6
mov CX, 14   ; Account for character + attribute for each byte, in my case 7 characters
int 10h


; Method 7: Display string & update cursor (1301H)
mov AH, 13h
mov AL, 1
mov BH, 0
mov BL, 0x21 ; Standard color
mov DH, 17
mov DL, 35
lea BP, MsgMethod7
mov CX, 14   ; Account for character + attribute for each byte, in my case 7 characters
int 10h

; Data segment
MsgMethod4 db '+'
MsgMethod5 db '!'
MsgMethod6 db '2', 0x07, 'Y', 0x07, 'S', 0x07, 'T', 0x07, 'E', 0x07, 'M', 0x07, '1', 0x07  
MsgMethod7 db '1', 0x07, 'Y', 0x07, 'S', 0x07, 'T', 0x07, 'E', 0x07, 'M', 0x07, '2', 0x07

; End of program
int 20h