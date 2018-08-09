module sync_generator(

	input clk,
	input reset,
	
	output h_sync,
	output v_sync,
	output active_video

);

localparam H_TOTAL = 800;
localparam V_TOTAL = 525;
localparam ACTIVE_VIDEO_H = 640;
localparam ACTIVE_VIDEO_V = 480;
localparam START_H = 16;
localparam END_H = 112; // 16 (front porch) + 96 (sync pulse)
localparam START_V = 490; // 480 (active video v) + 10 (front porch v)
localparam END_V = 493; // START_V + 2 (sync pulse)


reg [9:0] x_counter = 10'd0, y_counter = 10'd0;


always @ (posedge clk) begin
	
	if(x_counter == H_TOTAL) begin
		x_counter <= 10'd0;
		y_counter <= y_counter + 1'b1;

		if(y_counter == V_TOTAL) begin
			y_counter <= 10'd0;
		end
		
	end
	else begin
		x_counter <= x_counter + 1'b1;
	end
		
end


// Testar opção 1 descomentando a primeira linha h sync + back porch + display + front porch, mantém o v

//assign active_video =  ((x_counter > END_H + 48) && (x_counter <= H_TOTAL) && (y_counter <= ACTIVE_VIDEO_V)); 
//assign active_video = ((x_counter <= ACTIVE_VIDEO_H) && (y_counter <= ACTIVE_VIDEO_V)) ? 1'b1 : 1'b0;
//assign active_video = ((x_counter > 96 + 48) && (x_counter <= 96 + 48 + ACTIVE_VIDEO_H) && (y_counter > 35) && (y_counter <= 35 + ACTIVE_VIDEO_V));
//assign active_video = ((x_counter > END_H) && (x_counter <= ACTIVE_VIDEO_H + END_H) && (y_counter > 12) && (y_counter <= ACTIVE_VIDEO_V + 12)); 
assign active_video = ((x_counter > 288) && (x_counter <= (ACTIVE_VIDEO_H - 288)) && (y_counter > 208) && (y_counter <= (ACTIVE_VIDEO_V - 208))) ? 1'b1 : 1'b0;

//assign h_sync = ~((x_counter > START_H) && (x_counter <= END_H)); 
assign h_sync = ~((x_counter > ACTIVE_VIDEO_H + START_H) && (x_counter <= ACTIVE_VIDEO_H + END_H)); 


assign v_sync = ~((y_counter > START_V) && (y_counter < END_V)); 
//assign v_sync = ~((y_counter <= 2));

endmodule