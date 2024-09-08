[org 0x0100]

jmp start

string:db 'Enter the lowercase alphabets (a~z): '
strsize: dw 37
string2:db 'The output is: '
str2size:dw 15

input:db 0,0,0 ;for storing the input

clrscr:

 push bp
 mov bp,sp
 push es
 push di 
 push ax       

  mov ax,0xb800
  mov es ,ax
  mov di,0
  mov ax,0x0720
 
  next: mov  [es:di],ax
        add di,2
        cmp di,4000
        jne next
  pop ax
  pop di
  pop es
  pop bp
  ret
   
   
   convertstr:
   push bp
   mov bp,sp
   push es
   push di
   push ax
   push si
   push cx    
    
	
	;pointing es towards the video mem
	mov ax,0xb800
	mov es,ax
	mov di,0
	

;printing of first string to ask for inputs	
	mov si,string
	mov ah,0x07
	mov cx,[strsize]
	
   next2: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next2		  
   
   ;taking INPUT  and printing INPUT
    

	mov bh,0x0E ;for yellow foreground
	mov cx,3
	mov si,0
   next3:
          mov ah,0 
	      int 0x16
          mov bl,al
		  mov byte [input+si],al ;storing in memory for uppercase
		  mov [es:di],bx
		  add di ,2
		  inc si
	      dec cx
          jnz next3	

   		  
   ;printing of second string to display out put
    mov si,string2
	mov ah,0x07
	mov cx,[str2size]
	mov di,160
    next4: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next4		

   ;displaing the result on screen   
    mov si,input
	mov ah,0x07
	mov cx,3
    next5: mov al,[si]
           sub al,32
		   mov [es:di],ax
		   add di ,2
		   inc si
	       dec cx
           jnz next5		
   
   pop cx
   pop si
   pop ax
   pop di
   pop es
   pop bp 
   ret 
   
   
   
   

start:
        call clrscr
		call convertstr







mov ax,0x4c00
int 21h