module custom_multiply (
	
	// Inputs required for multicycle custom instructions

	input clk,
	input clk_en,
	input reset, 
	input start, // Operation is allowed to start, there is valid data on the input
	input [31:0] dataa,
	input [31:0] datab,


	// Outputs

	output done,	// Lets Nios know that the operation has been completed
	output [31:0] result

);

parameter   [1:0]   IDLE = 4'b00,
                    OPER = 4'b01,
                    SDONE = 4'b10;

reg reg_done = 0, reg_add_shift;
reg [5:0] counter = 6'b100000; // Number of shifts 
reg [31:0] multiplier; 
reg [63:0] multiplicand, res;
reg [1:0] cur_state;


always @(posedge clk or posedge reset) begin
	if(reset) begin
		cur_state <= IDLE;
	end
	else begin
			case(cur_state) begin
				IDLE: begin
					if(start) begin 
						multiplier <= dataa;
						multiplicand <= datab;
						cur_state <= OPER;
					end
					else begin
						multiplicand <= 64'b0;
						multiplier <= 31'b0;
						cur_state <= IDLE;
					end
				end
				OPER: begin
					if(multiplier[0] == 1'b1 && reg_add_shift == 1'b0) begin
						res <= res + multiplicand;
						reg_add_shift <= 1'b1; // 1 - shift
					end
					else begin
						multiplier <= multiplier >> 1'b1;
						multiplicand <= multiplicand << 1'b1; 
						reg_add_shift <= 1'b0;
						counter <= counter - 1'b1;
					end

				end
			endcase	
	end
	
end