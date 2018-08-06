module sobel_top(
	input clock,
	input reset, 
	
	input rx, // pin H22

	output [3:0] r_pixel,
	output [3:0] g_pixel,
	output [3:0] b_pixel,
	output hsync,
	output vsync
);

// UART
wire [7:0] uart_usr_options;
wire [7:0] uart_data_in;
wire wire_new_data;

// VGA
wire [23:0] wire_vga_data;
wire [3:0] out_pixel;
assign r_pixel = out_pixel;
assign g_pixel = out_pixel;
assign b_pixel = out_pixel;

uart rs232(
    .reset(reset),
    .sys_clk(clock),
    .serial_in(rx),
    
	 .usr_options(uart_usr_options),
	 
	 .data_read_nios(wire_data_read),
	 .new_data(wire_new_data),
	 
	 .data_in_nios(uart_data_in)
);


nios0 u0 (
	.clk_clk               (clock),               //          clk.clk
	.reset_reset_n         (reset),         //        reset.reset_n
	.uart_rx_data_export   (uart_data_in),   // uart_rx_data.export
	.uart_options_export   (uart_usr_options),   // uart_options.export
	.uart_command_in_port  (wire_new_data),  // uart_command.in_port
	.uart_command_out_port (wire_data_read),  //             .out_port
	.vga_data_export       ()
);

vga_pll vpll(
	.areset(reset),
	.inclk0(clock),
	.c0(vga_36clk),
	.c1(vga_27clk),
	.locked(wire_locked)
);

vga_controller vga(
	.vga_clock(vga_36clk),
	.reset(reset),

	.write_reg(wire_vga_data), // 19:0 address, 23:20 data
	
	.pixel(out_pixel),
	.h_sync_signal(hsync),
	.v_sync_signal(vsync)
);

endmodule 