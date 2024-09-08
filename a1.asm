[org 0x0100]

jmp start

  string: db 'I won $25000 in lottery but I lost $5000'
  strsize:dw 40

clrscr:
       push bp
	   mov bp,sp
	   push ax
	   push es
	   push di
	 
	   mov ax,0xb800
	   mov es,ax
	   mov di,0

	   mov ax,0x0720
	 next:  
	        mov [es:di],ax
            add di,2
			cmp di ,4000
            jne next
	 pop di
     pop es
     pop ax 
     pop bp
      ret	 
	  
	  
	  
display: push bp
         mov bp,sp
		 push es
		 push di
       	 push ax
		 push cx
		 push si
		 
	      mov ax,0xb800     ; for setting es to display memory
	      mov es,ax
	      mov di,200       
	      mov cx,[bp+4]  ;moving char count in cx
		  mov si,[bp+6];moving the address of first index of string in si
		  mov ah,0x71  ; white background pe black blinking character 
		
		nextchar:
		      mov al,[si]
		     mov [es:di],ax
		     add di,2
			 add si,1
		     dec cx
		     jnz nextchar
          
		  pop si
		  pop cx
		  pop ax     	  
	      pop di
		  pop es
          pop bp
		  
		  ret 4

	 
	  
	
start:   call clrscr
         mov ax,string 
         push ax
		 mov ax,[strsize]
		 push ax
         call display





mov ax,0x4c00
int 21h