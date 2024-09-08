[org 0x0100]

jmp start

string: db 'Enter a 2-digit number: '
strsize: dw 24

no1: db 0,0


string2: db 'Enter another 2-digit number: '
str2size: dw 30

no2: db 0,0


PrintNum:
	push bp
	mov bp, sp
	push es
	push di
	push dx
	push cx
	push bx
	push ax
	
	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+4]
	mov bx, 10
	mov cx, 0

	break:
		mov dx, 0
		div bx
		add dx, 30h
		push dx
		inc cx
		test ax, 0xFFFF
		jnz break
	
	next:
		pop ax
		mov ah, 0x07
		stosw
		loop next

		pop ax
	pop bx
	pop cx
	pop dx
	pop di
	pop es
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
  
  
  sum:
   push bp
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
		 mov cx,[strsize]
		 mov ah,0x07
		 
		 next1: 
		  mov al,[si] 
		  mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next1	
         	
mov cx,2			
		mov si,0
		lp1:		 
		    mov ah,0
			int 0x16
            sub al,0x30			
		    mov byte [no1+si],al
			 
			 add al,0x30
			 mov ah ,0x07
			 mov  [es:di],ax
	          
          	add di,2
			 inc si
			 dec cx
			 jnz lp1
		
		 
		 mov si,string2
		 mov cx,[str2size]
		 mov ah,0x07
		 mov di ,160
		 next3: 
		  mov al,[si] 
		  mov [es:di],ax
		  add di ,2
		  inc si
	      dec cx
          jnz next3	
         
		 mov cx,2			
		mov si,0	 
				lp2:		 
		    mov ah,0
			int 0x16	 
		    sub al,0x30
			mov byte [no2+si],al
			add al,0x30
             mov ah,0x07
			 mov [es:di],ax
			 add di,2
			 inc si
			 dec cx
			 jnz lp2
				 	  ;sum
		  
				 mov ah,[no1]
						
    			mov al,[no1+1]
				 xchg ah,al
				 mov cx,10
				 mul cl
				 add al,ah
				 mov ah,0
				 
				  mov bh,[no2]
				  mov bl,[no2+1]
				 
                  xchg bh,bl
                xchg ax,bx
				
				 mov cx,10
				 mul cl
				 add al,ah
							  
				 add al,bl
				  mov di ,320
		          	 
					 ;xchg ah,al
					 mov ah,0
					 push ax
					 call PrintNum
		   
		 
		 
		 
		 
		 
		 
		 
		 pop dx
		 pop bx
		 pop si
		 pop cx
		 pop ax
		 pop di
		 pop es
          ret 
  



start:
     call clrscr
      
	
      call sum
   


mov ax,0x4c00
int 21h