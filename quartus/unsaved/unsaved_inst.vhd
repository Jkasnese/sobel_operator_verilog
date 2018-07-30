	component unsaved is
		port (
			clk_clk                                              : in  std_logic                       := 'X';             -- clk
			reset_reset_n                                        : in  std_logic                       := 'X';             -- reset_n
			video_vga_controller_0_clk_clk                       : in  std_logic                       := 'X';             -- clk
			video_vga_controller_0_external_interface_CLK        : out std_logic;                                          -- CLK
			video_vga_controller_0_external_interface_HS         : out std_logic;                                          -- HS
			video_vga_controller_0_external_interface_VS         : out std_logic;                                          -- VS
			video_vga_controller_0_external_interface_BLANK      : out std_logic;                                          -- BLANK
			video_vga_controller_0_external_interface_SYNC       : out std_logic;                                          -- SYNC
			video_vga_controller_0_external_interface_R          : out std_logic_vector(7 downto 0);                       -- R
			video_vga_controller_0_external_interface_G          : out std_logic_vector(7 downto 0);                       -- G
			video_vga_controller_0_external_interface_B          : out std_logic_vector(7 downto 0);                       -- B
			video_vga_controller_0_reset_reset                   : in  std_logic                       := 'X';             -- reset
			onchip_memory2_1_s1_address                          : in  std_logic_vector(5 downto 0)    := (others => 'X'); -- address
			onchip_memory2_1_s1_clken                            : in  std_logic                       := 'X';             -- clken
			onchip_memory2_1_s1_chipselect                       : in  std_logic                       := 'X';             -- chipselect
			onchip_memory2_1_s1_write                            : in  std_logic                       := 'X';             -- write
			onchip_memory2_1_s1_readdata                         : out std_logic_vector(1023 downto 0);                    -- readdata
			onchip_memory2_1_s1_writedata                        : in  std_logic_vector(1023 downto 0) := (others => 'X'); -- writedata
			onchip_memory2_1_s1_byteenable                       : in  std_logic_vector(127 downto 0)  := (others => 'X'); -- byteenable
			sc_fifo_0_in_data                                    : in  std_logic_vector(2559 downto 0) := (others => 'X'); -- data
			sc_fifo_0_in_valid                                   : in  std_logic                       := 'X';             -- valid
			sc_fifo_0_in_ready                                   : out std_logic;                                          -- ready
			sc_fifo_0_in_startofpacket                           : in  std_logic                       := 'X';             -- startofpacket
			sc_fifo_0_in_endofpacket                             : in  std_logic                       := 'X';             -- endofpacket
			sc_fifo_0_in_empty                                   : in  std_logic_vector(8 downto 0)    := (others => 'X'); -- empty
			video_vga_controller_0_avalon_vga_sink_data          : in  std_logic_vector(29 downto 0)   := (others => 'X'); -- data
			video_vga_controller_0_avalon_vga_sink_startofpacket : in  std_logic                       := 'X';             -- startofpacket
			video_vga_controller_0_avalon_vga_sink_endofpacket   : in  std_logic                       := 'X';             -- endofpacket
			video_vga_controller_0_avalon_vga_sink_valid         : in  std_logic                       := 'X';             -- valid
			video_vga_controller_0_avalon_vga_sink_ready         : out std_logic                                           -- ready
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk                                              => CONNECTED_TO_clk_clk,                                              --                                       clk.clk
			reset_reset_n                                        => CONNECTED_TO_reset_reset_n,                                        --                                     reset.reset_n
			video_vga_controller_0_clk_clk                       => CONNECTED_TO_video_vga_controller_0_clk_clk,                       --                video_vga_controller_0_clk.clk
			video_vga_controller_0_external_interface_CLK        => CONNECTED_TO_video_vga_controller_0_external_interface_CLK,        -- video_vga_controller_0_external_interface.CLK
			video_vga_controller_0_external_interface_HS         => CONNECTED_TO_video_vga_controller_0_external_interface_HS,         --                                          .HS
			video_vga_controller_0_external_interface_VS         => CONNECTED_TO_video_vga_controller_0_external_interface_VS,         --                                          .VS
			video_vga_controller_0_external_interface_BLANK      => CONNECTED_TO_video_vga_controller_0_external_interface_BLANK,      --                                          .BLANK
			video_vga_controller_0_external_interface_SYNC       => CONNECTED_TO_video_vga_controller_0_external_interface_SYNC,       --                                          .SYNC
			video_vga_controller_0_external_interface_R          => CONNECTED_TO_video_vga_controller_0_external_interface_R,          --                                          .R
			video_vga_controller_0_external_interface_G          => CONNECTED_TO_video_vga_controller_0_external_interface_G,          --                                          .G
			video_vga_controller_0_external_interface_B          => CONNECTED_TO_video_vga_controller_0_external_interface_B,          --                                          .B
			video_vga_controller_0_reset_reset                   => CONNECTED_TO_video_vga_controller_0_reset_reset,                   --              video_vga_controller_0_reset.reset
			onchip_memory2_1_s1_address                          => CONNECTED_TO_onchip_memory2_1_s1_address,                          --                       onchip_memory2_1_s1.address
			onchip_memory2_1_s1_clken                            => CONNECTED_TO_onchip_memory2_1_s1_clken,                            --                                          .clken
			onchip_memory2_1_s1_chipselect                       => CONNECTED_TO_onchip_memory2_1_s1_chipselect,                       --                                          .chipselect
			onchip_memory2_1_s1_write                            => CONNECTED_TO_onchip_memory2_1_s1_write,                            --                                          .write
			onchip_memory2_1_s1_readdata                         => CONNECTED_TO_onchip_memory2_1_s1_readdata,                         --                                          .readdata
			onchip_memory2_1_s1_writedata                        => CONNECTED_TO_onchip_memory2_1_s1_writedata,                        --                                          .writedata
			onchip_memory2_1_s1_byteenable                       => CONNECTED_TO_onchip_memory2_1_s1_byteenable,                       --                                          .byteenable
			sc_fifo_0_in_data                                    => CONNECTED_TO_sc_fifo_0_in_data,                                    --                              sc_fifo_0_in.data
			sc_fifo_0_in_valid                                   => CONNECTED_TO_sc_fifo_0_in_valid,                                   --                                          .valid
			sc_fifo_0_in_ready                                   => CONNECTED_TO_sc_fifo_0_in_ready,                                   --                                          .ready
			sc_fifo_0_in_startofpacket                           => CONNECTED_TO_sc_fifo_0_in_startofpacket,                           --                                          .startofpacket
			sc_fifo_0_in_endofpacket                             => CONNECTED_TO_sc_fifo_0_in_endofpacket,                             --                                          .endofpacket
			sc_fifo_0_in_empty                                   => CONNECTED_TO_sc_fifo_0_in_empty,                                   --                                          .empty
			video_vga_controller_0_avalon_vga_sink_data          => CONNECTED_TO_video_vga_controller_0_avalon_vga_sink_data,          --    video_vga_controller_0_avalon_vga_sink.data
			video_vga_controller_0_avalon_vga_sink_startofpacket => CONNECTED_TO_video_vga_controller_0_avalon_vga_sink_startofpacket, --                                          .startofpacket
			video_vga_controller_0_avalon_vga_sink_endofpacket   => CONNECTED_TO_video_vga_controller_0_avalon_vga_sink_endofpacket,   --                                          .endofpacket
			video_vga_controller_0_avalon_vga_sink_valid         => CONNECTED_TO_video_vga_controller_0_avalon_vga_sink_valid,         --                                          .valid
			video_vga_controller_0_avalon_vga_sink_ready         => CONNECTED_TO_video_vga_controller_0_avalon_vga_sink_ready          --                                          .ready
		);

