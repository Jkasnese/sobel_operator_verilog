module top_level(

	input clk, 
	input reset, 

	output [3:0] r,
	output [3:0] g, 
	output [3:0] b, 
	output v_sync, 
	output h_sync

);
	
	
wire [31:0] vga_data;
wire nios_new_pix;


	nios u0 (
		.clk_clk             (clk),             //          clk.clk
		.reset_reset_n       (reset),       //        reset.reset_n
		.vga_data_export     (vga_data),     //     vga_data.export
		.nios_new_pix_export (nios_new_pix)  // nios_new_pix.export
	);

vga_controller vga (
	
	.clk(clk),
	.reset(reset),
	.img_pix(vga_data),
	.nios_new_pix(nios_new_pix),
	
	.r(r),
	.g(g),
	.b(b),
	.h_sync(h_sync),
	.v_sync(v_sync)

);



endmodule