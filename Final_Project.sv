module Final_Project( input      CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             input	     [1:0] SW,
             input               AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK,
             output logic        AUD_DACDAT, AUD_XCK, I2C_SCLK, I2C_SDAT,
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );

logic Reset_h, Clk;
logic signed [17:0] coefficient, b0, b1, b2, a1, a2;
logic [2:0] biquad_index, type_index;
logic [1:0] to_sw_sig;
logic [3:0] to_hw_sig;
logic [31:0] f_string, g_string, q_string;

logic [9:0] BallX, BallY, BallS, DrawX, DrawY;

logic [9:0] waddr, raddr;
logic [7:0] wdata, rdata;
logic we, show_graph;

assign Clk = CLOCK_50;
assign {Reset_h} = ~(KEY[0]);  // The push buttons are active low

logic [1:0] hpi_addr;
logic [15:0] hpi_data_in, hpi_data_out;
logic hpi_r, hpi_w,hpi_cs;
logic DSP_ENABLE, LC_ENABLE, load_coefficients, coefficients_updated;

always_ff @ (posedge Clk) begin
	DSP_ENABLE <= SW[0];
	LC_ENABLE <= SW[1];
end

audio_controller ac(.*, .Reset(Reset_h));

// Interface between NIOS II and EZ-OTG chip
hpi_io_intf hpi_io_inst(.Clk(Clk),
							   .Reset(Reset_h),
							   // signals connected to NIOS II
							   .from_sw_address(hpi_addr),
							   .from_sw_data_in(hpi_data_in),
							   .from_sw_data_out(hpi_data_out),
							   .from_sw_r(hpi_r),
							   .from_sw_w(hpi_w),
							   .from_sw_cs(hpi_cs),
							   // signals connected to EZ-OTG chip
							   .OTG_DATA(OTG_DATA),    
							   .OTG_ADDR(OTG_ADDR),    
							   .OTG_RD_N(OTG_RD_N),    
							   .OTG_WR_N(OTG_WR_N),    
							   .OTG_CS_N(OTG_CS_N),    
							   .OTG_RST_N(OTG_RST_N)
);
 
 //The connections for nios_system might be named different depending on how you set up Qsys
 nios_system nios_system(.clk_clk(Clk),         
								 .reset_reset_n(KEY[0]),   
							    .sdram_wire_addr(DRAM_ADDR), 
							    .sdram_wire_ba(DRAM_BA),   
							    .sdram_wire_cas_n(DRAM_CAS_N),
							    .sdram_wire_cke(DRAM_CKE),  
						  	    .sdram_wire_cs_n(DRAM_CS_N), 
							    .sdram_wire_dq(DRAM_DQ),   
							    .sdram_wire_dqm(DRAM_DQM),  
							    .sdram_wire_ras_n(DRAM_RAS_N),
							    .sdram_wire_we_n(DRAM_WE_N), 
							    .sdram_clk_clk(DRAM_CLK),
							    .otg_hpi_address_export(hpi_addr),
							    .otg_hpi_data_in_port(hpi_data_in),
							    .otg_hpi_data_out_port(hpi_data_out),
							    .otg_hpi_cs_export(hpi_cs),
							    .otg_hpi_r_export(hpi_r),
							    .otg_hpi_w_export(hpi_w),
							    .biquad_index_export(biquad_index),
								 .f_string_export(f_string),
								 .g_string_export(g_string),
								 .q_string_export(q_string),
								 .type_index_export(type_index),
							    .coefficient_export(coefficient),
							    .to_hw_sig_export(to_hw_sig),
							    .to_sw_sig_export(to_sw_sig)
);

logic [3:0] state;
io_controller io_controller(.Clk, .Reset(Reset_h),
								    .to_sw_sig, .to_hw_sig,
								    .coefficient, .show_graph,
									 .load_graph_ram(we), .waddr, .wdata,
									 .load_coefficients, .coefficients_updated,
								    .b0, .b1, .b2, .a1, .a2, .state_out(state)
);

graph_ram graph_ram(.clk(Clk), .we, .waddr, .raddr,
						  .wdata, .q(rdata));

VGA_controller vga_controller_instance(.*, .Reset(Reset_h));
 
color_mapper color_instance(.*, .Reset(Reset_h),
									 .load_coefficients,
									 .graph_value(rdata),
									 .graph_lookup_x(raddr));
 
HexDriver hex_inst_7 (coefficient[17:16], HEX7);
HexDriver hex_inst_6 (coefficient[15:12], HEX6);
HexDriver hex_inst_5 (coefficient[11:8], HEX5);
HexDriver hex_inst_4 (coefficient[7:4], HEX4);
HexDriver hex_inst_3 (coefficient[3:0], HEX3);
HexDriver hex_inst_2 (4'd0, HEX2);
HexDriver hex_inst_1 (4'd0, HEX1);
HexDriver hex_inst_0 (state, HEX0);
endmodule
