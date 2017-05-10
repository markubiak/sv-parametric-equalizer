module audio_controller (
	input Clk, Reset, DSP_ENABLE, LC_ENABLE, load_coefficients,
	input [2:0] biquad_index,
	input signed [17:0] b0, b1, b2, a1, a2,
	input AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK,
	output logic AUD_DACDAT, AUD_XCK, I2C_SCLK, I2C_SDAT,
	output logic coefficients_updated
);

logic [15:0] LData, RData, LData_in, RData_in;
logic [15:0] DSP_L, DSP_R, DSP_L_in, DSP_R_in, DSP_L_out, DSP_R_out;
logic [31:0] ADCData;
logic Init, Init_Finish, ADC_Full, Data_over;
logic computation_done_l, computation_done_r, coefficients_updated_l, coefficients_updated_r, new_sample, push_coefficients;

enum logic [2:0] {RESET, INITIALIZATION, GET_FROM_ADC, DSP, DSP_TO_DAC, ADC_TO_DAC, LOAD_COEFFICIENTS, LOAD_COEFFICIENTS_DONE} state, next_state;

audio_interface audioif(.LDATA(LData), .RDATA(RData), .clk(Clk), .Reset(Reset),
								.INIT(Init), .INIT_FINISH(Init_Finish), .adc_full(ADC_Full),
								.data_over(Data_over), .AUD_MCLK(AUD_XCK), .AUD_BCLK(AUD_BCLK), .AUD_DACDAT(AUD_DACDAT),
								.AUD_ADCDAT(AUD_ADCDAT), .AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK), 
								.I2C_SDAT(I2C_SDAT), .I2C_SCLK(I2C_SCLK), .ADCDATA(ADCData));

biquad_chain biquads_left(.Clk, .Reset, .new_sample, .push_coefficients,
								  .biquad_index, .sample_in(DSP_L), 
								  .b0, .b1, .b2, .a1, .a2,
								  .sample_out(DSP_L_out), .computation_done(computation_done_l),
								  .coefficients_updated(coefficients_updated_l));
biquad_chain biquads_right(.Clk, .Reset, .new_sample, .push_coefficients,
								  .biquad_index, .sample_in(DSP_R), 
								  .b0, .b1, .b2, .a1, .a2,
								  .sample_out(DSP_R_out), .computation_done(computation_done_r),
								  .coefficients_updated(coefficients_updated_r));

always_ff @ (posedge Clk)
begin
	if (Reset)
		state <= RESET;
	else
	begin
		state <= next_state;
		LData <= LData_in;
		RData <= RData_in;
		DSP_L <= DSP_L_in;
		DSP_R <= DSP_R_in;
	end
end

always_comb
begin
	// Next state logic
	next_state = state;
	case (state)
		RESET: begin
			next_state = INITIALIZATION;
		end
		INITIALIZATION: begin
			if (Init_Finish)
				next_state = GET_FROM_ADC;
		end
		GET_FROM_ADC: begin
			if (Data_over) begin
				if (DSP_ENABLE)
					next_state = DSP;
				else
					next_state = ADC_TO_DAC;
			end
		end
		ADC_TO_DAC: begin
			if (load_coefficients)
				next_state = LOAD_COEFFICIENTS;
			else if (~Data_over)
				next_state = GET_FROM_ADC;
		end
		DSP: begin
			if (computation_done_l && computation_done_r)
				next_state = DSP_TO_DAC;
		end
		DSP_TO_DAC: begin
			if (load_coefficients)
				next_state = LOAD_COEFFICIENTS;
			else if (~Data_over)
				next_state = GET_FROM_ADC;
		end
		LOAD_COEFFICIENTS: begin
			if (coefficients_updated_l && coefficients_updated_r)
				next_state = LOAD_COEFFICIENTS_DONE;
		end
		LOAD_COEFFICIENTS_DONE: begin
			if (~Data_over)
				next_state = GET_FROM_ADC;
		end
	endcase
	
	// Logic controls
	Init = 1'b0;
	new_sample = 1'b0;
	push_coefficients = 1'b0;
	coefficients_updated = 1'b0;
	LData_in = LData;
	RData_in = RData;
	DSP_L_in = DSP_L;
	DSP_R_in = DSP_R;
	case (state)
		INITIALIZATION: begin
			Init = 1'b1;
		end
		GET_FROM_ADC: begin
			if (LC_ENABLE)
				DSP_L_in = ADCData[31:16];
			else
				DSP_L_in = ADCData[15:0];
			DSP_R_in = ADCData[15:0];
		end
		ADC_TO_DAC: begin
			new_sample = 1'b1;
			LData_in = DSP_L;
			RData_in = DSP_R;
		end
		DSP: begin
			new_sample = 1'b1;
		end
		DSP_TO_DAC: begin
			new_sample = 1'b1;
			LData_in = DSP_L_out;
			RData_in = DSP_R_out;
		end
		LOAD_COEFFICIENTS: begin
			push_coefficients = 1'b1;
		end
		LOAD_COEFFICIENTS_DONE: begin
			coefficients_updated = 1'b1;
		end
		default: begin
		end
	endcase
end
endmodule
