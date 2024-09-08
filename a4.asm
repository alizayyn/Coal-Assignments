[org 0x0100]


jmp start

string:db 'Enter a number between 0-9: '
strsize:dw 28
no1:db 0
string2:db 'Enter a number between 0-'
str2size:dw 25
no2:db 0
string3:db 'The sum is: '
str3size:dw 12
arr:db'Sory sum is greater than 9 :('
arrsize: dw 29

err:db 'Error in input'
error_size:dw 14
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
  
  
  
  
  Range: push bp
         mov bp,sp
		 push es
		 push di
		 push ax
		 push cx
		 push si
		 push bx 
		 push dx
		 ;pointing es to the video mem
		 mov ax,0xb800
		 mov es,ax
      	 mov di,0
	
	;printing for taking inputs
	mov si,string
	mov ah,0x07
	mov cx,[strsize]
	
   next2: mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next2		
	
	mov al,0
	mov ah,0
	int 0x16
	mov bl,al
	      mov bh,0x0E	
		  mov [es:di],bx
    sub bl,0x30
	push bx
	       		  
	

    mov si,string2
	mov ah,0x07
	mov cx,[str2size]
	mov di ,160
	next4: 
	      mov al,[si]
          mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next4
		  
		;printing the range of second no. 
       mov cl,9
	   sub cl,bl
	   mov ch,0x07
	   add cl,0x30
	   mov [es:di],cx
	   add di,2
	   mov ah,0x07
	   mov al,':'
	   mov [es:di],ax
       add di,2
	   mov ax,0x0720
	   
	   mov [es:di],ax
       	   

  ;taking input of 2nd no.
    mov ah,0
	int 0x16

    mov dx,0
    mov dl,al
    sub dl,0x30
	   cmp dl,cl
	   jna next5
       
	   ;;eror 
	
	next5:push dx
	      add dl,0x30
	      mov dh,0x0e
          mov [es:di],dx
          add di ,2
    
	
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
	   add bl,dl
	   cmp bl,9
	   jna next7
       jmp oohsory
        
		next7: 
		      add bl,0x30
			   mov bh,0x07
               mov [es:di],bx
               jmp pops

	   oohsory:
	         mov si,arr
			 mov ah,0xf0
			 mov cx,[arrsize]
  prints:  mov al,[si]	         
           mov [es:di],ax
		   add di,2
		   inc si
		   dec cx 
		   jnz prints
			   

		pops:  
		  pop dx
		  pop bx
		  pop si
		  pop cx
		  pop ax
		  pop di
		  pop es
		  pop bp
		  
		  ret 
  
  
  
  start:
       call clrscr
	   
       call Range
 
   terminate:
   
 
	  
     mov ax,0x4c00
     int 21h