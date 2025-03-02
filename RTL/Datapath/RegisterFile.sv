`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:23:43 AM
// Design Name: 
// Module Name: RegisterFile
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
module RegisterFile(
    input   logic                i_rf_clk,
    input   logic                i_rf_rst_n,
    input   logic    [4  : 0]    i_rf_A1,
    input   logic    [4  : 0]    i_rf_A2,
    input   logic    [4  : 0]    i_rf_A3,
    input   logic    [31 : 0]    i_rf_WD3,
    input   logic                i_rf_WE3,
    output  logic    [31 : 0]    o_rf_RD1,
    output  logic    [31 : 0]    o_rf_RD2
    );

    logic            [31 : 0]    RegMem [32];



    always_ff @(negedge i_rf_clk, negedge i_rf_rst_n)
    begin
        if(!i_rf_rst_n)
            for(int i=0; i<32; i++) RegMem[i] <= 'b0;
        else if ( i_rf_WE3 & (i_rf_A3 != 0) )            // x0 is stuck to ground
            RegMem[i_rf_A3] = i_rf_WD3;
        else
            RegMem[i_rf_A3] = RegMem[i_rf_A3];
    end


    always_comb
    begin
        o_rf_RD1 = RegMem[i_rf_A1];
        o_rf_RD2 = RegMem[i_rf_A2];
    end





endmodule
