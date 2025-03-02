`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:29:47 AM
// Design Name: 
// Module Name: ControlUnit
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
module ControlUnit(
    input   logic   [6 : 0]     i_cu_op,
    input   logic   [2 : 0]     i_cu_funct3,
    input   logic               i_cu_funct7_5,
    output  logic   [2 : 0]     o_cu_ALUControl,
    output  logic               o_cu_RegWrite,
    output  logic   [1 : 0]     o_cu_ResultSrc,
    output  logic               o_cu_MemWrite,
    output  logic               o_cu_Jump,
    output  logic               o_cu_Branch,
    output  logic               o_cu_ALUSrc,
    output  logic   [1 : 0]     o_cu_ImmSrc
    );

    logic           [1 : 0]     ALUOp;


    // Main Decoder
    MainDecoder MainDecoder_U (
        .op(i_cu_op),
        .RegWrite(o_cu_RegWrite),
        .ResultSrc(o_cu_ResultSrc),
        .MemWrite(o_cu_MemWrite),
        .Jump(o_cu_Jump),
        .Branch(o_cu_Branch),
        .ALUOp(ALUOp),
        .ALUSrc(o_cu_ALUSrc),
        .ImmSrc(o_cu_ImmSrc)
    );


    // ALU Decoder
    ALUDecoder ALUDecoder_U (
        .ALUOp(ALUOp),
        .funct3(i_cu_funct3),
        .op_5(i_cu_op[5]),
        .funct7_5(i_cu_funct7_5),
        .ALUControl(o_cu_ALUControl)
    );


endmodule
