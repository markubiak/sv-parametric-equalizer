module ascii_string_2 (
							input Clk, Reset,
							input [9:0] DrawX, DrawY,
							input [15:0] input_string_in,
							input [10:0] shape_x, shape_y,
							input load_string, 
							output logic sprite_on,
							output logic [10:0] sprite_addr, u_shape_x, u_shape_y
							);
							
	logic [10:0] size_x = 11'd8;
	logic [10:0] size_y = 11'd16;
	logic [31:0] input_string;
	
	addr_compute s1(.*, .ascii(input_string[15:8]));
	addr_compute s2(.*, .ascii(input_string[7:0]), .shape_x(shape_x + size_x));
always_ff @ (posedge Clk) begin
	if (Reset)
		input_string <= 32'd0;
	else if (load_string) begin
		input_string <= input_string_in;
	end
end
endmodule