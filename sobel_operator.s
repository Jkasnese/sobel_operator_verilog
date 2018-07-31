.data

.text

# Reads byte from RS232 and stores it into r10
__read_byte:
	wait_data:
	ldb r16, 0x0(r18)
	bgt r16, r0, read
	br wait_data

	read:
	ldbu r10, 0x0(r15) # Reads byte
	movia r11, 0x1 
	stb r11, 0x0(r18) #r18  Signals that byte was read.
	stb r0, 0x0(r18) # If there is no new data, it means you read the last data and the fpga already knows.
	ret

# Reads 4 bytes from RS232 and stores it into r10
__read_block:
	call __read_byte
	slli r9, r10, 0x8
	call __read_byte
	or r9, r9, r10
	slli r9, r9, 0x8
	call __read_byte
	or r9, r9, r10
	slli r9, r9, 0x8
	call __read_byte
	or r10, r9, r10

.global main 

main:

## ADDRESSES CONFIGURATIONS
# RS232 config
movia r15, 0x9070 # Memory location of the new byte
movia r18, 0x9050 # Memory location of the data read sign.
movia r8, 0x9060 # Address of RS232 configurations on FPGA

# Coprocessor location
movia r20, 0x0000 # Coprocessor's data address
movia r21, 0x0000 # Co processor's control address

# On-chip-memory location
movia r25, 0x000 # Memory location

#
#    Registrador de configurações:
#
#    B0 (LSB) - Presença de paridade: (1 sim/ 0 não) - Use parity: (1 yes/ 0 no)
#    B1 - Paridade: (0 par/1impar) - Parity: (0 even, 1 0dd)
#    B2e3 - Dados: (11 5, 10 6, 01 7, 00 8) - Data bits per package
#    B4 - Stopbits: um 0, dois 1 - one 0, two 1
#    B5 - Handshake: (1sim/0não) - 1y/0n
#    B6e7 - Velocidade clock: (0 9600/ 1 19200 / 2 57600 / 3 115200 - Baudrate
#

movia r1, 0xC0 # Initial Configurations of RS232. See table above. 
stb r1, 0x0(r8)

# Receive size of the message. First receive most significative byte, then less significative byte.
# Size of message is then stored in r8.
call __read_byte
mov r8, r10
slli r8, r8, 0x8
call __read_byte
or r8, r8, r10
slli r8, r8, 0x8
call __read_byte
or r8, r8, r10

# Loops until received whole message/image. Stores it on Nios memory and on co-processor memory (wrong)
movia r1, 0x0 # r1 receives counter to count bytes received.

read_image:

bge r1, r8, img_received

call __read_block
add r2, r1, r25 # Calculating memory pointer
stw r10, 0x0(r2) # Storing on memory
#stw r10, 0x0(r20) # Storing on coprocessor
addi r1, r1, 0x4 # Read 4 bytes

br read_image

img_received:

stb r21, 0x1 # Instrução não existe




