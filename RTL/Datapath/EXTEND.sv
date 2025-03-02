`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:23:18 AM
// Design Name: 
// Module Name: EXTEND
// Project Name: RISC-V
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
module EXTEND (
    input   logic    [31 : 7]    i_extend_Instr,
    input   logic    [1  : 0]    i_extend_ImmSrc,
    output  logic    [31 : 0]    o_extend_ImmExt
    );


    always_comb
    begin
        o_extend_ImmExt = 'b0;
        case(i_extend_ImmSrc)
            2'b00: o_extend_ImmExt = {{20{i_extend_Instr[31]}}, 
                                          i_extend_Instr[31:20]}; // I-Type Instruction
            2'b01: o_extend_ImmExt = {{20{i_extend_Instr[31]}}, 
                                          i_extend_Instr[31:25], 
                                          i_extend_Instr[11:7]}; // S-Type Instruction
            2'b10: o_extend_ImmExt = {{20{i_extend_Instr[31]}}, 
                                          i_extend_Instr[7], 
                                          i_extend_Instr[30:25], 
                                          i_extend_Instr[11:8], 
                                          1'b0}; // B-Type Instruction
            2'b11: o_extend_ImmExt = {{20{i_extend_Instr[31]}}, 
                                          i_extend_Instr[19:12], 
                                          i_extend_Instr[20], 
                                          i_extend_Instr[30:21], 
                                          1'b0}; //J-Type Instruction
        endcase
    end

    // NOTES:
    // Intruction[31] is the sign bit to be extended
    // B-Type Instrction have always 1'b0 as LSB ... 
    // ... (beacuse it doesn't decoded in the intruction) Branch Intruction always even number(+4)



endmodule
