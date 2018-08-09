module vga_controller(

	input clk,
	input reset,
//	input [3:0] color,
	input [31:0] img_pix,
	input nios_new_pix,
 
	output [3:0] r,
	output [3:0] g,
	output [3:0] b,
	output h_sync,
	output v_sync

);


wire clk_vga;
wire active_vid;
wire [3:0] reg_color;
wire img_ready;

reg [3:0] reg_R, reg_G, reg_B;

assign r = reg_R;
assign g = reg_G;
assign b = reg_B;


clk_divisor clk_div(

	.clk_50(clk),

	.clk_25(clk_vga)
);

sync_generator sync(

	.clk(clk_vga),
	.reset(reset),

	.h_sync(h_sync),
	.v_sync(v_sync),
	.active_video(active_vid)

);

	vga_mem mem_vga(
		.image_pix(img_pix),
		.nios_new_pix(nios_new_pix),
		.clk(clk_vga),
		.active(active_vid),

		.img_ready(img_ready),
		.pix_value(reg_color)
	);


/** pixel_gen pix(
	
	.clk(clk_vga),
	.active(active_vid),
	
	.pixel(reg_color)

);
**/

always @(posedge clk_vga) begin

	if(active_vid && img_ready) begin
		
		/**
		reg_R <= 4'b0000;
		reg_B <= 4'b1111;
		reg_G <= 4'b0000;
		**/
		
		reg_R <= reg_color;
		reg_G <= reg_color;
		reg_B <= reg_color;	
		
	end
	else begin
		reg_R <= 4'b0000;
		reg_G <= 4'b0000;
		reg_B <= 4'b0000;
	end
end


endmodule