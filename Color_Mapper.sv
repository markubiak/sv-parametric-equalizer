module  color_mapper ( input Clk, Reset, load_coefficients, show_graph,
							  input        [9:0] DrawX, DrawY,       // Coordinates of current drawing pixel
							  input [31:0] f_string, g_string, q_string,
							  input [2:0] type_index, biquad_index,
							  input [3:0] to_hw_sig,
							  input [7:0] graph_value,
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [9:0] graph_lookup_x
                     );
    
	 logic sprite_on;
    logic [7:0] Red, Green, Blue;
	 logic [10:0] u_shape_x, u_shape_y;
	 logic [10:0] shape_size_x = 8;
	 logic [10:0] shape_size_y = 16;
	 logic [10:0] sprite_addr;
	 logic [7:0] sprite_data;
	 logic [31:0] type_ascii;
	 logic [10:0] t_pos_x, t_pos_y, f_pos_x, f_pos_y, q_pos_x, q_pos_y, g_pos_x, g_pos_y;
	 logic [383:0] prompt_ascii;
	 logic [9:0] graph_lookup_y;
	 assign graph_lookup_x = DrawX - 10'd80;
	 assign graph_lookup_y = 10'd420 - DrawY;
	 
	 addr_compute t1(.*,.ascii(8'h54), .shape_x(10'd2), .shape_y(10'd32)); 
	 addr_compute t2(.*,.ascii(8'h54), .shape_x(10'd2), .shape_y(10'd80)); 
	 addr_compute t3(.*,.ascii(8'h54), .shape_x(10'd162), .shape_y(10'd32)); 
	 addr_compute t4(.*,.ascii(8'h54), .shape_x(10'd162), .shape_y(10'd80)); 
	 addr_compute t5(.*,.ascii(8'h54), .shape_x(10'd322), .shape_y(10'd32)); 
	 addr_compute t6(.*,.ascii(8'h54), .shape_x(10'd322), .shape_y(10'd80)); 
	 addr_compute t7(.*,.ascii(8'h54), .shape_x(10'd482), .shape_y(10'd32)); 
	 addr_compute t8(.*,.ascii(8'h54), .shape_x(10'd482), .shape_y(10'd80)); 
	 addr_compute f1(.*,.ascii(8'h46), .shape_x(10'd81), .shape_y(10'd2)); 
	 addr_compute f2(.*,.ascii(8'h46), .shape_x(10'd81), .shape_y(10'd52)); 
	 addr_compute f3(.*,.ascii(8'h46), .shape_x(10'd243), .shape_y(10'd2)); 
	 addr_compute f4(.*,.ascii(8'h46), .shape_x(10'd243), .shape_y(10'd52)); 
	 addr_compute f5(.*,.ascii(8'h46), .shape_x(10'd403), .shape_y(10'd2)); 
	 addr_compute f6(.*,.ascii(8'h46), .shape_x(10'd403), .shape_y(10'd52)); 
	 addr_compute f7(.*,.ascii(8'h46), .shape_x(10'd563), .shape_y(10'd2)); 
	 addr_compute f8(.*,.ascii(8'h46), .shape_x(10'd563), .shape_y(10'd52)); 
	 addr_compute q1(.*,.ascii(8'h51), .shape_x(10'd81), .shape_y(10'd18)); 
	 addr_compute q2(.*,.ascii(8'h51), .shape_x(10'd81), .shape_y(10'd68)); 
	 addr_compute q3(.*,.ascii(8'h51), .shape_x(10'd243), .shape_y(10'd18)); 
	 addr_compute q4(.*,.ascii(8'h51), .shape_x(10'd243), .shape_y(10'd68)); 
	 addr_compute q5(.*,.ascii(8'h51), .shape_x(10'd403), .shape_y(10'd18)); 
	 addr_compute q6(.*,.ascii(8'h51), .shape_x(10'd403), .shape_y(10'd68)); 
	 addr_compute q7(.*,.ascii(8'h51), .shape_x(10'd563), .shape_y(10'd18)); 
	 addr_compute q8(.*,.ascii(8'h51), .shape_x(10'd563), .shape_y(10'd68)); 
	 addr_compute g1(.*,.ascii(8'h47), .shape_x(10'd81), .shape_y(10'd34)); 
	 addr_compute g2(.*,.ascii(8'h47), .shape_x(10'd81), .shape_y(10'd84)); 
	 addr_compute g3(.*,.ascii(8'h47), .shape_x(10'd243), .shape_y(10'd34)); 
	 addr_compute g4(.*,.ascii(8'h47), .shape_x(10'd243), .shape_y(10'd84)); 
	 addr_compute g5(.*,.ascii(8'h47), .shape_x(10'd403), .shape_y(10'd34)); 
	 addr_compute g6(.*,.ascii(8'h47), .shape_x(10'd403), .shape_y(10'd84)); 
	 addr_compute g7(.*,.ascii(8'h47), .shape_x(10'd563), .shape_y(10'd34)); 
	 addr_compute g8(.*,.ascii(8'h47), .shape_x(10'd563), .shape_y(10'd84)); 
	 addr_compute k(.*,.ascii(8'h6b), .shape_x(10'd320), .shape_y(10'd432)); 
	 addr_compute H(.*,.ascii(8'h48), .shape_x(10'd329), .shape_y(10'd432)); 
	 addr_compute z(.*,.ascii(8'h7a), .shape_x(10'd338), .shape_y(10'd432));
	 
	 
	 logic [7:0] vu_arr;
	 mux_1_8 value_updated_mux(.select(biquad_index), .data_in(load_coefficients), .data_out(vu_arr));
	 
	 ascii_string_4 T1(.*, .input_string_in(type_ascii), .load_string(vu_arr[0]), .shape_x(10'd25), .shape_y(10'd32));
	 ascii_string_4 F1(.*, .input_string_in(f_string), .load_string(vu_arr[0]), .shape_x(10'd97), .shape_y(10'd2));
	 ascii_string_4 Q1(.*, .input_string_in(q_string), .load_string(vu_arr[0]), .shape_x(10'd97), .shape_y(10'd18));
	 ascii_string_4 G1(.*, .input_string_in(g_string), .load_string(vu_arr[0]), .shape_x(10'd97), .shape_y(10'd34));
	 ascii_string_4 T2(.*, .input_string_in(type_ascii), .load_string(vu_arr[1]), .shape_x(10'd25), .shape_y(10'd80));
	 ascii_string_4 F2(.*, .input_string_in(f_string), .load_string(vu_arr[1]), .shape_x(10'd97), .shape_y(10'd52));
	 ascii_string_4 Q2(.*, .input_string_in(q_string), .load_string(vu_arr[1]), .shape_x(10'd97), .shape_y(10'd68));
	 ascii_string_4 G2(.*, .input_string_in(g_string), .load_string(vu_arr[1]), .shape_x(10'd97), .shape_y(10'd84));
	 ascii_string_4 T3(.*, .input_string_in(type_ascii), .load_string(vu_arr[2]), .shape_x(10'd185), .shape_y(10'd32));
	 ascii_string_4 F3(.*, .input_string_in(f_string), .load_string(vu_arr[2]), .shape_x(10'd257), .shape_y(10'd2));
	 ascii_string_4 Q3(.*, .input_string_in(q_string), .load_string(vu_arr[2]), .shape_x(10'd257), .shape_y(10'd18));
	 ascii_string_4 G3(.*, .input_string_in(g_string), .load_string(vu_arr[2]), .shape_x(10'd257), .shape_y(10'd34));
	 ascii_string_4 T4(.*, .input_string_in(type_ascii), .load_string(vu_arr[3]), .shape_x(10'd185), .shape_y(10'd80));
	 ascii_string_4 F4(.*, .input_string_in(f_string), .load_string(vu_arr[3]), .shape_x(10'd257), .shape_y(10'd52));
	 ascii_string_4 Q4(.*, .input_string_in(q_string), .load_string(vu_arr[3]), .shape_x(10'd257), .shape_y(10'd68));
	 ascii_string_4 G4(.*, .input_string_in(g_string), .load_string(vu_arr[3]), .shape_x(10'd257), .shape_y(10'd84));
	 ascii_string_4 T5(.*, .input_string_in(type_ascii), .load_string(vu_arr[4]), .shape_x(10'd345), .shape_y(10'd32));
	 ascii_string_4 F5(.*, .input_string_in(f_string), .load_string(vu_arr[4]), .shape_x(10'd417), .shape_y(10'd2));
	 ascii_string_4 Q5(.*, .input_string_in(q_string), .load_string(vu_arr[4]), .shape_x(10'd417), .shape_y(10'd18));
	 ascii_string_4 G5(.*, .input_string_in(g_string), .load_string(vu_arr[4]), .shape_x(10'd417), .shape_y(10'd34));
	 ascii_string_4 T6(.*, .input_string_in(type_ascii), .load_string(vu_arr[5]), .shape_x(10'd345), .shape_y(10'd80));
	 ascii_string_4 F6(.*, .input_string_in(f_string), .load_string(vu_arr[5]), .shape_x(10'd417), .shape_y(10'd52));
	 ascii_string_4 Q6(.*, .input_string_in(q_string), .load_string(vu_arr[5]), .shape_x(10'd417), .shape_y(10'd68));
	 ascii_string_4 G6(.*, .input_string_in(g_string), .load_string(vu_arr[5]), .shape_x(10'd417), .shape_y(10'd84));
	 ascii_string_4 T7(.*, .input_string_in(type_ascii), .load_string(vu_arr[6]), .shape_x(10'd505), .shape_y(10'd32));
	 ascii_string_4 F7(.*, .input_string_in(f_string), .load_string(vu_arr[6]), .shape_x(10'd577), .shape_y(10'd2));
	 ascii_string_4 Q7(.*, .input_string_in(q_string), .load_string(vu_arr[6]), .shape_x(10'd577), .shape_y(10'd18));
	 ascii_string_4 G7(.*, .input_string_in(g_string), .load_string(vu_arr[6]), .shape_x(10'd577), .shape_y(10'd34));
	 ascii_string_4 T8(.*, .input_string_in(type_ascii), .load_string(vu_arr[7]), .shape_x(10'd505), .shape_y(10'd80));
	 ascii_string_4 F8(.*, .input_string_in(f_string), .load_string(vu_arr[7]), .shape_x(10'd577), .shape_y(10'd52));
	 ascii_string_4 Q8(.*, .input_string_in(q_string), .load_string(vu_arr[7]), .shape_x(10'd577), .shape_y(10'd68));
	 ascii_string_4 G8(.*, .input_string_in(g_string), .load_string(vu_arr[7]), .shape_x(10'd577), .shape_y(10'd84));
	 ascii_string_4 PRES(.*, .input_string_in(32'h50524553), .load_string(1'b1), .shape_x(10'd492), .shape_y(10'd132));
	 ascii_string_4 S_EN(.*, .input_string_in(32'h5320454e), .load_string(1'b1), .shape_x(10'd524), .shape_y(10'd132));
	 ascii_string_4 TER_(.*, .input_string_in(32'h54455220), .load_string(1'b1), .shape_x(10'd556), .shape_y(10'd132));
	 ascii_string_4 BQ1_(.*, .input_string_in(32'h42512331), .load_string(1'b1), .shape_x(10'd2), .shape_y(10'd2));
	 ascii_string_4 BQ2_(.*, .input_string_in(32'h42512332), .load_string(1'b1), .shape_x(10'd2), .shape_y(10'd52));
	 ascii_string_4 BQ3_(.*, .input_string_in(32'h42512333), .load_string(1'b1), .shape_x(10'd162), .shape_y(10'd2));
	 ascii_string_4 BQ4_(.*, .input_string_in(32'h42512334), .load_string(1'b1), .shape_x(10'd162), .shape_y(10'd52));
	 ascii_string_4 BQ5_(.*, .input_string_in(32'h42512335), .load_string(1'b1), .shape_x(10'd322), .shape_y(10'd2));
	 ascii_string_4 BQ6_(.*, .input_string_in(32'h42512336), .load_string(1'b1), .shape_x(10'd322), .shape_y(10'd52));
	 ascii_string_4 BQ7_(.*, .input_string_in(32'h42512337), .load_string(1'b1), .shape_x(10'd482), .shape_y(10'd2));
	 ascii_string_4 BQ8_(.*, .input_string_in(32'h42512338), .load_string(1'b1), .shape_x(10'd482), .shape_y(10'd52));
	 ascii_string_2 Hz1_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd129), .shape_y(10'd2));
	 ascii_string_2 Hz2_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd129), .shape_y(10'd52));
	 ascii_string_2 Hz3_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd291), .shape_y(10'd2));
	 ascii_string_2 Hz4_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd291), .shape_y(10'd52));
	 ascii_string_2 Hz5_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd453), .shape_y(10'd2));
	 ascii_string_2 Hz6_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd453), .shape_y(10'd52));
	 ascii_string_2 Hz7_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd615), .shape_y(10'd2));
	 ascii_string_2 Hz8_(.*, .input_string_in(16'h487a), .load_string(1'b1), .shape_x(10'd615), .shape_y(10'd52));
	 ascii_string_2 dB1_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd129), .shape_y(10'd34));
	 ascii_string_2 dB2_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd129), .shape_y(10'd84));
	 ascii_string_2 dB3_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd291), .shape_y(10'd34));
	 ascii_string_2 dB4_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd291), .shape_y(10'd84));
	 ascii_string_2 dB5_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd453), .shape_y(10'd34));
	 ascii_string_2 dB6_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd453), .shape_y(10'd84));
	 ascii_string_2 dB7_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd615), .shape_y(10'd34));
	 ascii_string_2 dB8_(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd615), .shape_y(10'd84));
	 
	 //x-axis labels
	 ascii_string_2 tick20(.*, .input_string_in(16'h3230), .load_string(1'b1), .shape_x(10'd80), .shape_y(10'd422));
	 ascii_string_4 tick200(.*, .input_string_in(32'h32303000), .load_string(1'b1), .shape_x(10'd252), .shape_y(10'd422));
	 ascii_string_4 tick2000(.*, .input_string_in(32'h32303030), .load_string(1'b1), .shape_x(10'd424), .shape_y(10'd422));
	 ascii_string_4 tick20000(.*, .input_string_in(32'h32303030), .load_string(1'b1), .shape_x(10'd596), .shape_y(10'd422));
	 addr_compute zero(.*, .ascii(8'h30), .shape_x(10'd628), .shape_y(10'd422));
	 
	 //y-axis labels
	 ascii_string_2 dB(.*, .input_string_in(16'h6442), .load_string(1'b1), .shape_x(10'd2), .shape_y(10'd260));
	 ascii_string_2 toptick(.*, .input_string_in(16'h3130), .load_string(1'b1), .shape_x(10'd60), .shape_y(10'd144));
	 ascii_string_2 zerotick(.*, .input_string_in(16'h3030), .load_string(1'b1), .shape_x(10'd60), .shape_y(10'd209));
	 ascii_string_4 minusten(.*, .input_string_in(32'h002d3130), .load_string(1'b1), .shape_x(10'd44), .shape_y(10'd274));
	 ascii_string_4 minus20(.*, .input_string_in(32'h002d3230), .load_string(1'b1), .shape_x(10'd44), .shape_y(10'd339));
	 ascii_string_4 minus30(.*, .input_string_in(32'h002d3330), .load_string(1'b1), .shape_x(10'd44), .shape_y(10'd404)); 
	 
	 ascii_string_48 prompt(.*, .input_string_in(prompt_ascii), .shape_x(10'd100), .shape_y(10'd132));
	 	 	
	 font_rom rom(.addr(sprite_addr), .data(sprite_data));
         
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
	 

// Coloring 
    always_comb
    begin : RGB_Display
				// White lines
		  if (DrawY == 10'd50) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
        else if (DrawY == 10'd100) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
		  else if (DrawX == 10'd320 && DrawY <= 10'd100) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
		  else if (DrawX == 10'd160 && DrawY <= 10'd100) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
		  else if (DrawX == 10'd480 && DrawY <= 10'd100) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			//X-ticks
			else if (DrawX == 10'd80 && DrawY >= 10'd417 && DrawY <= 10'd423) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (DrawX == 10'd252 && DrawY >= 10'd417 && DrawY <= 10'd423) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (DrawX == 10'd424 && DrawY >= 10'd417 && DrawY <= 10'd423) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (DrawX == 10'd596 && DrawY >= 10'd417 && DrawY <= 10'd423) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			//Y-ticks
			else if (graph_lookup_y == 10'd255 && DrawX >=10'd77 && DrawX <= 10'd83) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (graph_lookup_y == 10'd191 && DrawX >=10'd77 && DrawX <= 10'd83) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (graph_lookup_y == 10'd127 && DrawX >=10'd77 && DrawX <= 10'd83) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (graph_lookup_y == 10'd63 && DrawX >=10'd77 && DrawX <= 10'd83) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			else if (graph_lookup_y == 10'd00 && DrawX >=10'd77 && DrawX <= 10'd83) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
			// Graph
		  else if ((DrawX >= 10'd80 && DrawX <= 10'd596) && (DrawY >= 10'd165 && DrawY <= 10'd420)) begin
				if (show_graph && (graph_value == graph_lookup_y[7:0])) begin // Found a graph node
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
				end
		      else if (DrawX == 10'd80) begin // Y axis
					Red = 8'h55;
					Green = 8'h55;
					Blue = 8'h55;
					end
			   else if (DrawY == 10'd420) begin // X axis
					Red = 8'h55;
					Green = 8'h55;
					Blue = 8'h55;
					end
				else begin
					Red = 8'hff;
					Green = 8'hff;
					Blue = 8'hff;
				end
			end
			//Sprite Drawer		
		 else if ((sprite_on == 1'b1) && sprite_data[u_shape_x - DrawX + 8'd8] == 1'b1) begin
					Red =  8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
		 
			// Background		
		  else
        begin
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end	
		  
		  case (type_index)
				default: begin
					type_ascii = 32'h4e554c4c; //NULL
					end
				3'd1: begin
					type_ascii = 32'h504b4551; //PKEQ
					end
				3'd2: begin
					type_ascii = 32'h4c534846; //LSHF
					end
				3'd3: begin
					type_ascii = 32'h48534846; //HSHF
					end
				3'd4 : begin
					type_ascii = 32'h204c5046; //_LPF
					end
				3'd5: begin
					type_ascii = 32'h20485046; //_HPF
					end
			endcase
			case (to_hw_sig)
				default: begin
					//Generating Graph...
					prompt_ascii = 384'h47454e45524154494e472047524150482e2e2e0000000000000000000000000000000000000000000000000000000000;
				end
				4'd15: begin
					//choose filter 1-peq etc
					prompt_ascii = 384'h5049434b2046494c54455220312d50455120322d4c53484620332d48534c4620342d4c504620352d4850462e2e2e0000;
					end
				4'd8: begin
					//pick biquad 1-8
					prompt_ascii = 384'h53454c454354204249515541442023312d382e2e2e000000000000000000000000000000000000000000000000000000;
					end
				4'd14: begin
					//enter center frequency
					prompt_ascii = 384'h454e5445522043454e544552204652455155454e43592e2e2e0000000000000000000000000000000000000000000000;
					end
				4'd13: begin
					//please select filter 1-5
					prompt_ascii = 384'h504c454153452053454c4543542046494c54455220312d352e2e2e000000000000000000000000000000000000000000;
					end
				4'd12: begin
					//input q factor
					prompt_ascii = 384'h494e50555420512d464143544f522e2e2e00000000000000000000000000000000000000000000000000000000000000;
					end
				4'd11: begin
					//select frequency between 20-20000
					prompt_ascii = 384'h53454c454354204652455155454e4359204254574e20323020414e442032303030302e2e2e0000000000000000000000;
					end
				4'd10: begin
					//Enter the Gain
					prompt_ascii = 384'h454e544552204741494e204f462046494c5445522e2e2e00000000000000000000000000000000000000000000000000;
					end
				4'd9: begin
					//please select non-negative q factor less than 20
					prompt_ascii = 384'h53454c4543542041204e4f4e2d4e4547415449564520512d464143544f52203c2032302e2e2e00000000000000000000;
					end
				4'd7: begin
					//intializing 
					prompt_ascii = 384'h494e495449414c495a494e472e2e2e000000000000000000000000000000000000000000000000000000000000000000;
					end
				4'd6: begin
					//press e to edit filters
					prompt_ascii = 384'h5052455353204520544f20454449542046494c544552532e2e2e00000000000000000000000000000000000000000000;
					end
			endcase
		end
endmodule
