module clk_divisor(

	input clk_50,

	output clk_25

);

reg clk_out;
assign clk_25 = clk_out;

always @(posedge clk_50) begin
	clk_out <= ~clk_out;
end

endmodule