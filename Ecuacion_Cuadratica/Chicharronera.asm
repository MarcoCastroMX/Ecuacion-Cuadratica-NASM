;     nasm -felf64 Chicharronera.asm &&  gcc -no-pie Chicharronera.o && ./a.out

		extern printf
		extern scanf
		global main

		section .text

main:
		push 	RBX
		xor 	RBX,RBX

		mov 	RDI,ValorA
		call 	printf

		mov 	RDI,FormatoFloatScanf
		mov 	RSI,Numero
		call 	scanf

		unpcklps	xmm0, xmm0 
		cvtps2pd	xmm0, xmm0

		movsd 	qword[rel A],xmm0

		mov 	RDI,ValorB
		call 	printf

		mov 	RDI,FormatoFloatScanf
		mov 	RSI,Numero
		call 	scanf

		unpcklps	xmm0, xmm0 
		cvtps2pd	xmm0, xmm0

		movsd 	qword[rel B],xmm0

		mov 	RDI,ValorC
		call 	printf

		mov 	RDI,FormatoFloatScanf
		mov 	RSI,Numero
		call 	scanf

		unpcklps	xmm0, xmm0 
		cvtps2pd	xmm0, xmm0

		movsd 	qword[rel C],xmm0

		fld 	qword[rel B]
		fld 	qword[rel Negativo]
		fmul
		fstp 	qword[rel Parte1]
		fld 	qword[rel B]
		fmul 	ST0,ST0
		fstp 	qword[rel Parte2]
		fld 	qword[rel Cuatro]
		fld 	qword[rel A]
		fmul
		fld 	qword[rel C]
		fmul
		fstp 	qword[rel Parte3]
		fld 	qword[rel Parte2]
		fld 	qword[rel Parte3]
		fsub  	
		fstp 	qword[rel Parte3]

		fld 	qword[rel Parte3]
		fld 	qword[rel Cero]
		fcomip 	ST0,ST1
		jnc 	Salida
		fstp 	qword[rel Numero]
		fld 	qword[rel Parte3]
		fsqrt
		fstp 	qword[rel Parte4]
		fld 	qword[rel Parte1]
		fld 	qword[rel Parte4]
		fadd
		fstp  	qword[rel Parte5]
		fld 	qword[rel Dos]
		fld 	qword[rel A]
		fmul
		fstp 	qword[rel Parte6]
		fld 	qword[rel Parte5]
		fld 	qword[rel Parte6]
		fdiv 
		fstp 	qword[rel ResultadoPositivo]

		fld 	qword[rel Parte1]
		fld 	qword[rel Parte4]
		fsub
		fstp  	qword[rel Parte5]
		fld 	qword[rel Parte5]
		fld 	qword[rel Parte6]
		fdiv 
		fstp 	qword[rel ResultadoNegativo]	

		mov 	RAX,1
		mov 	RDI,ImprimirResultadoPositivo
		movsd 	xmm0,qword[rel ResultadoPositivo]
		call 	printf

		mov 	RAX,1
		mov 	RDI,ImprimirResultadoNegativo
		movsd 	xmm0,qword[rel ResultadoNegativo]
		call 	printf


	Salida:
			pop     RBX                     
			ret

	section .data
ValorA:
		db	"Ingrese valor de A: ",0
ValorB:
		db	"Ingrese valor de B: ",0
ValorC:
		db	"Ingrese valor de C: ",0
ImprimirResultadoPositivo:
		db  "X (positiva): %3.3f",10, 0
ImprimirResultadoNegativo:
		db  "X (negativa): %3.3f",10, 0
FormatoFloatScanf:
		db  "%f", 0
Negativo:
		dq 	-1.0
Cuatro:
		dq 	4.0
Cero:
		dq 	0.0
Dos:
		dq 	2.0

	section .bss
A:
		resq 1
B:
		resq 1
C:
		resq 1
Parte1:
		resq 1
Parte2:
		resq 1
Parte3:
		resq 1
Parte4:
		resq 1
Parte5:
		resq 1
Parte6:
		resq 1
Numero:
		resq 1
ResultadoPositivo:
		resq 1
ResultadoNegativo:
		resq 1