`timescale 1ns / 1ps

module minimum(
    input [2:0] A, B, C, D,
    input clk,
    output reg [7:0] DB,
    output reg [1:0] minpos
);

// Initialize outputs
initial begin
    DB <= 8'b0;
    minpos <= 2'b00;
end

// Logic to determine minimum value and its position
always @(posedge clk) begin
    case ({A, B, C, D})
        4'b0000: begin
            DB <= 8'b00110000;
            minpos <= 2'b00;
        end
        4'b0001: begin
            DB <= 8'b00110001;
            minpos <= 2'b01;
        end
        4'b0010: begin
            DB <= 8'b00110010;
            minpos <= 2'b10;
        end
        4'b0011: begin
            DB <= 8'b00110011;
            minpos <= 2'b11;
        end
        default: begin
            // Handle other cases if necessary
            // This could include handling invalid inputs
            // or providing default values
            DB <= 8'b00000000;
            minpos <= 2'b00;
        end
    endcase
end

endmodule
