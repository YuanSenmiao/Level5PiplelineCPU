`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:01 01/05/2015 
// Design Name: 
// Module Name:    Catch_clk 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Catch_clk(
   input wire clk, reset,
	output wire mclk
    );
	 
reg tclk;
initial tclk = 1'b0;
always @(posedge clk or posedge reset)
begin
	if(reset)	tclk = 1'b0;
	else			tclk = ~tclk;
end

assign mclk = tclk;

endmodule
