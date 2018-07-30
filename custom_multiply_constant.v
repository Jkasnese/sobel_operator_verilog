module custom_multiply (
	
	// Inputs required for multicycle custom instructions
    input clock,
    input reset,

	input [31:0] dataa,
	input [31:0] datab,

	// Outputs
	output reg [31:0] result

);

wire  [32:0] mult2;

assign mult2[32:1] = dataa;

always @(*) begin
    if (datab == 32'd0) begin
        result <= 32'd0;
    end else if (datab == 32'd1) begin
        result <= dataa;
    end else begin
        result <= mult2[32:1];
    end
    
end

endmodule
