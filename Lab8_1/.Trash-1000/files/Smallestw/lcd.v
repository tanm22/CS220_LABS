`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:19 03/11/2024 
// Design Name: 
// Module Name:    lcd 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lcd(fl,sl,clk,lcd_rs,lcd_rw,lcd_e,d1,d2,d3,d4 );

	input [0:127] fl;
	input [0:127] sl;
	input clk;
	output lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4;
	reg lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4;

	reg [7:0] fl_index = 0;
	reg [1:0] fl_state = 3;
	 
	reg [7:0] sl_index = 0;
	reg [1:0] sl_state = 3;
	 
	reg [31:0] counter = 500000000;
	reg [2:0] next_state = 0;
	 
	reg [2:0] line_break_state = 7;
	 
	reg [5:0] init_ROM [0:13];
	reg [3:0] init_ROM_index = 0;
	
	initial begin
		init_ROM[0] = 6'h03;
		init_ROM[1] = 6'h03;
		init_ROM[2] = 6'h03;
		init_ROM[3] = 6'h02;
		init_ROM[4] = 6'h02;
		init_ROM[5] = 6'h08;
		init_ROM[6] = 6'h00;
		init_ROM[7] = 6'h06;
		init_ROM[8] = 6'h00;
		init_ROM[9] = 6'h0c;
		init_ROM[10] = 6'h00;
		init_ROM[11] = 6'h01;
		init_ROM[12] = 6'h08;
		init_ROM[13] = 6'h00;
	end
	
	always @ (posedge clk) begin
	   	if (counter == 0) begin
		   	counter <= 1000000;
				
			if (init_ROM_index == 14) begin
				next_state <= 4;
				init_ROM_index <= 0;
				fl_state <= 0;
			end
					
			if ((next_state != 4) && (init_ROM_index != 14)) begin
			  	case (next_state)
			    		0: begin
							lcd_e <= 0;
							next_state <= 1;
               	end
					
                  1: begin
							{lcd_rs, lcd_rw, d4, d3, d2, d1} <= init_ROM[init_ROM_index];
							next_state <= 2;
			    		end
					
			    		2: begin
							lcd_e <= 1;
							next_state <= 3;
			    		end
					
			    		3: begin
							lcd_e <= 0;
							next_state <= 1;
							init_ROM_index <= init_ROM_index + 1;
			    		end
			  	endcase
			end
			
			if (fl_index == 128) begin
				fl_state <= 3;
				fl_index <= 0;
				line_break_state <= 0;
			end
			if ((fl_state != 3) && (fl_index != 128)) begin
				case (fl_state)
					0: begin
						{lcd_rs, lcd_rw, d4, d3, d2, d1} <= {2'h2,fl[fl_index],fl[fl_index+1],fl[fl_index+2],fl[fl_index+3]};
						fl_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						fl_state <= 2;
					end
					
					2: begin
						lcd_e <= 0;
						fl_state <= 0;
						fl_index <= fl_index+4;
					end
				endcase
			end
			
			if (line_break_state != 7) begin
				case (line_break_state)
					0: begin
						{lcd_rs, lcd_rw, d4, d3, d2, d1} <= 6'h0c;
						line_break_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						line_break_state <= 2;
					end
						
					2: begin
						lcd_e <= 0;
						line_break_state <= 3;
					end
						
					3: begin
						{lcd_rs, lcd_rw, d4, d3, d2, d1} <= 6'h00;
						line_break_state <= 4;
					end
						
					4: begin
						lcd_e <= 1;
						line_break_state <= 5;
					end
						
					5: begin
						lcd_e <= 0;
						line_break_state <= 7;
						sl_state <= 0;
					end
				endcase
			end
			
			if (sl_index == 128) begin
				sl_state <= 3;
				sl_index <= 0;
			end
			if ((sl_state != 3) && (sl_index != 128)) begin
				case (sl_state)
					0: begin
						{lcd_rs, lcd_rw, d4, d3, d2, d1} <= {2'h2,sl[sl_index],sl[sl_index+1],sl[sl_index+2],sl[sl_index+3]};
						sl_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						sl_state <= 2;
					end
					
					2: begin
						lcd_e <= 0;
						sl_state <= 0;
						sl_index <= sl_index+4;
					end
				endcase
			end
		end
		else 
		begin 
		   	counter <= counter - 1;
		end
	end
	
endmodule