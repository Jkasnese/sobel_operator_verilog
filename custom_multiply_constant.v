module custom_multiply (
	
	// Inputs required for multicycle custom instructions
	input [31:0] dataa,
	input [31:0] datab,

	// Outputs
	output reg [31:0] result
);


reg [511:0] linha0;
reg [511:0] linha1;
reg [511:0] linha2;

reg [6:0] pixels_recebidos;

// p1 = a[7:0]
// p2 = a[15:8]
// ultimo p = b[31:24]

always @(*) begin
    // Store pixels
    linha2[(pixels_recebidos*8)+7 -: 8] = dataa[7:0]; //p1
    linha2[(pixels_recebidos*8)+15 -: 8] = dataa[15:8]; // p1, p2
    linha2[(pixels_recebidos*8)+23 -: 8] = dataa[23:16]; // p1
    linha2[(pixels_recebidos*8)+31 -: 8] = dataa[31:24]; // p2.

    linha2[(pixels_recebidos*8)+39 -: 8] = datab[7:0];
    linha2[(pixels_recebidos*8)+47 -: 8] = datab[15:8];
    linha2[(pixels_recebidos*8)+55 -: 8] = datab[23:16];
    linha2[(pixels_recebidos*8)+63 -: 8] = datab[31:24];


    // Operando
    // Borda primeira coluna
    if (pixels_recebidos == 7'd0) begin
        
    end else if (pixels_recebidos == 7'd56) begin // Borda última coluna
        
    end else begin // Não é borda
       result[3:0] = /*2g*/ (dataa[7:0] << 1)  + /*2h*/ (linha2[(pixels_recebidos*8)-1 -: 8] << 1) - /*2f*/ (linha1[(pixels_recebidos*8)+15 -: 8] << 1) + /*2d*/ (linha1[(pixels_recebidos*8)-1 -: 8] << 1) - /*2c*/ (linha0[(pixels_recebidos*8)+15 -: 8] << 1) - /*2b*/ (linha0[(pixels_recebidos*8)+7 -: 8] << 1);
    end


    // Contando e organizando pixels recebidos
    pixels_recebidos = pixels_recebidos + 4'b1000;
    if (pixels_recebidos == 7'd64) begin
        pixels_recebidos = 7'd0;
        linha0 = linha1;
        linha1 = linha2;
    end
end

reg [3:0] p1, p2, p3, p4, p5, p6, p7, p8;

/*
00 01 02 03 04 05 06 07 08 09 
10 11 12 13 14 15 16 17 18 19
20 21 22 23 24 25 26 27 28 29

-2b -2c +2d -2f +2g +2h
        kernel X    kernel Y
a b c   1 0 -1     -1 -2 -1
d e f   2 0 -2      0  0  0
g h i   1 0 -1      1  2  1



*/

assign result[7:0] =  // primeiro pixel


endmodule
