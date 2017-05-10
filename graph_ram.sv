module graph_ram
	#(parameter int
		ADDR_WIDTH = 10,
		BYTE_WIDTH = 8,
		BYTES = 1,
			WIDTH = BYTES * BYTE_WIDTH
)
( 
	input [ADDR_WIDTH-1:0] waddr,
	input [ADDR_WIDTH-1:0] raddr,
	input [BYTE_WIDTH-1:0] wdata, 
	input we, clk,
	output reg [WIDTH - 1:0] q
);
	localparam int WORDS = 1 << ADDR_WIDTH ;

	// use a multi-dimensional packed array to model individual bytes within the word
	logic [BYTES-1:0][BYTE_WIDTH-1:0] ram[0:WORDS-1];

	always_ff@(posedge clk)
	begin
		if(we) begin
			ram[waddr][0] <= wdata;
		end
		q <= ram[raddr];
	end
endmodule
