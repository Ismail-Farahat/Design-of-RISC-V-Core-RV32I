`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:26:59 AM
// Design Name: 
// Module Name: MUX2
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
module MUX2(
    input   logic   [31 : 0]    i_mux2_in1,
    input   logic   [31 : 0]    i_mux2_in2,
    input   logic               i_mux2_sel,
    output  logic   [31 : 0]    o_mux2_out
    );


    always_comb
    begin
        case(i_mux2_sel)
            1'b0: o_mux2_out = i_mux2_in1;
            1'b1: o_mux2_out = i_mux2_in2;
        endcase
    end



endmodule
