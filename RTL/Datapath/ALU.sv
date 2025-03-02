`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:23:01 AM
// Design Name: 
// Module Name: ALU
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
module ALU(
    input   logic   [31 : 0]    i_alu_SrcA,
    input   logic   [31 : 0]    i_alu_SrcB,
    input   logic   [2  : 0]    i_alu_ALUControl,
    output  logic   [31 : 0]    o_alu_ALUResult,
    output  logic               o_alu_ALUZero
    );


    always_comb
    begin
        o_alu_ALUResult = 'b0;
        case(i_alu_ALUControl)
            3'b000: o_alu_ALUResult = i_alu_SrcA + i_alu_SrcB; // add
            3'b001: o_alu_ALUResult = i_alu_SrcA - i_alu_SrcB; // sub
            3'b010: o_alu_ALUResult = i_alu_SrcA & i_alu_SrcB; // and
            3'b011: o_alu_ALUResult = i_alu_SrcA | i_alu_SrcB; // or
            3'b101: o_alu_ALUResult = i_alu_SrcA < i_alu_SrcB; // slt
            default: o_alu_ALUResult = 'b0;
        endcase
    end


    assign o_alu_ALUZero = (i_alu_ALUControl == 3'b001) ? (i_alu_SrcA - i_alu_SrcB) == 0 : 1'b0;




endmodule
