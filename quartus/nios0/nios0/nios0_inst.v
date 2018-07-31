	nios0 u0 (
		.clk_clk               (<connected-to-clk_clk>),               //          clk.clk
		.reset_reset_n         (<connected-to-reset_reset_n>),         //        reset.reset_n
		.uart_command_in_port  (<connected-to-uart_command_in_port>),  // uart_command.in_port
		.uart_command_out_port (<connected-to-uart_command_out_port>), //             .out_port
		.uart_options_export   (<connected-to-uart_options_export>),   // uart_options.export
		.uart_rx_data_export   (<connected-to-uart_rx_data_export>),   // uart_rx_data.export
		.vga_data_export       (<connected-to-vga_data_export>)        //     vga_data.export
	);

