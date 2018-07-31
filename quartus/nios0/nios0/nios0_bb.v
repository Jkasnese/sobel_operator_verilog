
module nios0 (
	clk_clk,
	reset_reset_n,
	uart_command_in_port,
	uart_command_out_port,
	uart_options_export,
	uart_rx_data_export,
	vga_data_export);	

	input		clk_clk;
	input		reset_reset_n;
	input		uart_command_in_port;
	output		uart_command_out_port;
	output	[7:0]	uart_options_export;
	input	[7:0]	uart_rx_data_export;
	output	[23:0]	vga_data_export;
endmodule
