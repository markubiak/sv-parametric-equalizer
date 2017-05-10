module mux_8_1 (
	input [2:0] select,
	input [7:0] data_in,
	output logic data_out
);

always_comb begin
	unique case (select)
		3'd7: data_out = data_in[7];
		3'd6: data_out = data_in[6];
		3'd5: data_out = data_in[5];
		3'd4: data_out = data_in[4];
		3'd3: data_out = data_in[3];
		3'd2: data_out = data_in[2];
		3'd1: data_out = data_in[1];
		3'd0: data_out = data_in[0];
	endcase
end
endmodule
