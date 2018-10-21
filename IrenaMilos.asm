; Network protocol                 (IrenaMilos.asm)



INCLUDE Irvine32.inc
INCLUDE macros.inc

BUFFER_SIZE = 251
LINE_LENGTH=10

GRAY=200
GREEN=50
RED=100
BLUE=75
YELLOW=150
NULA=48
JEDAN=49
.data
buffer BYTE BUFFER_SIZE DUP(?)
linija BYTE 11 DUP(0)
filename    BYTE "protocol.txt",0
fileHandle  HANDLE ?
broj_linija BYTE ?
timer WORD 1000
startTime DWORD ?
ONOFF BYTE 0



x0_cord0 DWORD 16 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord0 DWORD 10
x1_cord0 DWORD 17 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord0 DWORD 13

x0_cord0r DWORD 10 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord0r DWORD 7
x1_cord0r DWORD 13 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord0r DWORD 8

x0_cord0y DWORD 10 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord0y DWORD 11
x1_cord0y DWORD 13 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord0y DWORD 12

x0_cord0g DWORD 10 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord0g DWORD 15
x1_cord0g DWORD 13 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord0g DWORD 16




x0_cord1 DWORD 36 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord1 DWORD 6
x1_cord1 DWORD 43 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord1 DWORD 6

x0_cord1r DWORD 30 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord1r DWORD 3
x1_cord1r DWORD 33 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord1r DWORD 4

x0_cord1y DWORD 38 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord1y DWORD 3
x1_cord1y DWORD 41 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord1y DWORD 4

x0_cord1g DWORD 46 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord1g DWORD 3
x1_cord1g DWORD 49 ; x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord1g DWORD 4




x0_cord2 DWORD 62 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord2 DWORD 10
x1_cord2 DWORD 63 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord2 DWORD 13

x0_cord2r DWORD 66 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord2r DWORD 7
x1_cord2r DWORD 69 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord2r DWORD 8

x0_cord2y DWORD 66 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord2y DWORD 11
x1_cord2y DWORD 69 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord2y DWORD 12

x0_cord2g DWORD 66 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord2g DWORD 15
x1_cord2g DWORD 69 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord2g DWORD 16




x0_cord3 DWORD 36 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord3 DWORD 17
x1_cord3 DWORD 43 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord3 DWORD 17

x0_cord3r DWORD 46 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord3r DWORD 19
x1_cord3r DWORD 49 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord3r DWORD 20

x0_cord3y DWORD 38 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord3y DWORD 19
x1_cord3y DWORD 41 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord3y DWORD 20

x0_cord3g DWORD 30 ;x0 i y0 su koordinate gornjeg levog ugla kvadrata
y0_cord3g DWORD 19
x1_cord3g DWORD 33 ;x1 i y1 su koordinate donjeg desnog ugla kvadrata
y1_cord3g DWORD 20

color DWORD 200,200,200,200 ;bajt za boju kvadrata
colorr DWORD 200,200,200,200 ;bajt za boju kvadrata
colory DWORD 200,200,200,200 ;bajt za boju kvadrata
colorg DWORD 200,200,200,200 ;bajt za boju kvadrata


cursorInfo CONSOLE_CURSOR_INFO <>
outHandle DWORD ?

.code



Draw PROC x0:DWORD, x1:DWORD, y0:DWORD, y1:DWORD, boja:DWORD
	DrawVertical_proc: ;iscrtavanje po vertikali
	mov eax, 0
	mov eax, boja ;postavljamo boju kvadrata koji treba iscrtati
	call SetTextColor
	mov eax, 0
	mov edx, x0 ;u dl stavljamo x cursor position
	mov eax, x1
	sub eax, x0
	add eax, 1
	mov ecx, eax 
	xor eax, eax
	mov eax, y0
	shl eax, 8 
	add edx, eax
	xor eax, eax
	mov al, 0DBh ;solid-block
	DrawHorizontal_proc: ;iscrtavamo po x osi ecx puta
	call Gotoxy
	call WriteChar
	inc edx
	loop DrawHorizontal_proc
	shr edx, 8
	cmp edx, y1
	jz kraj
	inc y0
	jmp DrawVertical_proc

	kraj:
	ret
Draw endp

Crtaj PROC
	

	
	push color[0]
	push y1_cord0
	push y0_cord0
	push x1_cord0
	push x0_cord0
	call Draw
	
	

	push colorr[0]
	push y1_cord0r
	push y0_cord0r
	push x1_cord0r
	push x0_cord0r
	call Draw
	

	push colory[0]
	push y1_cord0y
	push y0_cord0y
	push x1_cord0y
	push x0_cord0y
	call Draw
	

	push colorg[0]
	push y1_cord0g
	push y0_cord0g
	push x1_cord0g
	push x0_cord0g
	call Draw
	


	push color[4]
	push y1_cord1
	push y0_cord1
	push x1_cord1
	push x0_cord1
	call Draw
	

	push colorr[4]
	push y1_cord1r
	push y0_cord1r
	push x1_cord1r
	push x0_cord1r
	call Draw
	

	push colory[4]
	push y1_cord1y
	push y0_cord1y
	push x1_cord1y
	push x0_cord1y
	call Draw
	

	push colorg[4]
	push y1_cord1g
	push y0_cord1g
	push x1_cord1g
	push x0_cord1g
	call Draw
	


	push color[8]
	push y1_cord2
	push y0_cord2
	push x1_cord2
	push x0_cord2
	call Draw
	

	push colorr[8]
	push y1_cord2r
	push y0_cord2r
	push x1_cord2r
	push x0_cord2r
	call Draw
	

	push colory[8]
	push y1_cord2y
	push y0_cord2y
	push x1_cord2y
	push x0_cord2y
	call Draw
	

	push colorg[8]
	push y1_cord2g
	push y0_cord2g
	push x1_cord2g
	push x0_cord2g
	call Draw
	


	push color[12]
	push y1_cord3
	push y0_cord3
	push x1_cord3
	push x0_cord3
	call Draw
	

	push colorr[12]
	push y1_cord3r
	push y0_cord3r
	push x1_cord3r
	push x0_cord3r
	call Draw
	

	push colory[12]
	push y1_cord3y
	push y0_cord3y
	push x1_cord3y
	push x0_cord3y
	call Draw
	

	push colorg[12]
	push y1_cord3g
	push y0_cord3g
	push x1_cord3g
	push x0_cord3g
	call Draw
	
	ret
Crtaj endp


Postavi PROC
	cmp linija[0],NULA
	jz nesistemska
	mov color[0],GRAY
	mov color[4],GRAY
	mov color[8],GRAY
	mov color[12],GRAY
	cmp linija[3],JEDAN
	je ukljuci
	cmp linija[7],JEDAN
	je sekund
	cmp linija[6],NULA
	je iskljuci
	
	mov timer,500
	jmp kraj
sekund:
	mov timer,1000
	jmp kraj
ukljuci:
	mov ONOFF,1
	jmp kraj
iskljuci:
	mov ONOFF,0
	mov color[0],GRAY
	mov colorr[0],GRAY
	mov colory[0],GRAY
	mov colorg[0],GRAY
	mov color[4],GRAY
	mov colorr[4],GRAY
	mov colory[4],GRAY
	mov colorg[4],GRAY
	mov color[8],GRAY
	mov colorr[8],GRAY
	mov colory[8],GRAY
	mov colorg[8],GRAY
	mov color[12],GRAY
	mov colorr[12],GRAY
	mov colory[12],GRAY
	mov colorg[12],GRAY
	jmp kraj

nesistemska:
	cmp ONOFF,0
	je kraj
	cmp linija[1],JEDAN;poredjenje da li je poruka broadcast
	jne nastavak 
	mov color[0],BLUE;ovde krece obrada broadcasta
	mov color[4],BLUE
	mov color[8],BLUE
	mov color[12],BLUE

	cmp linija[4],NULA
	jne dOFFb
	cmp linija[5],NULA
	je kraj
	cmp linija[6],NULA
	jne GB
	cmp linija[7],NULA
	jne YB
	mov colorr[0],RED
	mov colorr[4],RED
	mov colorr[8],RED
	mov colorr[12],RED
	jmp kraj
GB:
	mov colorg[0],GREEN
	mov colorg[4],GREEN
	mov colorg[8],GREEN
	mov colorg[12],GREEN
	jmp kraj
YB: 
	mov colory[0],YELLOW
	mov colory[4],YELLOW
	mov colory[8],YELLOW
	mov colory[12],YELLOW
	jmp kraj

dOFFb:;da se sve diode jedne boje iskljuce
	cmp linija[6],NULA
	jne GBW
	cmp linija[7],NULA
	jne YBW
	mov colorr[0],GRAY;ovde sve crvene
	mov colorr[4],GRAY
	mov colorr[8],GRAY
	mov colorr[12],GRAY
	jmp kraj
GBW:
	mov colorg[0],GRAY;ovde sve zelene
	mov colorg[4],GRAY
	mov colorg[8],GRAY
	mov colorg[12],GRAY
	jmp kraj
YBW: 
	mov colory[0],GRAY; ovde sve zute
	mov colory[4],GRAY
	mov colory[8],GRAY
	mov colory[12],GRAY
	jmp kraj

nastavak:
	cmp linija[2],NULA
	je nizi
	cmp linija[3],NULA
	je u2
	mov eax,12;ovde je adresirana treca
	jmp proces
u2:
	mov eax,8;ovde je adresirana druga
	jmp proces
nizi:
	cmp linija[3],NULA
	je u0
	mov eax,4;ovde je adresirana prva
	jmp proces
u0:	
	mov eax,0; i ovde je adresirana nulta
proces:
	mov color[0],GRAY
	mov color[4],GRAY
	mov color[8],GRAY
	mov color[12],GRAY
	mov color[eax],BLUE ;ovde se oboji adresirana u plavo
	cmp linija[4],NULA
	jne dOFF
	cmp linija[5],NULA
	je kraj
	cmp linija[6],NULA
	jne G
	cmp linija[7],NULA
	jne Y
	mov colorr[eax],RED

	jmp kraj
G:
	mov colorg[eax],GREEN

	jmp kraj
Y: 
	mov colory[eax],YELLOW

	jmp kraj

dOFF:;da se iskljuce diode
	cmp linija[6],NULA
	jne GW
	cmp linija[7],NULA
	jne YW
	mov colorr[eax],GRAY;ovde se crvena iskljucuje

	jmp kraj
GW:
	mov colorg[eax],GRAY;ovde zelena

	jmp kraj
YW: 
	mov colory[eax],GRAY;ovde zuta

kraj:
	ret
Postavi endp



main PROC
	call Clrscr
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outHandle, eax
	INVOKE GetConsoleCursorInfo, outHandle, ADDR cursorInfo
	mov cursorInfo.bVisible,0
	INVOKE SetConsoleCursorInfo, outHandle, ADDR cursorInfo
	xor eax,eax

; Open the file for input.
	mov	edx,OFFSET filename
	call	OpenInputFile
	mov	fileHandle,eax

; Check for errors.
	cmp	eax,INVALID_HANDLE_VALUE		; error opening file?
	jne	file_ok					; no: skip
	call	WriteWindowsMsg
	jmp	quit						; and quit
file_ok:

; Read the file into a buffer.
	mov	edx,OFFSET buffer
	mov	ecx,BUFFER_SIZE
	call	ReadFromFile
	jnc	check_buffer_size			; error reading?
	
	call	WriteWindowsMsg
	jmp	close_file
	
check_buffer_size:
	cmp	eax,BUFFER_SIZE			; buffer large enough?
	jb	buf_size_ok				; yes
	mWrite <"Insufficient buffer size!",0dh,0ah>
	jmp	quit						; and quit
	
buf_size_ok:

	xor ebx,ebx
	mov bl,LINE_LENGTH
	div bl
	mov broj_linija,al
	mov	linija[ebx],0		; insert null terminator
	xor ecx,ecx
	
	xor eax,eax
	xor edx,edx
	
petlja1:
	mov esi,edx
	INVOKE GetTickCount		; get starting tick count, prebrisace ECX registar!!!
	mov	startTime,eax	


	mov ebx,LINE_LENGTH
	xor eax,eax
	xor edi,edi
	mov edx,esi
citanje_linije:
	
	mov al,buffer[edx]
	mov linija[edi],al
	inc edx
	inc edi
	dec ebx
	cmp ebx,0
	jnz citanje_linije

	mov ebx,edx






	call Postavi
	Call Crtaj
	
	meri_vreme:

	
	INVOKE GetTickCount		; get new tick count
	cmp	eax,startTime	
	jb	error
	sub	eax,startTime
	cmp ax,timer
	jle meri_vreme
	
	mov edx,ebx
	xor eax,eax
	xor ebx,ebx
	dec broj_linija ; 
	
	cmp broj_linija, 0
	jnz petlja1



	






close_file:
	mov	eax,fileHandle
	call	CloseFile
	jmp quit
error:
	mWrite "Error: GetTickCount invalid--system has "
	mWrite <"been active for more than 49.7 days",0dh,0ah>
quit:
	exit
main ENDP

END main