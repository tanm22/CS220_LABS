`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:35 01/17/2024 
// Design Name: 
// Module Name:    myxor 
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
module myxor(x, y, z);
input x;
input y;
output z;
wire z;
assign z = (x & ~y) | (~x & y);
endmodule
