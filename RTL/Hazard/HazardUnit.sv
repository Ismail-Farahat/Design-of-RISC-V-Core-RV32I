`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:30:11 AM
// Design Name: 
// Module Name: HazardUnit
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
module HazardUnit(
    input   logic   [4 : 0]     i_hu_Rs1D,
    input   logic   [4 : 0]     i_hu_Rs2D,
    input   logic   [4 : 0]     i_hu_Rs1E,
    input   logic   [4 : 0]     i_hu_Rs2E,
    input   logic   [4 : 0]     i_hu_RdE,
    input   logic   [4 : 0]     i_hu_RdM,
    input   logic   [4 : 0]     i_hu_RdW,
    input   logic               i_hu_RegWriteW,
    input   logic               i_hu_RegWriteM,
    input   logic               i_hu_ResultSrcE0,
    input   logic               i_hu_PCSrcE,
    output  logic               o_hu_StallF,
    output  logic               o_hu_StallD,
    output  logic               o_hu_FlashD,
    output  logic               o_hu_FlashE,
    output  logic   [1 : 0]     o_hu_ForwardAE,
    output  logic   [1 : 0]     o_hu_ForwardBE
    );

    logic                       lw_stall;


    always_comb 
    begin
        o_hu_StallF    = 0;
        o_hu_StallD    = 0;
        o_hu_FlashD    = 0;
        o_hu_FlashE    = 0;
        o_hu_ForwardAE = 2'b0;
        o_hu_ForwardBE = 2'b0;

        // data hazard: Forwarding SrcA
        if( ((i_hu_Rs1E == i_hu_RdM) & (i_hu_RegWriteM == 1)) & (i_hu_Rs1E != 0) )
            o_hu_ForwardAE = 2'b10;
        else if( ((i_hu_Rs1E == i_hu_RdW) & (i_hu_RegWriteW == 1)) & (i_hu_Rs1E != 0) )
            o_hu_ForwardAE = 2'b01;
        else
            o_hu_ForwardAE = 2'b00;

        // data hazard: Forwarding SrcB
        if( ((i_hu_Rs2E == i_hu_RdM) & (i_hu_RegWriteM == 1)) & (i_hu_Rs2E != 0) )
            o_hu_ForwardBE = 2'b10;
        else if( ((i_hu_Rs2E == i_hu_RdW) & (i_hu_RegWriteW == 1)) & (i_hu_Rs2E != 0) )
            o_hu_ForwardBE = 2'b01;
        else
            o_hu_ForwardBE = 2'b00;

        // load hazard: lw instrcution stall
        lw_stall = (i_hu_ResultSrcE0 == 1) & ( (i_hu_Rs1D == i_hu_RdE) | (i_hu_Rs2D == i_hu_RdE) );
        if (lw_stall) begin
            o_hu_StallF    = 1;
            o_hu_StallD    = 1;
        end
        else begin
            o_hu_StallF    = 0;
            o_hu_StallD    = 0;
        end

        // control hazard: (load, branch, jump) flash signals
        o_hu_FlashD  = i_hu_PCSrcE;
        o_hu_FlashE  = lw_stall | i_hu_PCSrcE;



        ////////////    EASIER CODE FOR CONTROL & LOAD HAZARDS    ////////////
        // lwStall = (i_hu_ResultSrcE0 == 1) && ( (i_hu_Rs1D == i_hu_RdE) | (i_hu_Rs2D == i_hu_RdE);
        // o_hu_StallF  = lwStall;
        // o_hu_StallD  = lwStall;
        // o_hu_FlashD  = i_hu_PCSrcE;
        // o_hu_FlashE  = lwStall | i_hu_PCSrcE;
        //////////////////////////////////////////////////////////////////////


    end




endmodule
