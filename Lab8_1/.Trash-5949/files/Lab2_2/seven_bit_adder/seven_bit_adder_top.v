`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:05:25 01/24/2024
// Design Name:   seven_bit_adder
// Module Name:   /users/btech/dakshkscse/Desktop/CS220Labs/Lab2_2/seven_bit_adder/seven_bit_adder_top.v
// Project Name:  seven_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module seven_bit_adder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] Y;
	reg carry;

	// Outputs
	wire [6:0] sum;

	// Instantiate the Unit Under Test (UUT)
	seven_bit_adder uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.Y(Y), 
		.sum(sum), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		PB1 = 0;
		PB2 = 0;
		PB3 = 0;
		PB4 = 0;
		Y = 0;
		carry = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

