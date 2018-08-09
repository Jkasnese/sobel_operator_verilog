module vga_mem(

	input [31:0] image_pix,
	input nios_new_pix,
	input clk,
	input active,

	output img_ready,
	output [3:0] pix_value

);

reg [3:0] pix_color; 
reg [3:0] image_mem [0:4095]; 
reg [12:0] pixel_counter = 13'd0;
reg [12:0] img_counter = 13'd0;
reg ready = 1'b0;


assign img_ready = ready;
assign pix_value = pix_color;

always @ (posedge nios_new_pix) begin
	if(ready == 1'b0) begin 
		if(pixel_counter >= 4095) begin
			ready = 1'b1;
			pixel_counter = 13'd0;
		end 
		else begin
			image_mem[pixel_counter] = image_pix[7:4];
			image_mem[pixel_counter + 1'd1] = image_pix[3:0];
			image_mem[pixel_counter + 2'd2] = image_pix[15:12];
			image_mem[pixel_counter + 2'd3] = image_pix[11:8];
			image_mem[pixel_counter + 3'd4] = image_pix[23:20];
			image_mem[pixel_counter + 3'd5] = image_pix[19:16];
			image_mem[pixel_counter + 3'd6] = image_pix[31:28];
			image_mem[pixel_counter + 3'd7] = image_pix[27:24];
			
			pixel_counter = pixel_counter + 4'd8;
		end
	end
	
end

always @(posedge clk) begin
	if(ready == 1'b1 && active == 1'b1) begin
		pix_color <= image_mem[img_counter]; 
		if(img_counter == 13'd4095) begin
			img_counter <= 13'd0;
		end
		else begin
			img_counter <= img_counter + 1'b1;
		end
	end
end

endmodule