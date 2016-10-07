`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:45 01/05/2015 
// Design Name: 
// Module Name:    VGA_Print 
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
module VGA_Print(
   input wire clk, valid, reset,
	input wire [10:0] addr_row, addr_column,
	input wire [15:0] reg_A, reg_B, reg_C, reg_C1, ALU0,
	input wire [15:0] id_ir, ex_ir, mem_ir, wb_ir, smdr,
	input wire [15:0] pc, d_addr, d_dataout, flag,
	output wire [2:0] red, green,
	output wire [1:0] blue
    );
/**********************************************/
wire color, bc, all;
wire [15:0] data;
/**********************************************/
line_map one_column(
	.clk(clk),	.reset(reset),	.row(addr_row),	.ALU0(ALU0),
	.reg_A(reg_A),	.reg_B(reg_B),	.reg_C(reg_C),	.reg_C1(reg_C1),
	.id_ir(id_ir),	.ex_ir(ex_ir),	.mem_ir(mem_ir),	.wb_ir(wb_ir),
	.pc(pc),	.d_addr(d_addr),	.d_dataout(d_dataout),	.smdr(smdr),
	.flag(flag),	.all(all),	.data(data)
	);
/**********************************************/
bit_map one_row(
	.clk(clk),	.reset(reset),	.column(addr_column),	.data(data),
	.color(color),	.bc(bc)
	);
/**********************************************/
assign red = (valid&color)?3'b111:3'b000;
assign blue = (valid&color)?2'b11:2'b00;
assign green = (valid&(color|bc|all))?3'b111:3'b000;
/**********************************************/
endmodule

