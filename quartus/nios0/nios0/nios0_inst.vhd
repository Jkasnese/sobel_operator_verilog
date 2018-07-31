	component nios0 is
		port (
			clk_clk               : in  std_logic                     := 'X';             -- clk
			reset_reset_n         : in  std_logic                     := 'X';             -- reset_n
			uart_command_in_port  : in  std_logic                     := 'X';             -- in_port
			uart_command_out_port : out std_logic;                                        -- out_port
			uart_options_export   : out std_logic_vector(7 downto 0);                     -- export
			uart_rx_data_export   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			vga_data_export       : out std_logic_vector(23 downto 0)                     -- export
		);
	end component nios0;

	u0 : component nios0
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --          clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --        reset.reset_n
			uart_command_in_port  => CONNECTED_TO_uart_command_in_port,  -- uart_command.in_port
			uart_command_out_port => CONNECTED_TO_uart_command_out_port, --             .out_port
			uart_options_export   => CONNECTED_TO_uart_options_export,   -- uart_options.export
			uart_rx_data_export   => CONNECTED_TO_uart_rx_data_export,   -- uart_rx_data.export
			vga_data_export       => CONNECTED_TO_vga_data_export        --     vga_data.export
		);

