
module unsaved (
	clk_clk,
	reset_reset_n,
	video_vga_controller_0_clk_clk,
	video_vga_controller_0_external_interface_CLK,
	video_vga_controller_0_external_interface_HS,
	video_vga_controller_0_external_interface_VS,
	video_vga_controller_0_external_interface_BLANK,
	video_vga_controller_0_external_interface_SYNC,
	video_vga_controller_0_external_interface_R,
	video_vga_controller_0_external_interface_G,
	video_vga_controller_0_external_interface_B,
	video_vga_controller_0_reset_reset,
	onchip_memory2_1_s1_address,
	onchip_memory2_1_s1_clken,
	onchip_memory2_1_s1_chipselect,
	onchip_memory2_1_s1_write,
	onchip_memory2_1_s1_readdata,
	onchip_memory2_1_s1_writedata,
	onchip_memory2_1_s1_byteenable,
	sc_fifo_0_in_data,
	sc_fifo_0_in_valid,
	sc_fifo_0_in_ready,
	sc_fifo_0_in_startofpacket,
	sc_fifo_0_in_endofpacket,
	sc_fifo_0_in_empty,
	video_vga_controller_0_avalon_vga_sink_data,
	video_vga_controller_0_avalon_vga_sink_startofpacket,
	video_vga_controller_0_avalon_vga_sink_endofpacket,
	video_vga_controller_0_avalon_vga_sink_valid,
	video_vga_controller_0_avalon_vga_sink_ready);	

	input		clk_clk;
	input		reset_reset_n;
	input		video_vga_controller_0_clk_clk;
	output		video_vga_controller_0_external_interface_CLK;
	output		video_vga_controller_0_external_interface_HS;
	output		video_vga_controller_0_external_interface_VS;
	output		video_vga_controller_0_external_interface_BLANK;
	output		video_vga_controller_0_external_interface_SYNC;
	output	[7:0]	video_vga_controller_0_external_interface_R;
	output	[7:0]	video_vga_controller_0_external_interface_G;
	output	[7:0]	video_vga_controller_0_external_interface_B;
	input		video_vga_controller_0_reset_reset;
	input	[5:0]	onchip_memory2_1_s1_address;
	input		onchip_memory2_1_s1_clken;
	input		onchip_memory2_1_s1_chipselect;
	input		onchip_memory2_1_s1_write;
	output	[1023:0]	onchip_memory2_1_s1_readdata;
	input	[1023:0]	onchip_memory2_1_s1_writedata;
	input	[127:0]	onchip_memory2_1_s1_byteenable;
	input	[2559:0]	sc_fifo_0_in_data;
	input		sc_fifo_0_in_valid;
	output		sc_fifo_0_in_ready;
	input		sc_fifo_0_in_startofpacket;
	input		sc_fifo_0_in_endofpacket;
	input	[8:0]	sc_fifo_0_in_empty;
	input	[29:0]	video_vga_controller_0_avalon_vga_sink_data;
	input		video_vga_controller_0_avalon_vga_sink_startofpacket;
	input		video_vga_controller_0_avalon_vga_sink_endofpacket;
	input		video_vga_controller_0_avalon_vga_sink_valid;
	output		video_vga_controller_0_avalon_vga_sink_ready;
endmodule
