INCLUDE Irvine32.inc

 

.data
prompt1 BYTE "Welcome to Snake and Ladders!", 0
prompt2 BYTE "Press Enter to roll the dice: ", 0
prompt4 BYTE "You Rolled :  ", 0
prompt5 BYTE "Your Position is :  ", 0

prompt6 BYTE "There is a Ladder at position 3", 0
prompt7 BYTE "There is a Ladder at position 20", 0
prompt8 BYTE "There is a Ladder at position 63", 0
prompt9 BYTE "There is a Ladder at position 80", 0
prompt10 BYTE "There is a Snake at position 98", 0
prompt11 BYTE "There is a Snake at position 40", 0
prompt12 BYTE "There is a Snake at position 50", 0


result BYTE 20 DUP(?)
prompt3 BYTE "GAMEOVER, YOU WON", 0
ranNum DWORD ?

 

.code
main PROC
    call Clrscr
    mov edx, OFFSET prompt1 ;Address of prompt 1 is going to edx and being displayed by WriteString
    call WriteString
    call Crlf


    mov edx, OFFSET prompt6
    call WriteString
    call Crlf
    mov edx, OFFSET prompt7
    call WriteString
    call Crlf
    mov edx, OFFSET prompt8
    call WriteString
    call Crlf
    mov edx, OFFSET prompt9
    call WriteString
    call Crlf
    mov edx, OFFSET prompt10
    call WriteString
    call Crlf
    mov edx, OFFSET prompt11
    call WriteString
    call Crlf
    mov edx, OFFSET prompt12
    call WriteString
    call Crlf


    mov edx, 0 ;Check if zero or O here

 

    mov ebx, 0     ; initialize sum of dice rolls to 0
    mov eax, 0      ; initialize position on board to 0

 

roll_dice:
    cmp eax,100
    je game_over
    push eax
    call Crlf
    mov edx, OFFSET prompt2
    call WriteString
    call ReadChar

 

    call Randomize           ;Sets seed
    mov  eax,6              ;Keeps the range 0 - 5
    call RandomRange       
    inc eax                 ;make range 1 to 6
    mov  ranNum,eax  ;save random number
    call crlf
    mov edx, OFFSET prompt4
    call WriteString
    call writedec   ;Printing whatever is in eax
    call crlf

 

    pop eax     ;eax position value is popped. No value in it for now.


    add eax, ranNum     ; add dice roll to position on board
    cmp eax, 100     ; check if player has reached the end of the board
    jge game_over    ; if player has reached the end, go to game_over label

    ; check if player lands on a snake or ladder
    cmp eax, 3       ; check if player lands on square 3
    je square_3
    cmp eax, 20      ; check if player lands on square 20
    je square_20
    cmp eax, 50      ; check if player lands on square 50
    je square_50
    cmp eax, 63      ; check if player lands on square 63
    je square_63
    cmp eax, 80      ; check if player lands on square 80
    je square_80
    cmp eax, 98      ; check if player lands on square 98
    je square_98
    jmp display_position
    cmp eax, 40      ; Check if player lands on square 40
    je square_40 
    jmp display_position

square_3:
    mov eax, 10      ; (Ladder) move player to square 10
    jmp display_position

 

square_20:
    mov eax, 29      ; (Ladder) move player to square 29
    jmp display_position


square_63:
    mov eax, 81      ; (Ladder) move player to square 81
    jmp display_position

 

square_80:
    mov eax, 99      ; (Ladder) move player to square 99
    jmp display_position

 

square_98:
    mov eax, 77      ; (Snake) move player to square 77
    jmp display_position

square_40:
    mov eax, 22      ; (Snake) move player to 22
    jmp display_position

square_50:
    mov eax, 30      ; (Snake) move player to square 67
    jmp display_position

 

display_position:
    mov edx, OFFSET prompt5
    call WriteString      
    call Writedec ; value of eax is displayed
    call Crlf
    jmp roll_dice

 

game_over:
    call Crlf
    mov edx, OFFSET prompt5
    call WriteString      
    call Writedec
    call crlf
    mov edx, OFFSET prompt3
    call WriteString
    call crlf
    exit
main ENDP
END main