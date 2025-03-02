`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 02:47:37 AM
// Design Name: 
// Module Name: MainDecoder
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
module MainDecoder(
    input   logic   [6 : 0]     op,
    output  logic               RegWrite,
    output  logic   [1 : 0]     ResultSrc,
    output  logic               MemWrite,
    output  logic               Jump,
    output  logic               Branch,
    output  logic   [1 : 0]     ALUOp,
    output  logic               ALUSrc,
    output  logic   [1 : 0]     ImmSrc
    );


    always_comb
    begin
        // Default
        RegWrite    = 1'b0;
        ImmSrc      = 2'b00;
        ALUSrc      = 1'b0;
        MemWrite    = 1'b0;
        ResultSrc   = 2'b00;
        Branch      = 1'b0;
        ALUOp       = 2'b00;
        Jump        = 1'b0;
        // instructions control outputs
        case(op)
            7'b0000011: begin   // lw
                            RegWrite    = 1'b1;
                            ImmSrc      = 2'b00;
                            ALUSrc      = 1'b1;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b01;
                            Branch      = 1'b0;
                            ALUOp       = 2'b00;
                            Jump        = 1'b0;
                        end
            7'b0100011: begin   // sw
                            RegWrite    = 1'b0;
                            ImmSrc      = 2'b01;
                            ALUSrc      = 1'b1;
                            MemWrite    = 1'b1;
                            ResultSrc   = 2'b00;
                            Branch      = 1'b0;
                            ALUOp       = 2'b00;
                            Jump        = 1'b0;
                        end
            7'b0110011: begin   // R-Type
                            RegWrite    = 1'b1;
                            ImmSrc      = 2'b00;
                            ALUSrc      = 1'b0;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b00;
                            Branch      = 1'b0;
                            ALUOp       = 2'b10;
                            Jump        = 1'b0;
                        end
            7'b1100011: begin   // beq
                            RegWrite    = 1'b0;
                            ImmSrc      = 2'b10;
                            ALUSrc      = 1'b0;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b00;
                            Branch      = 1'b1;
                            ALUOp       = 2'b01;
                            Jump        = 1'b0;
                        end
            7'b0010011: begin   // I-Type ALU
                            RegWrite    = 1'b1;
                            ImmSrc      = 2'b00;
                            ALUSrc      = 1'b1;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b00;
                            Branch      = 1'b0;
                            ALUOp       = 2'b10;
                            Jump        = 1'b0;
                        end
            7'b1101111: begin   // jal
                            RegWrite    = 1'b1;
                            ImmSrc      = 2'b11;
                            ALUSrc      = 1'b0;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b10;
                            Branch      = 1'b0;
                            ALUOp       = 2'b00;
                            Jump        = 1'b1;
                        end
            default:    begin
                            RegWrite    = 1'b0;
                            ImmSrc      = 2'b00;
                            ALUSrc      = 1'b0;
                            MemWrite    = 1'b0;
                            ResultSrc   = 2'b00;
                            Branch      = 1'b0;
                            ALUOp       = 2'b00;
                            Jump        = 1'b0;
                        end
        endcase
    end



endmodule
