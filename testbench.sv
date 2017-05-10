module testbench();



logic [10:0] shape_y, shape_x;
logic [9:0] DrawX, DrawY;
logic [7:0] ascii;
logic [10:0] sprite_addr, u_shape_x, u_shape_y;
logic sprite_on;
logic [7:0] sprite_data;

assign shape_y = 10'd2;
assign shape_x = 10'd2;
assign DrawX = 10'd2;
assign DrawY = 10'd4;
assign ascii = 8'h54;

addr_compute tb(.*);
font_rom tbrom(.addr(sprite_addr), .data(sprite_data));

endmodule
