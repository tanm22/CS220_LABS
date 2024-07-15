`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:42 01/24/2024 
// Design Name: 
// Module Name:    seven_bit_adder 
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
module full_adder(a, b, cin, sum, cout);

input a;

input b;

input cin;

output sum;

wire sum;

output cout;

wire cout;

assign sum = a^b^cin;

assign cout = (a & b) | (b & cin) | (cin & a);

endmodule

module seven_bit_adder(PB1,PB2,PB3,PB4,Y,sum,cout);
 
 input PB1,PB2,PB3,PB4;

 input [3:0] Y;

 output[6:0] sum;

 output cout;

 wire [6:0] sum;

 wire cout;

 wire temp[5:0];

 reg [6:0] A;

 reg [6:0] B;
 

 always @(posedge PB1)begin

  A[3:0]<=Y;

 end

 always @(posedge PB2)begin

  A[6:4]<=Y[2:0];

 end

 always @(posedge PB3)begin

  B[3:0]<=Y;

 end

 always @(posedge PB4)begin

  B[6:4]<=Y[2:0];

 end

 full_adder FA0 (A[0], B[0], 1'b0, sum[0], temp[0]);

 full_adder FA1 (A[1], B[1], temp[0], sum[1], temp[1]);

 full_adder FA2 (A[2], B[2], temp[1], sum[2], temp[2]);

 full_adder FA3 (A[3], B[3], temp[2], sum[3], temp[3]);

 full_adder FA4 (A[4], B[4], temp[3], sum[4], temp[4]);

 full_adder FA5 (A[5], B[5], temp[4], sum[5], temp[5]);

 full_adder FA6 (A[6],B[6], temp[5], sum[6], cout);

endmodule