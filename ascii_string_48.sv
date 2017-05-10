module ascii_string_48 (
							input Clk, Reset,
							input [9:0] DrawX, DrawY,
							input [383:0] input_string_in,
							input [10:0] shape_x, shape_y,
							output logic sprite_on,
							output logic [10:0] sprite_addr, u_shape_x, u_shape_y
							);
							
	logic [10:0] size_x = 11'd32;
	logic [10:0] size_y = 11'd16;
	logic load_string = 1'b1;
	
	ascii_string_4 S1(.*, .input_string_in(input_string_in[383:352]));
	ascii_string_4 S2(.*, .input_string_in(input_string_in[351:320]), .shape_x(shape_x + size_x));
	ascii_string_4 S3(.*, .input_string_in(input_string_in[319:288]), .shape_x(shape_x + (11'd2*size_x)));
	ascii_string_4 S4(.*, .input_string_in(input_string_in[287:256]), .shape_x(shape_x + (11'd3*size_x)));
	ascii_string_4 S5(.*, .input_string_in(input_string_in[255:224]), .shape_x(shape_x + (11'd4*size_x)));
	ascii_string_4 S6(.*, .input_string_in(input_string_in[223:192]), .shape_x(shape_x + (11'd5*size_x)));
	ascii_string_4 S7(.*, .input_string_in(input_string_in[191:160]), .shape_x(shape_x + (11'd6*size_x)));
	ascii_string_4 S8(.*, .input_string_in(input_string_in[159:128]), .shape_x(shape_x + (11'd7*size_x)));
	ascii_string_4 S9(.*, .input_string_in(input_string_in[127:96]), .shape_x(shape_x + (11'd8*size_x)));
	ascii_string_4 S10(.*, .input_string_in(input_string_in[95:64]), .shape_x(shape_x + (11'd9*size_x)));
	ascii_string_4 S11(.*, .input_string_in(input_string_in[63:32]), .shape_x(shape_x + (11'd10*size_x)));
	ascii_string_4 S12(.*, .input_string_in(input_string_in[31:0]), .shape_x(shape_x + (11'd11*size_x)));
	

endmodule