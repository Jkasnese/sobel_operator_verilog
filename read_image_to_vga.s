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


movia r20, 0x9040 # VGA location

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

# Receive row size
call __read_byte
mov r7, r10 # Row size stored in r7


# Calculate initial vga address on the middle of the screen
srli r5, r7, 0x1 # Half image length

# Screen row size
movia r4, 0x280 #640

# Initial image address:
sub r5, r4, r5

# Next line address will be + r11:
sub r11, r4, r7

# Loops until received whole message/image. Stores it on VGA
movia r1, 0x0 # r1 receives counter to count bytes received.
movia r2, 0x0 # r2 receives counts how many bytes have been received in current line

read_image:

bge r1, r8, img_received

call __read_byte

# Get 4 MSBs pixel data
andi r10, r10, 0xF0
slli r10, r10, 0x10

# Add address
or r10, r10, r5

# Store 
stw r10, 0x0(r20)

addi r5, r5, 0x1
addi r1, r1, 0x1
addi r2, r2, 0x1

bltu r2, r7, read_image

add r5, r5, r11
mov r2, r0

br read_image

img_received:

mov r30, r5




