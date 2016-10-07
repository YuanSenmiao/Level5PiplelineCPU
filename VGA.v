`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:27 01/05/2015 
// Design Name: 
// Module Name:    VGA 
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
module VGA(
   input wire clk, reset,
	input wire [15:0] reg_A, reg_B, reg_C, reg_C1, ALU0,
	input wire [15:0] id_ir, ex_ir, mem_ir, wb_ir, smdr,
	input wire [15:0] pc, d_addr, d_dataout, flag,
	output wire [2:0] red, green,
	output wire [1:0] blue,
	output wire hs, vs
    );

wire [10:0] addr_row, addr_column;
wire valid, mclk;

Catch_clk GetClk(	.clk(clk),	.reset(reset),	.mclk(mclk));
	
VGA_SYNC catch_sync(
	.clk(mclk),	.reset(reset),	.vs(vs),	.hs(hs),	.valid(valid),
	.addr_row(addr_row),	.addr_column(addr_column)
	);

VGA_Print out(
	.clk(mclk),	.reset(reset),	.valid(valid),	.addr_row(addr_row),	.addr_column(addr_column),
	.reg_A(reg_A),	.reg_B(reg_B),	.reg_C(reg_C),	.reg_C1(reg_C1),	.ALU0(ALU0),
	.id_ir(id_ir),	.ex_ir(ex_ir),	.mem_ir(mem_ir),	.wb_ir(wb_ir),	.smdr(smdr),
	.pc(pc),	.d_addr(d_addr),	.d_dataout(d_dataout),	.flag(flag),
	.red(red),	.green(green),	.blue(blue)
	);

endmodule
