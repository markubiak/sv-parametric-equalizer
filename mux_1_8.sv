module mux_1_8(
	input [2:0] select,
	input data_in,
	output logic [7:0] data_out
);

always_comb begin
data_out = 8'd0;
unique case (select)
	3'd0: data_out[0] = data_in;
	3'd1: data_out[1] = data_in;
	3'd2: data_out[2] = data_in;
	3'd3: data_out[3] = data_in;
	3'd4: data_out[4] = data_in;
	3'd5: data_out[5] = data_in;
	3'd6: data_out[6] = data_in;
	3'd7: data_out[7] = data_in;
endcase
end
endmodule
