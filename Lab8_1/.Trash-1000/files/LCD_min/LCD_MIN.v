`timescale 1ns / 1ps

module LCD_MIN(
    input clk,
    input [2:0] slide,
    input PB1, PB2, PB3, PB4,
    output reg lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7,
    output reg [1:0] minpos
);

reg flag;
reg [2:0] A, B, C, D;
wire [7:0] DB;
reg [127:0] lines, lines1;

// Instantiate the minimum module
minimum uut0(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .clk(clk),
    .DB(DB),
    .minpos(minpos)
);

// Instantiate the LCD module
LCD uut1(
    .first_line(lines),
    .second_line(lines1),
    .clk(clk),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_e(lcd_e),
    .lcd4(lcd4),
    .lcd5(lcd5),
    .lcd6(lcd6),
    .lcd7(lcd7)
);

// Set default values
initial begin
    flag = 0;
    A = 3'b0;
    B = 3'b0;
    C = 3'b0;
    D = 3'b0;
end

// Input handling using sliding buttons and trigger button
always @(posedge PB1 or posedge PB2 or posedge PB3 or posedge PB4) begin
    if (PB1) A <= slide;
    if (PB2) B <= slide;
    if (PB3) C <= slide;
    if (PB4) begin
        D <= slide;
        flag <= 1;
    end
end

// Prepare data for LCD output
always @(posedge clk) begin
    if (flag) begin
        lines = {8'b00110000, A, 8'b00101100, 8'b00100000, B, 8'b00101100, 8'b00100000, C, 8'b00101100, 8'b00100000, D, 8'b00101100, 8'b00100000};
        lines1 = {DB, 8'b00101100, 8'b00100000};
    end
end

endmodule
