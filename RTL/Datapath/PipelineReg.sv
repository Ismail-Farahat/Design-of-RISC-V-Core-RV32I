`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2024 05:10:39 PM
// Design Name: 
// Module Name: PipelineReg
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
module PipelineReg #(
	parameter BUS_WIDTH = 32
	) (
	input 	logic 											i_pipe_clk,
	input 	logic 											i_pipe_rst_n,
	input 	logic 											i_pipe_clr,
	input 	logic 											i_pipe_en_n,
	input 	logic 	[BUS_WIDTH-1 : 0] 	i_pipe_in,
	output	logic 	[BUS_WIDTH-1 : 0] 	o_pipe_out
  );



	always_ff @(posedge i_pipe_clk or negedge i_pipe_rst_n)
	begin
		if(!i_pipe_rst_n)
			o_pipe_out <= 'b0;
		else if(i_pipe_clr)
			o_pipe_out <= 'b0;
		else if(!i_pipe_en_n)
			o_pipe_out <= i_pipe_in;
	end



endmodule
