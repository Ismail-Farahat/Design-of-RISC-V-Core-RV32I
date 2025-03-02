`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:24:11 AM
// Design Name: 
// Module Name: DataMemory
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
module DataMemory  #(DEPTH = 255) (
    input   logic               i_dm_clk,
    input   logic               i_dm_rst_n,
    input   logic   [31 : 0]    i_dm_A,
    input   logic   [31 : 0]    i_dm_WD,
    input   logic               i_dm_WE,
    output  logic   [31 : 0]    o_dm_RD
    );

    logic           [31 : 0]    DataMem    [0 : DEPTH-1];
    


    always_ff @(posedge i_dm_clk, negedge i_dm_rst_n)
    begin
        if(!i_dm_rst_n)
            for(int i=0; i<DEPTH; i++) DataMem[i] <= 'b0;
        else if(i_dm_WE)
            DataMem[i_dm_A[31:2]] <= i_dm_WD;  //[1:0] for word access (risc-v is word addressable)
    end


    assign o_dm_RD = DataMem[i_dm_A[31:2]];   //[1:0] for word access (risc-v is word addressable)






endmodule
