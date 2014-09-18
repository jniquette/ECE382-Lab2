;-------------------------------------------------------------------------------
; ECE382 - Lab 2 - XOR Decrypter
;	Author: 	C2C Justin Niquette
;	Instructor:	Capt Trimble
;	MCU: 		MSP430G2553
;	Date:		16 Sep 2014
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
                                            ; Constants
;-------------------------------------------------------------------------------

;Required Functionality
;ENC_TEXT:		.byte	0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8
;				.byte 	0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c
;				.byte	0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8
;				.byte	0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4
;				.byte	0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd
;				.byte	0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5
;				.byte	0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde
;				.byte	0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2
;				.byte	0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
;ENC_LENGTH:		.byte	94
;KEY:			.byte	0xac
;KEY_LENGTH:		.byte	1


; B Functionality
ENC_TEXT:		.byte	0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba
				.byte	0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4
				.byte	0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50
				.byte	0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff
				.byte	0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9
				.byte	0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a
				.byte	0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf
				.byte	0x42,0xcf,0xba,0x50,0x8f
ENC_LENGTH:		.byte	82
KEY:			.byte	0xac,0xdf,0x23
KEY_LENGTH:		.byte	3

ANS_START:		.word	0x0200

;-------------------------------------------------------------------------------
                                            ; Variables
;-------------------------------------------------------------------------------
EncPointer:		.equ	r4
KeyPointer:		.equ	r5
EncCount:		.equ	r6
KeyCount:		.equ	r7
AnswerPointer:	.equ	r8
EncByte:		.equ	r9
KeyByte:		.equ	r10


;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
			;Initialize the Pointers to the beginning of that string and Counters
			;to zero
			mov		ANS_START, 			AnswerPointer
			mov		#ENC_TEXT,			EncPointer
			mov		#KEY,				KeyPointer
			mov		#0,					EncCount
			mov		#0,					KeyCount


main:
			; See if the enc_counter is equal to the enc_length and exit
			cmp		EncCount, 			ENC_LENGTH
			jeq		forever

			; Get the next byte of the key and encrypted text
			call    #GetBytes

			; Get the next byte of the key and encrypted text
			call    #DecryptByte

			;Restart the loop
			jmp		main

forever:    jmp     forever

;-------------------------------------------------------------------------------
                                            ; Subroutines
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;Subroutine Name: GetBytes
;Author: Justin Niquette
;Function: This subroutine reads the next byte of the encrypted text and of the
;			key from ROM at EncPointer and KeyPointer respectively. If the end
;			of the key has been reached, the KeyPointer will restart at the
;			beginning of the string.
;Inputs:	EncPointer, KeyPointer, EncCount, KeyCount
;Outputs:	KeyByte, EncByte
;Registers destroyed:
;-------------------------------------------------------------------------------

GetBytes:
			; Get the next byte of encrypted text
			mov.b	0(EncPointer), 		EncByte
			inc		EncPointer
			inc		EncCount


			; Get the next byte of the key and start from the beginning if needed
			cmp		KeyCount,			KEY_LENGTH
			jne		DontResetKey
			mov		#KEY,				KeyPointer	;Resets the Key
			mov		#0,					KeyCount

DontResetKey:		; Haven't reached the end of the key
			mov.b	0(KeyPointer),		KeyByte
			inc		KeyPointer
			inc		KeyCount

            ret

;-------------------------------------------------------------------------------
;Subroutine Name: DecryptByte
;Author: Justin Niquette
;Function: All this subroutine does is xor th encrypted byte with the key byte and
;			store the result in memory (then incrementing the RAM Pointer)
;Inputs:	EncByte, KeyByte
;Outputs:	Next decrypted byte stored in RAM
;Registers destroyed: KeyByte
;-------------------------------------------------------------------------------

DecryptByte:
			; xor the bytes and store them in memory
			xor.b	EncByte,			KeyByte
			mov.b	KeyByte,			0(AnswerPointer)
			inc		AnswerPointer
            ret

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
