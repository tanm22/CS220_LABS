`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:09 03/11/2024 
// Design Name: 
// Module Name:    min_comparator 
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
module min_comparator(A,B,C,D,index);

input[2:0] A,B,C,D;
output[1:0] index;
reg index;

always @(A, B, C, D) begin
	if(D<C) begin
		if(D<B) begin
			if(D<A) begin
				index <= 3;
			end
			else begin
				index <= 0;
			end
		end
		else begin
			if(B<A) begin
				index <= 1;
			end
			else begin
				index <= 0;
			end
		end
	end
	else begin
		if(C<B) begin
			if(C<A) begin
				index <= 2;
			end
			else begin
				index <= 0;
			end
		end
		else begin
			if(B<A) begin
				index <= 1;
			end
			else begin
				index <= 0;
			end
		end
	end
end

endmodule