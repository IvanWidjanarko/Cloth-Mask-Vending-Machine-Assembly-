INPUT		EQU P3					; Matrix Keypad menggunakan Port 3 (bit 0 hingga bit 6)
COUNTER		EQU 0					; Counter di R0
D		EQU P1					; Pin D pada LCD 16x2 menggunakan Port 1 (bit 0 hingga bit 7)
RS		EQU P2.0				; Pin RS pada LCD 16x2 menggunakan Port 2 bit 0
RW		EQU P2.1				; Pin RW pada LCD 16x2 menggunakan Port 2 bit 1
ENA		EQU P2.2				; Pin E pada LCD 16x2 menggunakan Port 2 bit 2
SERVO_DIR_1	EQU P2.5				; Pin Direction 1 pada Servo menggunakan Port 2 bit 5
SERVO_MOVE	EQU P2.6				; Pin Move pada Servo menggunakan Port 2 bit 6
SERVO_DIR_2	EQU P2.7				; Pin Direction 2 pada Servo menggunakan Port 2 bit 7
Port_Matrix	EQU P0					; LED_Matrix menggunakan Port 3 (bit 0-3 untuk Row, bit 4-7 untuk Column)
Clear_Matrix	EQU 0FFH				; 11111111B untuk mengclearkan LED Matrix
Delay_Matrix	EQU 032H				; Delay untuk LED Matrix
Mode		EQU 01H					; Mode Timer (TMOD)
Time_A		EQU 0FFH				; Konstanta untuk delay dengan timer
Time_B		EQU 0FEH				; Konstanta untuk delay dengan timer
Clear_Delay	EQU 00H					; Reset Timer (TL0)

	ORG 00H						; Instruksi dimulai dari alamat 00H
INIT:
	MOV Port_Matrix,#Clear_Delay			; Mengclearkan LED Matrix
	MOV A, #038H					; Menggunakan kedua baris dan setiap karakter berukuran 5x7 pixel pada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV A, #0EH					; Layar menyala dan kursor kedap-kedip pada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV A, #01H					; Meng-clear-kan layar pada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV A, #080H					; Kursor dipindahkan ke paling awal dari baris pertamapada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV DPTR, #TAMPILAN1				; Memindahkan isi dari TAMPILAN1 ke DPTR
	LCALL HEM					; Memanggil fungsi HEM
	MOV A, #0C0H					; Kursor dipindahkan ke paling awal baris kedua pada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV DPTR, #TAMPILAN2				; Memindahkan isi dari TAMPILAN2 ke DPTR
	LCALL HEM					; Memanggil subroutine HEM
	LCALL LOOPDE					; Memanggil subroutine LOOPDE
INIT2:	MOV A, #001H					; Meng-clear-kan layar pada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV A, #80H					; Kursor dipindahkan ke paling awal dari baris pertamapada LCD 16x2
	LCALL perintah_LCD				; Memanggil subroutine perintah_LCD
	MOV DPTR, #TAMPILAN3				; Memindahkan isi dari TAMPILAN3 ke DPTR
	LCALL HEM					; Memanggil subroutine HEM
	MOV A, #0C0H					; Kursor dipindahkan ke paling awal baris kedua pada LCD 16x2
	LCALL perintah_LCD				; Memanggil fungsi perintah_LCD
	SJMP MAINAN					; Lompat ke label MAINAN

HEM:	LCALL wait
	CLR A
	MOVC A, @A+DPTR
	JZ DONEE
	LCALL print_LCD
	INC DPTR
	SJMP HEM
DONEE:	RET
wait:
		MOV R1, #0FFH
	wow1:	MOV R2, #00FH
	wow2:	DJNZ R2, wow2
		DJNZ R1, wow1
		RET
perintah_LCD:
		LCALL wait
		MOV D, A
		CLR RS
		CLR RW
		SETB ENA
		CLR ENA
		RET
print_LCD:
		LCALL wait
		MOV D, A
		SETB RS
		CLR RW
		SETB ENA
		CLR ENA
		RET
		
MAINAN:		MOV	COUNTER, #10H
MAIN:		LCALL	KEYPAD
		CJNE	A, #11, ANGKA
		LJMP	MAIN
		
;UNTUK MENYIMPAN NPM;
ANGKA:		MOV R6, #0FFH
		LCALL	LOOPSV
		MOV R6, #02FH
		LCALL	LOOPSV
		XRL	A, #30H
		LCALL	print_LCD
		MOV	@R0, A
		INC	COUNTER
		CJNE	R0, #1AH, MAIN
		LCALL	KOMPER
		LJMP	INIT2

;FUNGSI UNTUK MELAKUKAN COMPARE DENGAN NPM DATA;
KOMPER:		MOV DPTR, #NPM
	LUPLUP:	MOV COUNTER, #10H
	LUP:	CLR A
		MOVC A, @A+DPTR
		MOV 1, @R0
		CJNE A, 1, KELUP
		INC COUNTER
		INC DPTR
		CJNE R0, #1AH, LUP
		MOV A, #01H
		LCALL PERINTAH_LCD
		MOV A, #80H
		LCALL PERINTAH_LCD
		MOV DPTR,#TAMPILAN4
		LCALL HEM
		LCALL OVRES
		RET ;BENER
	KELUP:	JZ KELK
		CLR C
		CLR AC
		MOV A, #1AH
		SUBB A, COUNTER
		ADD A, DPL
		MOV DPL, A
		SJMP LUPLUP
	KELK:	MOV A, #01H
		LCALL PERINTAH_LCD
		MOV A, #80H
		LCALL PERINTAH_LCD
		MOV DPTR,#TAMPILAN5
		LCALL HEM
		MOV R5,#75D
	X:	LCALL MATRIKX
		DJNZ R5, X
		RET
		 ;SALAH
	
;FUNGSI UNTUK MEMBACA KEYPAD;
KEYPAD:		MOV INPUT,#0FFH
		CLR INPUT.0
		JNB INPUT.4,SATU
		JNB INPUT.5,DUA
		JNB INPUT.6,TIGA
		JNB INPUT.7,AA
		SETB INPUT.0
		CLR INPUT.1
		JNB INPUT.4,EMPAT
		JNB INPUT.5,LIMA
		JNB INPUT.6,ENAM
		JNB INPUT.7,BB
		SETB INPUT.1
		CLR INPUT.2
		JNB INPUT.4,TUJUH
		JNB INPUT.5,LAPAN
		JNB INPUT.6,SEMBIL
		JNB INPUT.7,CC
		SETB INPUT.2
		CLR INPUT.3
		JNB INPUT.4,TITIK
		JNB INPUT.5,NOL
		JNB INPUT.6,PAGER
		JNB INPUT.7,DD
		SETB INPUT.3
		MOV A, #11
		RET

	NOL:	MOV A, #0
		RET
	SATU:	MOV A, #1
		RET
	DUA:	MOV A, #2
		RET
	TIGA:	MOV A, #3
		RET
	EMPAT:	MOV A, #4
		RET
	LIMA:	MOV A, #5
		RET
	ENAM:	MOV A, #6
		RET
	TUJUH:	MOV A, #7
		RET
	LAPAN:	MOV A, #8
		RET
	SEMBIL:	MOV A, #9
		RET
	AA:	MOV A, #11
		RET
	BB:	MOV A, #11
		RET
	CC:	MOV A, #11
		RET
	DD:	MOV A, #11
		RET
	TITIK:	MOV A, #11
		RET
	PAGER:	MOV A, #11
		RET

OVRES:	CLR P2.7	;SERVO BERGERAK

	CLR P2.6	;PUSING KANAN
	ACALL LOOPDE
	ACALL LOOPDE
	MOV R6,#59D
	ACALL LOOPSV
	SETB P2.6

	SETB P2.7

	MOV R5,#50D
O:	ACALL MATRIKO
	DJNZ R5, O

	CLR P2.5	;BALIK

	CLR P2.6	;PUSING KIRI
	ACALL LOOPDE
	ACALL LOOPDE
	MOV R6,#123D
	ACALL LOOPSV
	SETB P2.6

	SETB P2.5	;KUTUB 0/0

	ACALL LOOPDE
	RET

MATRIKX:MOV P0,#0E9H
	MOV R6,#10H
	ACALL LOOPSV
	MOV P0,#0D6H
	MOV R6,#10H
	ACALL LOOPSV
      	MOV P0,#0B6H
      	MOV R6,#10H
	ACALL LOOPSV
      	MOV P0,#079H
      	MOV R6,#10H
	ACALL LOOPSV
	MOV P0,#00H
      	RET

MATRIKO:MOV P0,#0E6H
	MOV R6,#10H
	ACALL LOOPSV
	MOV P0,#0D9H
	MOV R6,#10H
	ACALL LOOPSV
      	MOV P0,#0B9H
      	MOV R6,#10H
	ACALL LOOPSV
      	MOV P0,#076H
      	MOV R6,#10H
	ACALL LOOPSV
	MOV P0,#00H
      	RET

LOOPDE:	MOV R6,#10D
ITER:	MOV R7,#100D
LOOP:	ACALL DELAY
	DJNZ R7,LOOP
	DJNZ R6,ITER
	RET

LOOPSV:	ACALL DELAY
	DJNZ R6,LOOPSV
	RET

DELAY: 	MOV TMOD,#00000001B
       	MOV TH0,#0FCH
       	MOV TL0,#066H
       	SETB TR0
HERE: 	JNB TF0,HERE
      	CLR TR0
      	CLR TF0
      	RET

;DEFINE VARIABEL
ORG 	0A00H
NPM:	DB '1806148694'
	DB '1806148706'
	DB '1806148712'
	DB '1806199953'
	DB 0

TAMPILAN1:	DB 'SALAM,MAHASISWA!',0
TAMPILAN2:	DB '     START!     ',0
TAMPILAN3:	DB 'MASUKAN NPM:',0
TAMPILAN4:	DB 'SILAHKAN AMBIL',0
TAMPILAN5:	DB 'NPM SALAH',0

END