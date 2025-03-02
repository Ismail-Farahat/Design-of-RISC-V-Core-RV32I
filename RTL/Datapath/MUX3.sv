`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:26:46 AM
// Design Name: 
// Module Name: MUX3
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
module MUX3(
    input   logic   [31 : 0]    i_mux3_in1,
    input   logic   [31 : 0]    i_mux3_in2,
    input   logic   [31 : 0]    i_mux3_in3,
    input   logic   [1  : 0]    i_mux3_sel,
    output  logic   [31 : 0]    o_mux3_out
    );


    always_comb
    begin
        case(i_mux3_sel)
            2'b00:   o_mux3_out = i_mux3_in1;
            2'b01:   o_mux3_out = i_mux3_in2;
            2'b10:   o_mux3_out = i_mux3_in3;
            default: o_mux3_out = 'b0;
        endcase
    end



endmodule
