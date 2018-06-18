`timescale 1ns / 1ps

module clkdiv(
    input   logic clk,
    output  logic clk380,
    output  logic clk48,
    output  logic clk1_6,
    output  logic clk0_4
);
    logic [27:0]q;
    initial q = 28'b0;
    always@(posedge clk)
         q<=q+1;
    assign clk380=q[17];
    assign clk48=q[20];
    assign clk1_6=q[24]; 
    assign clk0_4=q[26];         
endmodule
