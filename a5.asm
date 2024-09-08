[org 0x0100]


jmp start

string:db 'Enter a number between 0-9: '
strsize:dw 28
no1:db 3
string2:db 'Enter another number between 0-9: '
str2size:dw 34
no2:db 1
string3:db 'Sum = '
str3size:dw 6
string4:db 'Difference = '
str4size: dw 13
string5: db 'Product = '
str5size:dw 10
string6: db 'Division = '
str6size: dw 11

PrintNumbers:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push di
	push es
	
	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+4]
	mov bx, 10
	mov cx, 0

	split:
		mov dx, 0
		div bx
		add dx, 30h
		push dx
		inc cx
		test ax, 0xFFFF
		jnz split
	
	nextnum:
		pop ax
		mov ah, 0x07
		stosw
		loop nextnum

	pop es
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	mov sp, bp
	pop bp
	ret 6
	
	
	
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
  
  
  
  
  Maths: push bp
         mov bp,sp
		 push es
		 push di
		 push ax
		 push cx
		 push si
		 push bx 
		 push dx
		 
		 mov ax,0xb800
		 mov es,ax
      	 mov di,0
	
	mov si,string
	mov ah,0x07
	mov cx,[strsize]
	
   next2: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next2		
	
	   mov ah,0
	   int 0x16
	
         mov bl,al	
	     sub bl,0x30 
		  mov bh,0
	      push bx
	      add bl,0x30
	      mov bh,0x07
          mov [es:di],bx
		            		  
	

    mov si,string2
	mov ah,0x07
	mov cx,[str2size]
	mov di ,160
	next4: mov al,[si]
           mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next4

mov ah,0
int 0x16

    mov dx,0
    mov dl,al
    sub dl,0x30
	mov dh,0
	push dx
	add dl,0x30
	mov dh,0x07
    mov [es:di],dx

    
	
	  mov si,string3
	mov ah,0x07
	mov cx,[str3size]
   mov di ,320	
   next6: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next6		 

         pop dx 
         pop bx
        
	  
        
		sum: 
	   mov ax,0		 
	   mov al,bl
	   add al,dl
			   mov ah,0
               push ax 
			   call PrintNum
               
      
	  mov si,string4
	mov ah,0x07
	mov cx,[str4size]
   mov di ,480	
   next7: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next7		 
  
	 diff: 
	    mov ax,0		 
	   mov al,bl
	   cmp al,dl
	   ja skip
	  ; xchg al,dl 
	   mov cl,al
	   mov al,dl
      mov dl ,cl	   
	   skip:
	         sub al,dl
			 mov ah,0
			 push ax
		     call PrintNum
        
  
  
  
	         
      mov si,string5
	mov ah,0x07
	mov cx,[str5size]
   mov di ,640	
   next8: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next8 
		  
		  
	 prod: 
	           mov ax,0		 
	           mov al,dl
			   ;mov dx,0
	           mul bl  
			   mov ah,0
               push ax       
		       call PrintNum
		  
			   
			          
      mov si,string6
	mov ah,0x07
	mov cx,[str6size]
   mov di ,800	
   next9: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next9


     divi: 
	      mov ax,0
		   mov al,bl
	   cmp al,dl
       ja skip1
	   xchg al,dl 
	   skip1:             
			
			   div bl
			   mov ah,0
               push ax
               call PrintNum




		pops:  
		  pop dx
		  pop bx
		  pop si
		  pop cx
		  pop ax
		  pop di
		  pop es
		  pop bp
		  
		  ret 28
  
  
  
  start:
  
	   call clrscr
	   
	   
       call Maths
 
 








   terminate:
     mov ax,0x4c00
     int 21h