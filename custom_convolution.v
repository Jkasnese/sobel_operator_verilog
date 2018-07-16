module custom_convolution (
	
	// Inputs required for multicycle custom instructions

	input clk,
	input clk_en,
	input start, // Operation is allowed to start, there is valid data on the input
	input [31:0] dataa,
	input [31:0] datab,


	// Outputs

	output done,	// Lets Nios know that the operation has been completed
	output [31:0] result

);

/*
 [7:0] dataa (0,0)
 [15:8] dataa (0,1)
 [23:16] dataa (0,2)
 [31:24] dataa (1,0)

 [7:0] datab (1,2)
 [15:8] datab (2,0)
 [23:16] datab (2,1)
 [31:24] datab (2,2)

        kernel X    kernel Y
a b c   1 0 -1      1  2  1
d e f   2 0 -2      0  0  0
g h i   1 0 -1     -1 -2 -1

*/

reg [8:0] deltaX;
reg [8:0] deltaY;

reg [8:0] mult2a;
reg [8:0] mult2b;

always @(posedge clk) begin
    // Delta X
    deltaX <= datab[31:24] - datab[15:8] + datab

    // Delta Y

    // Result
end
