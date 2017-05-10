module addr_compute (input [10:0] shape_y, shape_x,
							input [9:0] DrawX, DrawY,
							input logic [7:0] ascii,
							output logic [10:0] sprite_addr, u_shape_x, u_shape_y,
							output logic sprite_on
);
	logic [10:0] size_x = 11'd8;
	logic [10:0] size_y = 11'd16;

	always_comb
	begin
		if (DrawX >= shape_x && DrawX < shape_x + size_x &&
			 DrawY >= shape_y && DrawY < shape_y + size_y)
			begin
				sprite_on = 1'b1;
				sprite_addr = (DrawY - shape_y + (8'h10*ascii));
				u_shape_x = shape_x;
				u_shape_y = shape_y;
			end
		else begin
			sprite_on = 1'bz;
			sprite_addr = 8'hzz;
			u_shape_x = 11'bz;
			u_shape_y = 11'bz;
		end
	end
endmodule