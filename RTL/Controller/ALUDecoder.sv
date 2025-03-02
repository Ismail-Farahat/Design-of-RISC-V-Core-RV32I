`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 02:47:50 AM
// Design Name: 
// Module Name: ALUDecoder
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
module ALUDecoder(
    input   logic   [1 : 0]     ALUOp,
    input   logic   [2 : 0]     funct3,
    input   logic               op_5,
    input   logic               funct7_5,
    output  logic   [2 : 0]     ALUControl
    );


    always_comb 
    begin
        ALUControl = 3'b000;
        case (ALUOp)
            2'b00:  ALUControl = 3'b000;    // lw, sw
            2'b01:  ALUControl = 3'b001;    // beq
            2'b10:  case(funct3)
                        3'b000: ALUControl = (op_5 & funct7_5) ? 3'b001 : 3'b000;  // sub, add
                        3'b010: ALUControl = 3'b101;    // slt
                        3'b110: ALUControl = 3'b011;    // or
                        3'b111: ALUControl = 3'b010;    // and
                        default:ALUControl = 3'b000;
                    endcase
            default:ALUControl = 3'b000;
        endcase
        
    end


endmodule
