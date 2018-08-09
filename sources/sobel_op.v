module sobel_op(
	
	input dataa, 
	input datab, 

	output result

);


reg [511:0] linha0, linha1, linha2;

reg [6:0] pixels_recebidos;
reg [1:0] linhas_cont; 

always @(*) begin
	pixels_recebidos = pixels_recebidos + 1'b1;
	if(pixels_recebidos == 7'd64) begin
		pixels_recebidos = 7'd0;
		if(linhas_cont < 2'b11) begin
			linhas_cont = linhas_cont + 1'b1;
		end
	end

	
	
end 