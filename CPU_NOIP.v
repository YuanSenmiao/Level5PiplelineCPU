`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:54 01/08/2015 
// Design Name: 
// Module Name:    CPU_NOIP 
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
module CPU_NOIP(
	input wire clk, reset, start, enable,
	output wire [2:0] red, green,
	output wire [1:0] blue,
	output hs, vs
    );

wire d_we, mclk;
wire [7:0] pc, d_addr;
wire [15:0] d_dataout, d_datain, i_datain;
PCPU Used(
	.clk(clk),	.mclk(clk), .reset(reset),	.start(start),	.enable(enable),
	.i_datain(i_datain),	.d_datain(d_datain),	.d_we(d_we), 
	.pc(pc),	.d_addr(d_addr),	.d_dataout(d_dataout),
	.red(red),	.green(green),	.blue(blue),	.hs(hs),	.vs(vs)
	);
Clock mem( .clk(clk),	.reset(reset),	.mclk(mclk), .enable(enable) );
Data_Memory	m1(.mem_clk(clk),	.d_we(d_we),	.d_addr(d_addr),	.d_dataout(d_dataout),	.d_datain(d_datain));
/*Instruction_Memory m2(.i_addr(pc),	.dataout(i_datain));*/
Instruction_Memory m2(.mem_clk(mclk), .addr(pc),	.i_datain(i_datain));
endmodule


