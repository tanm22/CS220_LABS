`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:46 03/11/2024 
// Design Name: 
// Module Name:    lcd_top 
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
module lcd_top(clk, x, PB, lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4);

input clk;
input [2:0] x;
input [3:0] PB;
output lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4;
wire lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4;
reg [2:0] A, B, C, D;
wire [1:0] index;

reg [7:0] ascii[7:0]; 
initial begin
	ascii[0] = 8'd48;
	ascii[1] = 8'd49;
	ascii[2] = 8'd50;
	ascii[3] = 8'd51;
	ascii[4] = 8'd52;
	ascii[5] = 8'd53;
	ascii[6] = 8'd54;
	ascii[7] = 8'd55;
end
reg [0:127] fl;
reg [0:127] sl;

always@(posedge PB[0]) begin
	A <= x;
end
always@(posedge PB[1]) begin
	B <= x;
end
always@(posedge PB[2]) begin
	C <= x;
end
always@(posedge PB[3]) begin
	D <= x;
end
min_comparator MIN(A, B, C, D, index);

always@(posedge clk) begin
	fl <= {ascii[A], 8'd44, 8'd32, ascii[B], 8'd44, 8'd32, ascii[C], 8'd44, 8'd32, ascii[D], 48'd0};
	if(index == 0) begin
		sl <= {ascii[0], 120'd0};
	end
	else if(index == 1) begin
		sl <= {ascii[1], 120'd0};
	end
	else if(index == 2) begin
		sl <= {ascii[2], 120'd0};
	end
	else begin
		sl <= {ascii[3], 120'd0};
	end
end

lcd LCD (fl, sl, clk, lcd_rs, lcd_rw, lcd_e, d1, d2, d3, d4);

endmodule