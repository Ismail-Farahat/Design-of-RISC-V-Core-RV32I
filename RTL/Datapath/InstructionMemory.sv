`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 12:24:47 AM
// Design Name: 
// Module Name: InstructionMemory
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
module InstructionMemory #(DEPTH = 255) (
    input   logic   [31 : 0]    i_im_A,
    output  logic   [31 : 0]    i_im_RD
    );

    logic           [31 : 0]    RAM    [DEPTH-1 : 0];

    // read program file into the memory
    initial $readmemh("E:/DIC_PROJECTS/RISC-V32I/project_files/TB/program_test/riscvtest.txt", RAM);



    assign i_im_RD = RAM[i_im_A[31:2]];   //[1:0] for word access (risc-v is word addressable)



endmodule
