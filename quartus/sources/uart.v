/*
    Registrador de configurações:

    B0 (LSB) - Presença de paridade: (1 sim/ 0 não)
    B1 - Paridade: (0 par/1impar)
    B2e3 - Dados: (11 5, 10 6, 01 7, 00 8)
    B4 - Stopbits: um 0, dois 1
    B5 - Handshake: (1sim/0não)
    B6e7 - Velocidade clock: (0 9600/ 1 19200 / 2 57600 / 3 115200
*/

module uart(
    input reset,
    input sys_clk,
    input serial_in,
    
	 input [7:0] usr_options,
	 input data_read_nios,
	 
	 output new_data,	 
	 output [7:0] data_in_nios

);

wire uart_clk_rx;

// RX
wire wire_rx_busy;
wire wire_rx_done;
wire wire_rx_start;
wire [7:0] wire_data_in;

assign data_in_nios = wire_data_in;
assign new_data = wire_rx_done;

clk_decoder cd_rx (
    .sys_clk(sys_clk),
    .usr_option(usr_options[7:6]),
    .reset(reset),
    .enable(wire_rx_start),
    .clk(uart_clk_rx)
);

uart_receiver rx (
    .reset(reset),
    .clk(uart_clk_rx),
    .serial_in(serial_in),
    .data_bits(usr_options[3:2]), // 11 5, 10 6, 01 7, 00 8;
	 .data_read_nios(data_read_nios),
    .enable_clk(wire_rx_start),
    .receiving(wire_rx_busy),
    .data_in(wire_data_in),
    .data_ready(wire_rx_done)
);

endmodule