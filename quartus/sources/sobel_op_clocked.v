module sobel_op_clocked (
	
	// Inputs required for multicycle custom instructions
    input clock,
    input reset,
    input clock_en,

	input [31:0] dataa,
	input [31:0] datab,

	// Outputs
	output [31:0] result

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

/*
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
assign 18f = {linha1[pixels_recebidos+1][7:0] 1'b0};
assign */

reg [8:0] double_18, double_19, double_1a, double_1b, double_1c, double_1d, double_1e, double_1f;

assign result[3:0] = double_18[8] ? double_18[8:5] : double_18[7:4];
assign result[7:4] = double_19[8] ? double_19[8:5] : double_19[7:4];
assign result[11:8] = double_1a[8] ? double_1a[8:5] : double_1a[7:4];
assign result[15:12] = double_1b[8] ? double_1b[8:5] : double_1b[7:4];
assign result[19:16] = double_1c[8] ? double_1c[8:5] : double_1c[7:4];
assign result[23:20] = double_1d[8] ? double_1d[8:5] : double_1d[7:4];
assign result[27:24] = double_1e[8] ? double_1e[8:5] : double_1e[7:4];
assign result[31:28] = double_1f[8] ? double_1f[8:5] : double_1f[7:4];

always @(posedge clock or negedge reset) begin
    if (reset == 1'b0) begin
        // reset
        double_18 <= 9'd0;
        double_19 <= 9'd0;
        double_1a <= 9'd0;
        double_1b <= 9'd0;
        double_1c <= 9'd0;
        double_1d <= 9'd0;
        double_1e <= 9'd0;
        double_1f <= 9'd0;
    end
    else if (clock_en == 1'b1) begin
        linha2[pixels_recebidos][7:0] = dataa[7:0]; //p1
        linha2[pixels_recebidos+1][7:0] = dataa[15:8]; // p1, p2
        linha2[pixels_recebidos+2][7:0] = dataa[23:16]; // p1
        linha2[pixels_recebidos+3][7:0] = dataa[31:24]; // p2.

        linha2[pixels_recebidos+4][7:0] = datab[7:0];
        linha2[pixels_recebidos+5][7:0] = datab[15:8];
        linha2[pixels_recebidos+6][7:0] = datab[23:16];
        linha2[pixels_recebidos+7][7:0] = datab[31:24];

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
            /*18*/ double_18   = /*2h'28*/ dataa[7:0]   - /*2f'19*/ linha1[pixels_recebidos+1][7:0] - /*2c*/ linha0[pixels_recebidos+1][7:0] - /*2b*/ linha0[pixels_recebidos-1][7:0];
            /*19*/ double_19   = /*2h'29*/ dataa[15:8]  + /*2g'28*/ dataa[7:0] - /*2f'1A*/ linha1[pixels_recebidos+2][7:0] + /*2d'18*/ linha1[pixels_recebidos][7:0] - /*2c'0A*/ linha0[pixels_recebidos+2][7:0] - /*2b'09*/ linha0[pixels_recebidos+1][7:0];
            /*1A*/ double_1a   = /*2h'2A*/ dataa[23:16]  + /*2g'29*/ dataa[15:8] - /*2f'1B*/ linha1[pixels_recebidos+3][7:0] + /*2d'19*/ linha1[pixels_recebidos+1][7:0] - /*2c'0B*/ linha0[pixels_recebidos+3][7:0] - /*2b'0A*/ linha0[pixels_recebidos+2][7:0];
            /*1B*/ double_1b   = /*2h'2B*/ dataa[31:24]  + /*2g'2A*/ dataa[23:16] - /*2f'1C*/ linha1[pixels_recebidos+4][7:0] + /*2d'1A*/ linha1[pixels_recebidos+2][7:0] - /*2c'0C*/ linha0[pixels_recebidos+4][7:0] - /*2b'0B*/ linha0[pixels_recebidos+3][7:0];

            /*1C*/ double_1c   = /*2h'2C*/ datab[7:0]  + /*2g'2B*/ dataa[31:24] - /*2f'1D*/ linha1[pixels_recebidos+5][7:0] + /*2d'1B*/ linha1[pixels_recebidos+3][7:0] - /*2c'0D*/ linha0[pixels_recebidos+5][7:0] - /*2b'0C*/ linha0[pixels_recebidos+4][7:0];
            /*1D*/ double_1d   = /*2h'2D*/ datab[15:8]  + /*2g'2C*/ datab[7:0] - /*2f'1E*/ linha1[pixels_recebidos+6][7:0] + /*2d'1C*/ linha1[pixels_recebidos+4][7:0] - /*2c'0E*/ linha0[pixels_recebidos+6][7:0] - /*2b'0D*/ linha0[pixels_recebidos+5][7:0];
            /*1E*/ double_1e   = /*2h'2E*/ datab[23:16]  + /*2g'2D*/ datab[15:8] - /*2f'1F*/ linha1[pixels_recebidos+7][7:0] + /*2d'1D*/ linha1[pixels_recebidos+5][7:0] - /*2c'0F*/ linha0[pixels_recebidos+7][7:0] - /*2b'0E*/ linha0[pixels_recebidos+6][7:0];
            /*1F*/ double_1f = /*2h'2F*/ datab[31:24]  + /*2g'2E*/ datab[23:16] - /*2f'1G*/ linha1[pixels_recebidos+8][7:0] + /*2e'1D*/ linha1[pixels_recebidos+6][7:0] - /*2c'0G*/ linha0[pixels_recebidos+8][7:0] - /*2b'0F*/ linha0[pixels_recebidos+7][7:0];
            
        end else if (pixels_recebidos == 7'd56) begin // Borda última coluna
            /*18*/ double_18   = /*2h'28*/ dataa[7:0]  + /*2g'27*/ linha2[pixels_recebidos-1][7:0] - /*2f'19*/ linha1[pixels_recebidos+1][7:0] + /*2d'17*/ linha1[pixels_recebidos-1][7:0] - /*2c*/ linha0[pixels_recebidos+1][7:0] - /*2b*/ linha0[pixels_recebidos-1][7:0];
            /*19*/ double_19   = /*2h'29*/ dataa[15:8]  + /*2g'28*/ dataa[7:0] - /*2f'1A*/ linha1[pixels_recebidos+2][7:0] + /*2d'18*/ linha1[pixels_recebidos][7:0] - /*2c'0A*/ linha0[pixels_recebidos+2][7:0] - /*2b'09*/ linha0[pixels_recebidos+1][7:0];
            /*1A*/ double_1a   = /*2h'2A*/ dataa[23:16]  + /*2g'29*/ dataa[15:8] - /*2f'1B*/ linha1[pixels_recebidos+3][7:0] + /*2d'19*/ linha1[pixels_recebidos+1][7:0] - /*2c'0B*/ linha0[pixels_recebidos+3][7:0] - /*2b'0A*/ linha0[pixels_recebidos+2][7:0];
            /*1B*/ double_1b   = /*2h'2B*/ dataa[31:24]  + /*2g'2A*/ dataa[23:16] - /*2f'1C*/ linha1[pixels_recebidos+4][7:0] + /*2d'1A*/ linha1[pixels_recebidos+2][7:0] - /*2c'0C*/ linha0[pixels_recebidos+4][7:0] - /*2b'0B*/ linha0[pixels_recebidos+3][7:0];

            /*1C*/ double_1c   = /*2h'2C*/ datab[7:0]  + /*2g'2B*/ dataa[31:24] - /*2f'1D*/ linha1[pixels_recebidos+5][7:0] + /*2d'1B*/ linha1[pixels_recebidos+3][7:0] - /*2c'0D*/ linha0[pixels_recebidos+5][7:0] - /*2b'0C*/ linha0[pixels_recebidos+4][7:0];
            /*1D*/ double_1d   = /*2h'2D*/ datab[15:8]  + /*2g'2C*/ datab[7:0] - /*2f'1E*/ linha1[pixels_recebidos+6][7:0] + /*2d'1C*/ linha1[pixels_recebidos+4][7:0] - /*2c'0E*/ linha0[pixels_recebidos+6][7:0] - /*2b'0D*/ linha0[pixels_recebidos+5][7:0];
            /*1E*/ double_1e   = /*2h'2E*/ datab[23:16]  + /*2g'2D*/ datab[15:8] - /*2f'1F*/ linha1[pixels_recebidos+7][7:0] + /*2d'1D*/ linha1[pixels_recebidos+5][7:0] - /*2c'0F*/ linha0[pixels_recebidos+7][7:0] - /*2b'0E*/ linha0[pixels_recebidos+6][7:0];
            /*1F*/ double_1f = /*2h'2F*/ datab[31:24]  + /*2g'2E*/ datab[23:16] + /*2e'1D*/ linha1[pixels_recebidos+6][7:0] - /*2b'0F*/ linha0[pixels_recebidos+7][7:0];        

        end else begin // Não é borda
            // pixels_recebidos aponta para X8
            /*18*/ double_18   = /*2h'28*/ dataa[7:0]  + /*2g'27*/ linha2[pixels_recebidos-1][7:0] - /*2f'19*/ linha1[pixels_recebidos+1][7:0] + /*2d'17*/ linha1[pixels_recebidos-1][7:0] - /*2c*/ linha0[pixels_recebidos+1][7:0] - /*2b*/ linha0[pixels_recebidos-1][7:0];
            /*19*/ double_19   = /*2h'29*/ dataa[15:8]  + /*2g'28*/ dataa[7:0] - /*2f'1A*/ linha1[pixels_recebidos+2][7:0] + /*2d'18*/ linha1[pixels_recebidos][7:0] - /*2c'0A*/ linha0[pixels_recebidos+2][7:0] - /*2b'09*/ linha0[pixels_recebidos+1][7:0];
            /*1A*/ double_1a   = /*2h'2A*/ dataa[23:16]  + /*2g'29*/ dataa[15:8] - /*2f'1B*/ linha1[pixels_recebidos+3][7:0] + /*2d'19*/ linha1[pixels_recebidos+1][7:0] - /*2c'0B*/ linha0[pixels_recebidos+3][7:0] - /*2b'0A*/ linha0[pixels_recebidos+2][7:0];
            /*1B*/ double_1b   = /*2h'2B*/ dataa[31:24]  + /*2g'2A*/ dataa[23:16] - /*2f'1C*/ linha1[pixels_recebidos+4][7:0] + /*2d'1A*/ linha1[pixels_recebidos+2][7:0] - /*2c'0C*/ linha0[pixels_recebidos+4][7:0] - /*2b'0B*/ linha0[pixels_recebidos+3][7:0];

            /*1C*/ double_1c   = /*2h'2C*/ datab[7:0]  + /*2g'2B*/ dataa[31:24] - /*2f'1D*/ linha1[pixels_recebidos+5][7:0] + /*2d'1B*/ linha1[pixels_recebidos+3][7:0] - /*2c'0D*/ linha0[pixels_recebidos+5][7:0] - /*2b'0C*/ linha0[pixels_recebidos+4][7:0];
            /*1D*/ double_1d   = /*2h'2D*/ datab[15:8]  + /*2g'2C*/ datab[7:0] - /*2f'1E*/ linha1[pixels_recebidos+6][7:0] + /*2d'1C*/ linha1[pixels_recebidos+4][7:0] - /*2c'0E*/ linha0[pixels_recebidos+6][7:0] - /*2b'0D*/ linha0[pixels_recebidos+5][7:0];
            /*1E*/ double_1e   = /*2h'2E*/ datab[23:16]  + /*2g'2D*/ datab[15:8] - /*2f'1F*/ linha1[pixels_recebidos+7][7:0] + /*2d'1D*/ linha1[pixels_recebidos+5][7:0] - /*2c'0F*/ linha0[pixels_recebidos+7][7:0] - /*2b'0E*/ linha0[pixels_recebidos+6][7:0];
            /*1F*/ double_1f = /*2h'2F*/ datab[31:24]  + /*2g'2E*/ datab[23:16] - /*2f'1G*/ linha1[pixels_recebidos+8][7:0] + /*2e'1D*/ linha1[pixels_recebidos+6][7:0] - /*2c'0G*/ linha0[pixels_recebidos+8][7:0] - /*2b'0F*/ linha0[pixels_recebidos+7][7:0];
        end

        // Contando e organizando pixels recebidos
        pixels_recebidos = pixels_recebidos + 4'b1000;
        if (pixels_recebidos == 7'd64) begin
            pixels_recebidos = 7'd0;
        end

    end
end

generate
    genvar i;
    for (i = 0; i < tamanho_linha_imagem - 1; i = i + 1)
    begin:identifier
        always @(posedge clock or negedge reset) begin
            if (reset == 1'b0) begin
                // reset
                linha0[i][7:0] <= 8'd0;
                linha1[i][7:0] <= 8'd0;
            end
            else if (clock_en == 1'b1 && pixels_recebidos == 7'd64) begin
                linha0[i][7:0] = linha1[i][7:0];
                linha1[i][7:0] = linha2[i][7:0];
            end
        end
    end
endgenerate

endmodule
