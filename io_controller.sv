module io_controller(
	input Clk, Reset, coefficients_updated,
	input [3:0] to_hw_sig,
	input signed [17:0] coefficient,
	output logic [1:0] to_sw_sig,
	output logic load_graph_ram,
	output logic [9:0] waddr,
	output logic [7:0] wdata,
	output logic signed [17:0] b0, b1, b2, a1, a2,
	output logic load_coefficients, show_graph,
	output logic [3:0] state_out
);

assign state_out = state;
logic [17:0] b0_temp, b1_temp, b2_temp,
				 a1_temp, a2_temp,
				 b0_in, b1_in, b2_in, a1_in, a2_in,
				 b0oc, b1oc, b2oc, a1oc, a2oc;

logic [9:0] i = 10'd0;
logic [9:0] i_in;
logic ram_edited = 1'b0;
assign waddr = i;
assign wdata = coefficient[7:0];
assign show_graph = ram_edited;

enum logic [3:0] {Ready, b0_read, b0_ack,
								 b1_read, b1_ack,
								 b2_read, b2_ack,
								 a1_read, a1_ack,
								 a2_read, a2_ack,
								 load_coeffs, coeffs_done,
								 graph_read, graph_ack,
								 Done} state, next_state;

always_ff @ (posedge Clk) begin
	if (Reset) begin
		state <= Ready;
		ram_edited <= 1'b0;
		i <= 10'd0;
	end
	else
	state <= next_state;
	b0_temp <= b0_in;
	b1_temp <= b1_in;
	b2_temp <= b2_in;
	a1_temp <= a1_in;
	a2_temp <= a2_in;
	b0 <= b0oc;
	b1 <= b1oc;
	b2 <= b2oc;
	a1 <= a1oc;
	a2 <= a2oc;
	i <= i_in;
	if (state == graph_read)
		ram_edited <= 1'b1;
end

always_comb begin
	b0_in = b0_temp;
	b1_in = b1_temp;
	b2_in = b2_temp;
	a1_in = a1_temp;
	a2_in = a2_temp;
	b0oc = b0;
	b1oc = b1;
	b2oc = b2;
	a1oc = a1;
	a2oc = a2;
	next_state = state;
	load_coefficients = 1'd0;
	load_graph_ram = 1'b0;
	i_in = i;
	
	// next state logic
	case (state)
		Ready: begin
			if (to_hw_sig == 4'd1)
				next_state = b0_read;
		end
		b0_read: begin
			if (to_hw_sig == 4'd0)
				next_state = b0_ack;
		end
		b0_ack: begin
			if (to_hw_sig == 4'd1)
				next_state = b1_read;
		end
		b1_read: begin
			if (to_hw_sig == 4'd0)
				next_state = b1_ack;
		end
		b1_ack: begin
			if (to_hw_sig == 4'd1)
				next_state = b2_read;
		end
		b2_read: begin
			if (to_hw_sig == 4'd0)
				next_state = b2_ack;
		end
		b2_ack: begin
			if (to_hw_sig == 4'd1)
				next_state = a1_read;
		end
		a1_read: begin
			if (to_hw_sig == 4'd0)
				next_state = a1_ack;
		end
		a1_ack: begin
			if (to_hw_sig == 4'd1)
				next_state = a2_read;
		end
		a2_read: begin
			if (to_hw_sig == 4'd0)
				next_state = a2_ack;
		end
		a2_ack: begin
			if (to_hw_sig == 4'd1)
				next_state = load_coeffs;
		end
		load_coeffs: begin
			next_state = coeffs_done;
		end
		coeffs_done: begin
			if (coefficients_updated)
				next_state = graph_read;
		end
		graph_read: begin
			if (to_hw_sig == 4'd0)
				next_state = graph_ack;
		end
		graph_ack: begin
			if (to_hw_sig == 4'd1) begin
				if (i == 10'd516)
					next_state = Done;
				else
					next_state = graph_read;
				i_in = i + 10'd1;
			end
		end
		Done: begin
			if (to_hw_sig == 4'd0)
				next_state = Ready;
		end
	endcase
	
	//control signals
	case (state)
		Ready: begin
			to_sw_sig = 2'd0;
			i_in = 10'd0;
		end
		b0_read: begin
			to_sw_sig = 2'd1;
			b0_in = coefficient;
		end
		b0_ack: begin
			to_sw_sig = 2'd0;
		end
		b1_read: begin
			to_sw_sig = 2'd1;
			b1_in = coefficient;
		end
		b1_ack: begin
			to_sw_sig = 2'd0;
		end
		b2_read: begin
			to_sw_sig = 2'd1;
			b2_in = coefficient;
		end
		b2_ack: begin
			to_sw_sig = 2'd0;
		end
		a1_read: begin
			to_sw_sig = 2'd1;
			a1_in = coefficient;
		end
		a1_ack: begin
			to_sw_sig = 2'd0;
		end
		a2_read: begin
			to_sw_sig = 2'd1;
			a2_in = coefficient;
		end
		a2_ack: begin
			to_sw_sig = 2'd0;
		end
		load_coeffs: begin
			to_sw_sig = 2'd1;
			b0oc = b0_temp;
			b1oc = b1_temp;
			b2oc = b2_temp;
			a1oc = a1_temp;
			a2oc = a2_temp;
			load_coefficients = 1'd1;
		end
		coeffs_done: begin
			to_sw_sig = 2'd1;
			load_coefficients = 1'd1;
		end
		graph_read: begin
			to_sw_sig = 2'd1;
			load_graph_ram = 1'b1;
		end
		graph_ack: begin
			to_sw_sig = 2'd0;
		end
		Done: begin
			to_sw_sig = 2'd1;
		end
	endcase
end
endmodule
