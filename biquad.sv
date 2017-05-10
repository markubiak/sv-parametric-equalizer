module biquad (
	input Clk, Reset, new_sample, new_coefficients,
	input signed [15:0] sample_in,
	input signed [17:0] b0_load, b1_load, b2_load, a1_load, a2_load,
	output logic signed [15:0] sample_out,
	output logic computation_done, coefficients_updated
);

assign sample_out = y0;

logic signed [15:0] x0, x1, x2, y0, y1, y2, x0_n, x1_n, x2_n, y0_n, y1_n, y2_n;
logic signed [17:0] b0 = 18'b000100000000000000; // fp: 4.14, initializes to 1
logic signed [17:0] b1 = 18'd0;
logic signed [17:0] b2 = 18'd0;
logic signed [17:0] a1 = 18'd0;
logic signed [17:0] a2 = 18'd0;
logic signed [35:0] x0out, x1out, x2out, y1out, y2out; // fp: 20.16
logic signed [39:0] adder_out;
logic signed [23:0] adder_out_int; // int with overflow

enum logic [2:0] {RESET, LOAD_COEFFICIENTS, LOAD_COEFFICIENTS_DONE, NEW_SAMPLE, COMPUTE} state, next_state;

fp_multiplier mx0(.sample_in(x0), .fip_coefficient(b0), .mult_out(x0out));
fp_multiplier mx1(.sample_in(x1), .fip_coefficient(b1), .mult_out(x1out));
fp_multiplier mx2(.sample_in(x2), .fip_coefficient(b2), .mult_out(x2out));
fp_multiplier mx3(.sample_in(y1), .fip_coefficient(a1), .mult_out(y1out));
fp_multiplier mx4(.sample_in(y2), .fip_coefficient(a2), .mult_out(y2out));

always_ff @ (posedge Clk)
begin
	if (state == LOAD_COEFFICIENTS) begin
		b0 <= b0_load;
		b1 <= b1_load;
		b2 <= b2_load;
		a1 <= a1_load;
		a2 <= a2_load;
	end
	if (Reset) begin
		state <= RESET;
		b0 <= 18'b000100000000000000;
		b1 <= 18'd0;
		b2 <= 18'd0;
		a1 <= 18'd0;
		a2 <= 18'd0;
	end
	else begin
		state <= next_state;
		x0 <= x0_n;
		x1 <= x1_n;
		x2 <= x2_n;
		y0 <= y0_n;
		y1 <= y1_n;
		y2 <= y2_n;
	end
end

always_comb
begin
	//next state logic
	next_state = state;
	case (state)
		RESET: begin
			if (new_coefficients)
				next_state = LOAD_COEFFICIENTS;
			else if (new_sample)
				next_state = NEW_SAMPLE;
		end
		LOAD_COEFFICIENTS: begin
			next_state = LOAD_COEFFICIENTS_DONE;
		end
		LOAD_COEFFICIENTS_DONE: begin
			if (new_sample)
				next_state = NEW_SAMPLE;
			else if (~new_coefficients)
				next_state = RESET;
		end
		NEW_SAMPLE: begin
			next_state = COMPUTE;
		end
		COMPUTE: begin
			if (~new_sample)
				next_state = RESET;
		end
	endcase
	
	//control signals and processing
	computation_done = 1'b0;
	coefficients_updated = 1'b0;
	x0_n = x0;
	x1_n = x1;
	x2_n = x2;
	y0_n = y0;
	y1_n = y1;
	y2_n = y2;
	adder_out = 40'd0;
	adder_out_int = 24'd0;
	case (state)
		NEW_SAMPLE: begin
			x0_n = sample_in;
			x1_n = x0;
			x2_n = x1;
			y1_n = y0;
			y2_n = y1;
		end
		LOAD_COEFFICIENTS_DONE: begin
			coefficients_updated = 1'b1;
		end
		COMPUTE: begin
			adder_out = x0out + x1out + x2out + y1out + y2out;
			// the following is for calculating y0
			// round up if necessary
			if (adder_out[15]) // check first bit to right of decimal
				adder_out_int = (adder_out[39:16]) + 1'b1; // add 1 to integer part, remove float
			else
				adder_out_int = adder_out[39:16]; // remove float
			
			// check for overflow
			if (adder_out_int[23]) begin // negative
				if (adder_out_int[23:16] != 8'hff) // overflow
					y0_n = 16'h8000; // 2's complement min
				else
					y0_n = adder_out_int[15:0];
			end
			else begin // 0 or positive
				if (adder_out_int[23:16] != 8'd0) // overflow
					y0_n = 16'h7fff; // 2's complement max
				else
					y0_n = adder_out_int[15:0];
			end
			computation_done = 1'b1;
		end
		default: begin
		end
	endcase
end
endmodule
