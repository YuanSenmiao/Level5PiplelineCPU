`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:29 01/08/2015 
// Design Name: 
// Module Name:    Clock 
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
module Clock(
	input wire clk, reset, enable,
	output wire mclk
    );
	
assign mclk = clk;
/*reg tclk=1'b0;
assign mclk = tclk;
always @(posedge clk or posedge reset)
begin
	if(reset)	tclk = 2'b0;
	else if (enable)		tclk = ~tclk;
end*/
endmodule
