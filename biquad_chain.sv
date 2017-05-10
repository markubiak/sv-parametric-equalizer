module biquad_chain(
	input Clk, Reset, new_sample, push_coefficients,
	input [2:0] biquad_index,
	input signed [15:0] sample_in,
	input signed [17:0] b0, b1, b2, a1, a2,
	output logic signed [15:0] sample_out,
	output logic computation_done, coefficients_updated
);

logic [15:0] bq1_out, bq2_out, bq3_out, bq4_out, bq5_out, bq6_out, bq7_out;
logic [6:0] cd_arr;

logic [7:0] nc_arr;
logic [7:0] cu_arr;
mux_1_8 new_coefficients_mux(.select(biquad_index), .data_in(push_coefficients), .data_out(nc_arr));
mux_8_1 coefficients_updated_mux(.select(biquad_index), .data_in(cu_arr), .data_out(coefficients_updated));

biquad bq1(.Clk, .Reset, .new_sample, .new_coefficients(nc_arr[0]),
			  .sample_in,
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq1_out),
			  .computation_done(cd_arr[0]), .coefficients_updated(cu_arr[0]));
biquad bq2(.Clk, .Reset, .new_sample(cd_arr[0]), .new_coefficients(nc_arr[1]),
			  .sample_in(bq1_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq2_out),
			  .computation_done(cd_arr[1]), .coefficients_updated(cu_arr[1]));
biquad bq3(.Clk, .Reset, .new_sample(cd_arr[1]), .new_coefficients(nc_arr[2]),
			  .sample_in(bq2_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq3_out),
			  .computation_done(cd_arr[2]), .coefficients_updated(cu_arr[2]));
biquad bq4(.Clk, .Reset, .new_sample(cd_arr[2]), .new_coefficients(nc_arr[3]),
			  .sample_in(bq3_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq4_out),
			  .computation_done(cd_arr[3]), .coefficients_updated(cu_arr[3]));
biquad bq5(.Clk, .Reset, .new_sample(cd_arr[3]), .new_coefficients(nc_arr[4]),
			  .sample_in(bq4_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq5_out),
			  .computation_done(cd_arr[4]), .coefficients_updated(cu_arr[4]));
biquad bq6(.Clk, .Reset, .new_sample(cd_arr[4]), .new_coefficients(nc_arr[5]),
			  .sample_in(bq5_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq6_out),
			  .computation_done(cd_arr[5]), .coefficients_updated(cu_arr[5]));
biquad bq7(.Clk, .Reset, .new_sample(cd_arr[5]), .new_coefficients(nc_arr[6]),
			  .sample_in(bq6_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out(bq7_out),
			  .computation_done(cd_arr[6]), .coefficients_updated(cu_arr[6]));
biquad bq8(.Clk, .Reset, .new_sample(cd_arr[6]), .new_coefficients(nc_arr[7]),
			  .sample_in(bq7_out),
			  .b0_load(b0), .b1_load(b1), .b2_load(b2), .a1_load(a1), .a2_load(a2),
			  .sample_out,
			  .computation_done, .coefficients_updated(cu_arr[7]));
endmodule
