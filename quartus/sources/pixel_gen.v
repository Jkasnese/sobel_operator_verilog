module pixel_gen(
	
	input clk,
	input active,
	output [3:0] pixel
);


reg [3:0] pxl_color = 4'b1111;
assign pixel = pxl_color;
reg [6:0] line_counter = 7'd0;
reg [6:0] pixel_counter = 7'd0;
reg [12:0] total_counter = 13'd0;

always @(posedge clk) begin
	
	/**
	if(active == 1'b1) begin		
		total_counter <= total_counter + 1'b1;
		if(total_counter == 13'd2047) begin
			pxl_color <= 4'b0000;
		end
		if(total_counter == 13'd4095) begin
			pxl_color <= 4'b1111;
			total_counter <= 13'd0;
		end
	end
	**/
	
	
	if(active == 1'b1) begin
	
		if(pixel_counter == 7'd63) begin 
			pixel_counter <= 7'd0;
			line_counter <= line_counter + 1'b1;
			if(line_counter == 7'd3) begin
				if(pxl_color == 4'b0000) begin
					pxl_color <= 4'b1111;
				end
				else begin
					pxl_color <= pxl_color - 1'b1;
				end
				line_counter <= 7'd0;
			end
		end
		else begin
			pixel_counter <= pixel_counter + 1'b1;
		end
 end
end	
endmodule