module sobel_op (
	
	// Inputs required for multicycle custom instructions
	input [31:0] dataa,
	input [31:0] datab,

	// Outputs
	output reg [31:0] result

    // TODO: Depois que termianr de substituir os valores, criar um novo módulo igual com sinal de clk e clk_en.

);

localparam tamanho_linha_imagem = 64;

reg [7:0] linha0 [0:tamanho_linha_imagem - 1];
reg [7:0] linha1 [0:tamanho_linha_imagem - 1];
reg [7:0] linha2 [0:tamanho_linha_imagem - 1];

reg [6:0] pixels_recebidos;

// p1 = a[7:0]
// p2 = a[15:8]
// ultimo p = b[31:24]

wire [8:0] 18h, 18g, 18f, 18e, 18c, 18b; 
wire [8:0] 19h, 19g, 19f, 19e, 19c, 19b;
wire [8:0] 1Ah, 1Ag, 1Af, 1Ae, 1Ac, 1Ab;
wire [8:0] 1Bh, 1Bg, 1Bf, 1Be, 1Bc, 1Bb;

wire [8:0] 1Ch, 1Cg, 1Cf, 1Ce, 1Cc, 1Cb;
wire [8:0] 1Dh, 1Dg, 1Df, 1De, 1Dc, 1Db;
wire [8:0] 1Eh, 1Eg, 1Ef, 1Ee, 1Ec, 1Eb;
wire [8:0] 1Fh, 1Fg, 1Ff, 1Fe, 1Fc, 1Fb;

assign 18h = {dataa[7:0], 1'b0};
assign 18g = {linha2[pixels_recebidos-1][7:0], 1'b0};
assign 18f = {linha1[(pixels_recebidos+1][7:0] << 1, 1'b0};

        /*18*/ result[3:0]   = (/*2h'28*/ 18h  + /*2g'27*/ 18g - /*2f'19*/ 18f + /*2d'17*/ (linha1[pixels_recebidos-1][7:0] << 1) - /*2c*/ (linha0[pixels_recebidos+1][7:0] << 1) - /*2b*/ (linha0[pixels_recebidos-1][7:0] << 1))[7:4];
        /*19*/ result[7:4]   = (/*2h'29*/ (dataa[15:8] << 1)  + /*2g'28*/ 18h - /*2f'1A*/ (linha1[(pixels_recebidos+2][7:0] << 1) + /*2d'18*/ (linha1[pixels_recebidos][7:0] << 1) - /*2c'0A*/ (linha0[pixels_recebidos+2][7:0] << 1) - /*2b'09*/ (linha0[pixels_recebidos+1][7:0] << 1))[7:4];
        /*1A*/ result[11:8]  = (/*2h'2A*/ (dataa[23:16] << 1)  + /*2g'29*/ (dataa[15:8] << 1) - /*2f'1B*/ (linha1[(pixels_recebidos+3][7:0] << 1) + /*2d'19*/ (linha1[pixels_recebidos+1][7:0] << 1) - /*2c'0B*/ (linha0[pixels_recebidos+3][7:0] << 1) - /*2b'0A*/ (linha0[pixels_recebidos+2][7:0] << 1))[7:4];
        /*1B*/ result[15:12] = (/*2h'2B*/ (dataa[31:24] << 1)  + /*2g'2A*/ (dataa[23:16] << 1) - /*2f'1C*/ (linha1[(pixels_recebidos+4][7:0] << 1) + /*2d'1A*/ (linha1[pixels_recebidos+2][7:0] << 1) - /*2c'0C*/ (linha0[pixels_recebidos+4][7:0] << 1) - /*2b'0B*/ (linha0[pixels_recebidos+3][7:0] << 1))[7:4];

        /*1C*/ result[19:16] = (/*2h'2C*/ (datab[7:0] << 1)  + /*2g'2B*/ (dataa[31:24] << 1) - /*2f'1D*/ (linha1[(pixels_recebidos+5][7:0] << 1) + /*2d'1B*/ (linha1[pixels_recebidos+3][7:0] << 1) - /*2c'0D*/ (linha0[pixels_recebidos+5][7:0] << 1) - /*2b'0C*/ (linha0[pixels_recebidos+4][7:0] << 1))[7:4];
        /*1D*/ result[23:20] = (/*2h'2D*/ (datab[15:8] << 1)  + /*2g'2C*/ (datab[7:0] << 1) - /*2f'1E*/ (linha1[(pixels_recebidos+6][7:0] << 1) + /*2d'1C*/ (linha1[pixels_recebidos+4][7:0] << 1) - /*2c'0E*/ (linha0[pixels_recebidos+6][7:0] << 1) - /*2b'0D*/ (linha0[pixels_recebidos+5][7:0] << 1))[7:4];
        /*1E*/ result[27:24] = (/*2h'2E*/ (datab[23:16] << 1)  + /*2g'2D*/ (datab[15:8] << 1) - /*2f'1F*/ (linha1[(pixels_recebidos+7][7:0] << 1) + /*2d'1D*/ (linha1[pixels_recebidos+5][7:0] << 1) - /*2c'0F*/ (linha0[pixels_recebidos+7][7:0] << 1) - /*2b'0E*/ (linha0[pixels_recebidos+6][7:0] << 1))[7:4];
        /*1F*/ result[31:28] = (/*2h'2F*/ (datab[31:24] << 1)  + /*2g'2E*/ (datab[23:16] << 1) - /*2f'1G*/ (linha1[(pixels_recebidos+8][7:0] << 1) + /*2e'1D*/ (linha1[pixels_recebidos+6][7:0] << 1) - /*2c'0G*/ (linha0[pixels_recebidos+8][7:0] << 1) - /*2b'0F*/ (linha0[pixels_recebidos+7][7:0] << 1))[7:4];

always @(*) begin
    // Store pixels
    linha2[pixels_recebidos][7:0] = dataa[7:0]; //p1
    linha2[(pixels_recebidos+1][7:0] = dataa[15:8]; // p1, p2
    linha2[(pixels_recebidos+2][7:0] = dataa[23:16]; // p1
    linha2[(pixels_recebidos+3][7:0] = dataa[31:24]; // p2.

    linha2[(pixels_recebidos+4][7:0] = datab[7:0];
    linha2[(pixels_recebidos+5][7:0] = datab[15:8];
    linha2[(pixels_recebidos+6][7:0] = datab[23:16];
    linha2[(pixels_recebidos+7][7:0] = datab[31:24];

    /*
    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
    10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F
    20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F

            kernel X    kernel Y
    a b c   1 0 -1     -1 -2 -1
    d e f   2 0 -2      0  0  0
    g h i   1 0 -1      1  2  1

    -2b -2c +2d -2f +2g +2h*/

    // Operando
    // Borda primeira coluna
    if (pixels_recebidos == 7'd0) begin
        /*18*/ result[3:0]   = (/*2h'28*/ 18h   - /*2f'19*/ 18f - /*2c*/ (linha0[pixels_recebidos+1][7:0] << 1) - /*2b*/ (linha0[pixels_recebidos-1][7:0] << 1))[7:4];
        /*19*/ result[7:4]   = (/*2h'29*/ (dataa[15:8] << 1)  + /*2g'28*/ 18h - /*2f'1A*/ (linha1[(pixels_recebidos+2][7:0] << 1) + /*2d'18*/ (linha1[pixels_recebidos][7:0] << 1) - /*2c'0A*/ (linha0[pixels_recebidos+2][7:0] << 1) - /*2b'09*/ (linha0[pixels_recebidos+1][7:0] << 1))[7:4];
        /*1A*/ result[11:8]  = (/*2h'2A*/ (dataa[23:16] << 1)  + /*2g'29*/ (dataa[15:8] << 1) - /*2f'1B*/ (linha1[(pixels_recebidos+3][7:0] << 1) + /*2d'19*/ (linha1[pixels_recebidos+1][7:0] << 1) - /*2c'0B*/ (linha0[pixels_recebidos+3][7:0] << 1) - /*2b'0A*/ (linha0[pixels_recebidos+2][7:0] << 1))[7:4];
        /*1B*/ result[15:12] = (/*2h'2B*/ (dataa[31:24] << 1)  + /*2g'2A*/ (dataa[23:16] << 1) - /*2f'1C*/ (linha1[(pixels_recebidos+4][7:0] << 1) + /*2d'1A*/ (linha1[pixels_recebidos+2][7:0] << 1) - /*2c'0C*/ (linha0[pixels_recebidos+4][7:0] << 1) - /*2b'0B*/ (linha0[pixels_recebidos+3][7:0] << 1))[7:4];

        /*1C*/ result[19:16] = (/*2h'2C*/ (datab[7:0] << 1)  + /*2g'2B*/ (dataa[31:24] << 1) - /*2f'1D*/ (linha1[(pixels_recebidos+5][7:0] << 1) + /*2d'1B*/ (linha1[pixels_recebidos+3][7:0] << 1) - /*2c'0D*/ (linha0[pixels_recebidos+5][7:0] << 1) - /*2b'0C*/ (linha0[pixels_recebidos+4][7:0] << 1))[7:4];
        /*1D*/ result[23:20] = (/*2h'2D*/ (datab[15:8] << 1)  + /*2g'2C*/ (datab[7:0] << 1) - /*2f'1E*/ (linha1[(pixels_recebidos+6][7:0] << 1) + /*2d'1C*/ (linha1[pixels_recebidos+4][7:0] << 1) - /*2c'0E*/ (linha0[pixels_recebidos+6][7:0] << 1) - /*2b'0D*/ (linha0[pixels_recebidos+5][7:0] << 1))[7:4];
        /*1E*/ result[27:24] = (/*2h'2E*/ (datab[23:16] << 1)  + /*2g'2D*/ (datab[15:8] << 1) - /*2f'1F*/ (linha1[(pixels_recebidos+7][7:0] << 1) + /*2d'1D*/ (linha1[pixels_recebidos+5][7:0] << 1) - /*2c'0F*/ (linha0[pixels_recebidos+7][7:0] << 1) - /*2b'0E*/ (linha0[pixels_recebidos+6][7:0] << 1))[7:4];
        /*1F*/ result[31:28] = (/*2h'2F*/ (datab[31:24] << 1)  + /*2g'2E*/ (datab[23:16] << 1) - /*2f'1G*/ (linha1[(pixels_recebidos+8][7:0] << 1) + /*2e'1D*/ (linha1[pixels_recebidos+6][7:0] << 1) - /*2c'0G*/ (linha0[pixels_recebidos+8][7:0] << 1) - /*2b'0F*/ (linha0[pixels_recebidos+7][7:0] << 1))[7:4];
        
    end else if (pixels_recebidos == 7'd56) begin // Borda última coluna
        /*18*/ result[3:0]   = (/*2h'28*/ 18h  + /*2g'27*/ 18g - /*2f'19*/ 18f + /*2d'17*/ (linha1[pixels_recebidos-1][7:0] << 1) - /*2c*/ (linha0[pixels_recebidos+1][7:0] << 1) - /*2b*/ (linha0[pixels_recebidos-1][7:0] << 1))[7:4];
        /*19*/ result[7:4]   = (/*2h'29*/ (dataa[15:8] << 1)  + /*2g'28*/ 18h - /*2f'1A*/ (linha1[(pixels_recebidos+2][7:0] << 1) + /*2d'18*/ (linha1[pixels_recebidos][7:0] << 1) - /*2c'0A*/ (linha0[pixels_recebidos+2][7:0] << 1) - /*2b'09*/ (linha0[pixels_recebidos+1][7:0] << 1))[7:4];
        /*1A*/ result[11:8]  = (/*2h'2A*/ (dataa[23:16] << 1)  + /*2g'29*/ (dataa[15:8] << 1) - /*2f'1B*/ (linha1[(pixels_recebidos+3][7:0] << 1) + /*2d'19*/ (linha1[pixels_recebidos+1][7:0] << 1) - /*2c'0B*/ (linha0[pixels_recebidos+3][7:0] << 1) - /*2b'0A*/ (linha0[pixels_recebidos+2][7:0] << 1))[7:4];
        /*1B*/ result[15:12] = (/*2h'2B*/ (dataa[31:24] << 1)  + /*2g'2A*/ (dataa[23:16] << 1) - /*2f'1C*/ (linha1[(pixels_recebidos+4][7:0] << 1) + /*2d'1A*/ (linha1[pixels_recebidos+2][7:0] << 1) - /*2c'0C*/ (linha0[pixels_recebidos+4][7:0] << 1) - /*2b'0B*/ (linha0[pixels_recebidos+3][7:0] << 1))[7:4];

        /*1C*/ result[19:16] = (/*2h'2C*/ (datab[7:0] << 1)  + /*2g'2B*/ (dataa[31:24] << 1) - /*2f'1D*/ (linha1[(pixels_recebidos+5][7:0] << 1) + /*2d'1B*/ (linha1[pixels_recebidos+3][7:0] << 1) - /*2c'0D*/ (linha0[pixels_recebidos+5][7:0] << 1) - /*2b'0C*/ (linha0[pixels_recebidos+4][7:0] << 1))[7:4];
        /*1D*/ result[23:20] = (/*2h'2D*/ (datab[15:8] << 1)  + /*2g'2C*/ (datab[7:0] << 1) - /*2f'1E*/ (linha1[(pixels_recebidos+6][7:0] << 1) + /*2d'1C*/ (linha1[pixels_recebidos+4][7:0] << 1) - /*2c'0E*/ (linha0[pixels_recebidos+6][7:0] << 1) - /*2b'0D*/ (linha0[pixels_recebidos+5][7:0] << 1))[7:4];
        /*1E*/ result[27:24] = (/*2h'2E*/ (datab[23:16] << 1)  + /*2g'2D*/ (datab[15:8] << 1) - /*2f'1F*/ (linha1[(pixels_recebidos+7][7:0] << 1) + /*2d'1D*/ (linha1[pixels_recebidos+5][7:0] << 1) - /*2c'0F*/ (linha0[pixels_recebidos+7][7:0] << 1) - /*2b'0E*/ (linha0[pixels_recebidos+6][7:0] << 1))[7:4];
        /*1F*/ result[31:28] = (/*2h'2F*/ (datab[31:24] << 1)  + /*2g'2E*/ (datab[23:16] << 1) + /*2e'1D*/ (linha1[pixels_recebidos+6][7:0] << 1) - /*2b'0F*/ (linha0[pixels_recebidos+7][7:0] << 1))[7:4];        
    end else begin // Não é borda
        // pixels_recebidos aponta para X8
        /*18*/ result[3:0]   = (/*2h'28*/ 18h  + /*2g'27*/ 18g - /*2f'19*/ 18f + /*2d'17*/ (linha1[pixels_recebidos-1][7:0] << 1) - /*2c*/ (linha0[pixels_recebidos+1][7:0] << 1) - /*2b*/ (linha0[pixels_recebidos-1][7:0] << 1))[7:4];
        /*19*/ result[7:4]   = (/*2h'29*/ (dataa[15:8] << 1)  + /*2g'28*/ 18h - /*2f'1A*/ (linha1[(pixels_recebidos+2][7:0] << 1) + /*2d'18*/ (linha1[pixels_recebidos][7:0] << 1) - /*2c'0A*/ (linha0[pixels_recebidos+2][7:0] << 1) - /*2b'09*/ (linha0[pixels_recebidos+1][7:0] << 1))[7:4];
        /*1A*/ result[11:8]  = (/*2h'2A*/ (dataa[23:16] << 1)  + /*2g'29*/ (dataa[15:8] << 1) - /*2f'1B*/ (linha1[(pixels_recebidos+3][7:0] << 1) + /*2d'19*/ (linha1[pixels_recebidos+1][7:0] << 1) - /*2c'0B*/ (linha0[pixels_recebidos+3][7:0] << 1) - /*2b'0A*/ (linha0[pixels_recebidos+2][7:0] << 1))[7:4];
        /*1B*/ result[15:12] = (/*2h'2B*/ (dataa[31:24] << 1)  + /*2g'2A*/ (dataa[23:16] << 1) - /*2f'1C*/ (linha1[(pixels_recebidos+4][7:0] << 1) + /*2d'1A*/ (linha1[pixels_recebidos+2][7:0] << 1) - /*2c'0C*/ (linha0[pixels_recebidos+4][7:0] << 1) - /*2b'0B*/ (linha0[pixels_recebidos+3][7:0] << 1))[7:4];

        /*1C*/ result[19:16] = (/*2h'2C*/ (datab[7:0] << 1)  + /*2g'2B*/ (dataa[31:24] << 1) - /*2f'1D*/ (linha1[(pixels_recebidos+5][7:0] << 1) + /*2d'1B*/ (linha1[pixels_recebidos+3][7:0] << 1) - /*2c'0D*/ (linha0[pixels_recebidos+5][7:0] << 1) - /*2b'0C*/ (linha0[pixels_recebidos+4][7:0] << 1))[7:4];
        /*1D*/ result[23:20] = (/*2h'2D*/ (datab[15:8] << 1)  + /*2g'2C*/ (datab[7:0] << 1) - /*2f'1E*/ (linha1[(pixels_recebidos+6][7:0] << 1) + /*2d'1C*/ (linha1[pixels_recebidos+4][7:0] << 1) - /*2c'0E*/ (linha0[pixels_recebidos+6][7:0] << 1) - /*2b'0D*/ (linha0[pixels_recebidos+5][7:0] << 1))[7:4];
        /*1E*/ result[27:24] = (/*2h'2E*/ (datab[23:16] << 1)  + /*2g'2D*/ (datab[15:8] << 1) - /*2f'1F*/ (linha1[(pixels_recebidos+7][7:0] << 1) + /*2d'1D*/ (linha1[pixels_recebidos+5][7:0] << 1) - /*2c'0F*/ (linha0[pixels_recebidos+7][7:0] << 1) - /*2b'0E*/ (linha0[pixels_recebidos+6][7:0] << 1))[7:4];
        /*1F*/ result[31:28] = (/*2h'2F*/ (datab[31:24] << 1)  + /*2g'2E*/ (datab[23:16] << 1) - /*2f'1G*/ (linha1[(pixels_recebidos+8][7:0] << 1) + /*2e'1D*/ (linha1[pixels_recebidos+6][7:0] << 1) - /*2c'0G*/ (linha0[pixels_recebidos+8][7:0] << 1) - /*2b'0F*/ (linha0[pixels_recebidos+7][7:0] << 1))[7:4];
    end


    // Contando e organizando pixels recebidos
    pixels_recebidos = pixels_recebidos + 4'b1000;
    if (pixels_recebidos == 7'd64) begin
        pixels_recebidos = 7'd0;
        linha0 = linha1;
        linha1 = linha2;
    end
end

endmodule
