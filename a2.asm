[org 0x0100]

jmp start

ALPHA: dw 36
string:db 'ALPHA is:'
strsize:dw 9

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
		 push bx
	      push dx
		  mov ax,0xb800     ; for setting es to display memory
	      mov es,ax
	      mov di,160      
	      mov cx,[bp+4]  ;moving char count in cx
		  mov si,[bp+6];moving the address of first index of string in si
		  mov ah,0x07  ; white background pe black blinking character 
		
		nextchar:
		      mov al,[si]
		     mov [es:di],ax
		     add di,2
			 add si,1
		     dec cx
		     jnz nextchar
          
		  mov ax,[bp+8]
		  mov bx ,10
		  mov cx,0
		  
		  next2: mov dx, 0    ; qoutient will store in dx
                 div bx       
                 add dl, 0x30  
                 push dx      ;pusing the value of qoutient on stack
                 inc cx       ;maintaing counter for printing
                 cmp ax, 0    
                 jnz next2    
				 
				 print:
				 pop dx 
                 mov dh, 0xF0
                 mov [es:di], dx 
                 add di, 2 ; 
                 dec cx
				  jnz print
				 
		  
		  pop dx
          pop bx		  
		  pop si
		  pop cx
		  pop ax     	  
	      pop di
		  pop es
          pop bp
		  
		  ret 6

	 
	  
	
start:   call clrscr
         mov ax,[ALPHA]
		 push ax
         mov ax,string 
         push ax
		 mov ax,[strsize]
		 push ax
         call display





mov ax,0x4c00
int 21h 