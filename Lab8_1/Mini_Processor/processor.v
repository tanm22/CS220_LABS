`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:04 03/26/2019 
// Design Name: 
// Module Name:    processor 
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
module processor(clk, rot_event, y, PB, lcd_rs, lcd_w, lcd_e, d);

// I/O variables
input clk, rot_event;
input [3:0] y;
input [2:0] PB;
output lcd_rs, lcd_w, lcd_e;
output [3:0] d;
wire lcd_rs, lcd_w, lcd_e;
wire [3:0] d;

// My Register file
reg [15:0] register[0:31];

// Extra Variables needed
reg prev_rot_event = 1;
// Addresses
reg [4:0] RAddr0 = 0;
reg [4:0] RAddr2 = 0; 
reg [4:0] WAddr = 0;
// ds'
reg [15:0] Rd1 = 0; 
reg [15:0] Rd2 = 0; 
reg [15:0] Wd = 0; 

reg [2:0] instruction = 0;
reg [3:0] step = 0;

reg [3:0] shift = 0;

reg [127:0] L1 = "                ";
reg [127:0] L2 = "                ";

initial begin
	register[0] <= 0; register[8] <= 0; register[16] <= 0; register[24] <= 0;
	register[1] <= 0; register[9] <= 0; register[17] <= 0; register[25] <= 0;
	register[2] <= 0; register[10] <= 0; register[18] <= 0; register[26] <= 0;
	register[3] <= 0; register[11] <= 0; register[19] <= 0; register[27] <= 0;
	register[4] <= 0; register[12] <= 0; register[20] <= 0; register[28] <= 0;
	register[5] <= 0; register[13] <= 0; register[21] <= 0; register[29] <= 0;
	register[6] <= 0; register[14] <= 0; register[22] <= 0; register[30] <= 0;
	register[7] <= 0; register[15] <= 0; register[23] <= 0; register[31] <= 0;
end









always @(posedge clk) begin

	if(PB[1]) step<=0;
	
	// To Select the instruction to be given
	if(PB[0]) instruction <= y[2:0];
	
	// To Restart the whole process (or) RESET the resister_file
	if(PB[2]) begin
		register[0] <= 0; register[8] <= 0; register[16] <= 0; register[24] <= 0;
		register[1] <= 0; register[9] <= 0; register[17] <= 0; register[25] <= 0;
		register[2] <= 0; register[10] <= 0; register[18] <= 0; register[26] <= 0;
		register[3] <= 0; register[11] <= 0; register[19] <= 0; register[27] <= 0;
		register[4] <= 0; register[12] <= 0; register[20] <= 0; register[28] <= 0;
		register[5] <= 0; register[13] <= 0; register[21] <= 0; register[29] <= 0;
		register[6] <= 0; register[14] <= 0; register[22] <= 0; register[30] <= 0;
		register[7] <= 0; register[15] <= 0; register[23] <= 0; register[31] <= 0;
	end
	if(~prev_rot_event & rot_event) begin
		case(instruction)
		0: begin
				case(step)
				0: begin
						WAddr[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						WAddr[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						Wd[15:12] <= y;
						step <= step + 1;
					end
				3: begin
						Wd[11:8] <= y;
						step <= step + 1;
					end
				4: begin
						Wd[7:4] <= y;
						step <= step + 1;
					end
				5: begin
						Wd[3:0] <= y;
						step <= step + 1;
					end
				6: begin
						register[WAddr] <= Wd;
						step <= step + 1;
					end
				7: begin
						
						L1[127:120] <= WAddr[4] + 48; 
						L1[119:112] <= WAddr[3] + 48;
						L1[111:104] <= WAddr[2] + 48;
						L1[103:96] <= WAddr[1] + 48;
						L1[95:88] <= WAddr[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Wd[15] + 48;	L2[63:56] <= Wd[7] + 48;
						L2[119:112] <= Wd[14] + 48;	L2[55:48] <= Wd[6] + 48;
						L2[111:104] <= Wd[13] + 48;	L2[47:40] <= Wd[5] + 48;
						L2[103:96] <= Wd[12] + 48;	L2[39:32] <= Wd[4] + 48;
						L2[95:88] <= Wd[11] + 48;	L2[31:24] <= Wd[3] + 48;
						L2[87:80] <= Wd[10] + 48;	L2[23:16] <= Wd[2] + 48;
						L2[79:72] <= Wd[9] + 48;	L2[15:8] <= Wd[1] + 48;
						L2[71:64] <= Wd[8] + 48;	L2[7:0] <= Wd[0] + 48;
						step <= 0;
					end
				endcase
			end
		1: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						Rd1 <= register[RAddr0];
						step <= step + 1;
					end
				3: begin
						
						
						L1[127:120] <= RAddr0[4] + 48; 
						L1[119:112] <= RAddr0[3] + 48;
						L1[111:104] <= RAddr0[2] + 48;
						L1[103:96] <= RAddr0[1] + 48;
						L1[95:88] <= RAddr0[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Rd1[15] + 48;	L2[63:56] <= Rd1[7] + 48;
						L2[119:112] <= Rd1[14] + 48;	L2[55:48] <= Rd1[6] + 48;
						L2[111:104] <= Rd1[13] + 48;	L2[47:40] <= Rd1[5] + 48;
						L2[103:96] <= Rd1[12] + 48;	L2[39:32] <= Rd1[4] + 48;
						L2[95:88] <= Rd1[11] + 48;	L2[31:24] <= Rd1[3] + 48;
						L2[87:80] <= Rd1[10] + 48;	L2[23:16] <= Rd1[2] + 48;
						L2[79:72] <= Rd1[9] + 48;	L2[15:8] <= Rd1[1] + 48;
						L2[71:64] <= Rd1[8] + 48;	L2[7:0] <= Rd1[0] + 48;
						step <= 0;
					end
				endcase
			end
		2: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						RAddr2[4:1] <= y;
						step <= step + 1;
					end
				3: begin
						RAddr2[0] <= y[0];
						step <= step + 1;
					end
				4: begin
						Rd1 <= register[RAddr0];
						Rd2 <= register[RAddr2];
						step <= step + 1;
					end
				5: begin
						
						
						L1[127:120] <= Rd1[15] + 48;	L1[63:56] <= Rd1[7] + 48;
						L1[119:112] <= Rd1[14] + 48;	L1[55:48] <= Rd1[6] + 48;
						L1[111:104] <= Rd1[13] + 48;	L1[47:40] <= Rd1[5] + 48;
						L1[103:96] <= Rd1[12] + 48;	L1[39:32] <= Rd1[4] + 48;
						L1[95:88] <= Rd1[11] + 48;	L1[31:24] <= Rd1[3] + 48;
						L1[87:80] <= Rd1[10] + 48;	L1[23:16] <= Rd1[2] + 48;
						L1[79:72] <= Rd1[9] + 48;	L1[15:8] <= Rd1[1] + 48;
						L1[71:64] <= Rd1[8] + 48;	L1[7:0] <= Rd1[0] + 48;
						
						L2[127:120] <= Rd2[15] + 48;	L2[63:56] <= Rd2[7] + 48;
						L2[119:112] <= Rd2[14] + 48;	L2[55:48] <= Rd2[6] + 48;
						L2[111:104] <= Rd2[13] + 48;	L2[47:40] <= Rd2[5] + 48;
						L2[103:96] <= Rd2[12] + 48;	L2[39:32] <= Rd2[4] + 48;
						L2[95:88] <= Rd2[11] + 48;	L2[31:24] <= Rd2[3] + 48;
						L2[87:80] <= Rd2[10] + 48;	L2[23:16] <= Rd2[2] + 48;
						L2[79:72] <= Rd2[9] + 48;	L2[15:8] <= Rd2[1] + 48;
						L2[71:64] <= Rd2[8] + 48;	L2[7:0] <= Rd2[0] + 48;
						step <= 0;
					end
				endcase
			end
		3: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						WAddr[4:1] <= y;
						step <= step + 1;
					end
				3: begin
						WAddr[0] <= y[0];
						step <= step + 1;
					end
				4: begin
						Wd[15:12] <= y;
						step <= step + 1;
					end
				5: begin
						Wd[11:8] <= y;
						step <= step + 1;
					end
				6: begin
						Wd[7:4] <= y;
						step <= step + 1;
					end
				7: begin
						Wd[3:0] <= y;
						step <= step + 1;
					end
				8: begin
						Rd1 <= register[RAddr0];
						register[WAddr] <= Wd;
						step <= step + 1;
					end
				9: begin
						 
						
						L1[127:120] <= RAddr0[4] + 48; 
						L1[119:112] <= RAddr0[3] + 48;
						L1[111:104] <= RAddr0[2] + 48;
						L1[103:96] <= RAddr0[1] + 48;
						L1[95:88] <= RAddr0[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Rd1[15] + 48;	L2[63:56] <= Rd1[7] + 48;
						L2[119:112] <= Rd1[14] + 48;	L2[55:48] <= Rd1[6] + 48;
						L2[111:104] <= Rd1[13] + 48;	L2[47:40] <= Rd1[5] + 48;
						L2[103:96] <= Rd1[12] + 48;	L2[39:32] <= Rd1[4] + 48;
						L2[95:88] <= Rd1[11] + 48;	L2[31:24] <= Rd1[3] + 48;
						L2[87:80] <= Rd1[10] + 48;	L2[23:16] <= Rd1[2] + 48;
						L2[79:72] <= Rd1[9] + 48;	L2[15:8] <= Rd1[1] + 48;
						L2[71:64] <= Rd1[8] + 48;	L2[7:0] <= Rd1[0] + 48;
						step <= 0;
					end
				endcase
			end
		4: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						RAddr2[4:1] <= y;
						step <= step + 1;
					end
				3: begin
						RAddr2[0] <= y[0];
						step <= step + 1;
					end
				4: begin
						WAddr[4:1] <= y;
						step <= step + 1;
					end
				5: begin
						WAddr[0] <= y[0];
						step <= step + 1;
					end
				6: begin
						Wd[15:12] <= y;
						step <= step + 1;
					end
				7: begin
						Wd[11:8] <= y;
						step <= step + 1;
					end
				8: begin
						Wd[7:4] <= y;
						step <= step + 1;
					end
				9: begin
						Wd[3:0] <= y;
						step <= step + 1;
					end
				10: begin
						register[WAddr] <= Wd;
						
						Rd1 <= register[RAddr0];
						Rd2 <= register[RAddr2];
						step <= step + 1;
					end
				11: begin
						
						
						L1[127:120] <= Rd1[15] + 48;	L1[63:56] <= Rd1[7] + 48;
						L1[119:112] <= Rd1[14] + 48;	L1[55:48] <= Rd1[6] + 48;
						L1[111:104] <= Rd1[13] + 48;	L1[47:40] <= Rd1[5] + 48;
						L1[103:96] <= Rd1[12] + 48;	L1[39:32] <= Rd1[4] + 48;
						L1[95:88] <= Rd1[11] + 48;	L1[31:24] <= Rd1[3] + 48;
						L1[87:80] <= Rd1[10] + 48;	L1[23:16] <= Rd1[2] + 48;
						L1[79:72] <= Rd1[9] + 48;	L1[15:8] <= Rd1[1] + 48;
						L1[71:64] <= Rd1[8] + 48;	L1[7:0] <= Rd1[0] + 48;
						
						L2[127:120] <= Rd2[15] + 48;	L2[63:56] <= Rd2[7] + 48;
						L2[119:112] <= Rd2[14] + 48;	L2[55:48] <= Rd2[6] + 48;
						L2[111:104] <= Rd2[13] + 48;	L2[47:40] <= Rd2[5] + 48;
						L2[103:96] <= Rd2[12] + 48;	L2[39:32] <= Rd2[4] + 48;
						L2[95:88] <= Rd2[11] + 48;	L2[31:24] <= Rd2[3] + 48;
						L2[87:80] <= Rd2[10] + 48;	L2[23:16] <= Rd2[2] + 48;
						L2[79:72] <= Rd2[9] + 48;	L2[15:8] <= Rd2[1] + 48;
						L2[71:64] <= Rd2[8] + 48;	L2[7:0] <= Rd2[0] + 48;
						step <= 0;
					end
				endcase
			end
		5: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						RAddr2[4:1] <= y;
						Rd1 <= register[RAddr0];
						step <= step + 1;
					end
				3: begin
						RAddr2[0] <= y[0];
						step <= step + 1;
					end
				4: begin
						WAddr[4:1] <= y;
						
						Rd2 <= register[RAddr2];
						step <= step + 1;
					end
				5: begin
						WAddr[0] <= y[0];
						if($signed(Rd1) < $signed(Rd2)) Wd <= 1;
						else Wd <= 0;
						step <= step + 1;
					end
				6: begin
						
						
						
						
						register[WAddr] <= Wd;
						
						L1[127:120] <= WAddr[4] + 48; 
						L1[119:112] <= WAddr[3] + 48;
						L1[111:104] <= WAddr[2] + 48;
						L1[103:96] <= WAddr[1] + 48;
						L1[95:88] <= WAddr[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Wd[15] + 48;	L2[63:56] <= Wd[7] + 48;
						L2[119:112] <= Wd[14] + 48;	L2[55:48] <= Wd[6] + 48;
						L2[111:104] <= Wd[13] + 48;	L2[47:40] <= Wd[5] + 48;
						L2[103:96] <= Wd[12] + 48;	L2[39:32] <= Wd[4] + 48;
						L2[95:88] <= Wd[11] + 48;	L2[31:24] <= Wd[3] + 48;
						L2[87:80] <= Wd[10] + 48;	L2[23:16] <= Wd[2] + 48;
						L2[79:72] <= Wd[9] + 48;	L2[15:8] <= Wd[1] + 48;
						L2[71:64] <= Wd[8] + 48;	L2[7:0] <= Wd[0] + 48;
						step <= 0;
					end
				endcase
			end
		6: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						Rd1 <= register[RAddr0];
						RAddr2[4:1] <= y;
						step <= step + 1;
					end
				3: begin
						RAddr2[0] <= y[0];
						step <= step + 1;
					end
				4: begin
						Rd2 <= register[RAddr2];
						WAddr[4:1] <= y;
						step <= step + 1;
					end
				5: begin
						WAddr[0] <= y[0];
						Wd <= Rd1 ^ Rd2;
						step <= step + 1;
					end
				6: begin
						
						
						
						
						
						register[WAddr] <= Wd;
						
						L1[127:120] <= WAddr[4] + 48; 
						L1[119:112] <= WAddr[3] + 48;
						L1[111:104] <= WAddr[2] + 48;
						L1[103:96] <= WAddr[1] + 48;
						L1[95:88] <= WAddr[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Wd[15] + 48;	L2[63:56] <= Wd[7] + 48;
						L2[119:112] <= Wd[14] + 48;	L2[55:48] <= Wd[6] + 48;
						L2[111:104] <= Wd[13] + 48;	L2[47:40] <= Wd[5] + 48;
						L2[103:96] <= Wd[12] + 48;	L2[39:32] <= Wd[4] + 48;
						L2[95:88] <= Wd[11] + 48;	L2[31:24] <= Wd[3] + 48;
						L2[87:80] <= Wd[10] + 48;	L2[23:16] <= Wd[2] + 48;
						L2[79:72] <= Wd[9] + 48;	L2[15:8] <= Wd[1] + 48;
						L2[71:64] <= Wd[8] + 48;	L2[7:0] <= Wd[0] + 48;
						step <= 0;
					end
				endcase
			end
		7: begin
				case(step)
				0: begin
						RAddr0[4:1] <= y;
						step <= step + 1;
					end
				1: begin
						RAddr0[0] <= y[0];
						step <= step + 1;
					end
				2: begin
						WAddr[4:1] <= y;
						Rd1 <= register[RAddr0];
						step <= step + 1;
					end
				3: begin
						WAddr[0] <= y[0];
						step <= step + 1;
					end
				4: begin 
						shift <= y;
						step <= step + 1;
					end
				5: begin 
						Wd <= $signed(Rd1) >>> shift;
						step <= step + 1;
					end
				6: begin
						
						register[WAddr] <= Wd;
						
						L1[127:120] <= WAddr[4] + 48; 
						L1[119:112] <= WAddr[3] + 48;
						L1[111:104] <= WAddr[2] + 48;
						L1[103:96] <= WAddr[1] + 48;
						L1[95:88] <= WAddr[0] + 48;
						L1[87:0] <= "           ";
						
						L2[127:120] <= Wd[15] + 48;	L2[63:56] <= Wd[7] + 48;
						L2[119:112] <= Wd[14] + 48;	L2[55:48] <= Wd[6] + 48;
						L2[111:104] <= Wd[13] + 48;	L2[47:40] <= Wd[5] + 48;
						L2[103:96] <= Wd[12] + 48;	L2[39:32] <= Wd[4] + 48;
						L2[95:88] <= Wd[11] + 48;	L2[31:24] <= Wd[3] + 48;
						L2[87:80] <= Wd[10] + 48;	L2[23:16] <= Wd[2] + 48;
						L2[79:72] <= Wd[9] + 48;	L2[15:8] <= Wd[1] + 48;
						L2[71:64] <= Wd[8] + 48;	L2[7:0] <= Wd[0] + 48;
						step <= 0;
					end
				endcase
			end
		endcase
	end
	
	prev_rot_event <= rot_event;
end

lcd_driver L1(L1, L2, clk, lcd_rs, lcd_w, lcd_e, d);

endmodule
