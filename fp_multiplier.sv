module fp_multiplier (
	input [15:0] sample_in,
	input signed [17:0] fip_coefficient, // fp: 3.15
	output logic signed [35:0] mult_out // fp: 19.17
);

logic signed [17:0] fip_a;

always_comb
begin
	fip_a = {sample_in, 2'd0}; // fp: 16.2
	mult_out = fip_a * fip_coefficient;
end

endmodule
