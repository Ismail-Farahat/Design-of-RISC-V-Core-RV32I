`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:26:19 AM
// Design Name: 
// Module Name: ADDER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ADDER(
    input   logic   [31 : 0]    i_adder_in1,
    input   logic   [31 : 0]    i_adder_in2,
    output  logic   [31 : 0]    o_adder_out
    );


    assign o_adder_out = i_adder_in1 + i_adder_in2;


endmodule
