`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:05 01/05/2015 
// Design Name: 
// Module Name:    VGA_SYNC 
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
module VGA_SYNC(
   input wire clk, reset,
	output wire vs, hs, valid,
	output wire [10:0] addr_row, addr_column
    );
//Catch the Sync
reg [10:0] count_v, count_h;
initial count_v = 11'd0;
initial count_h = 11'd0;

always @ (posedge clk or posedge reset)
begin
	if(reset)	count_h <= 11'd0;
	else
	begin
		if(count_h == 11'd1056)		count_h <= 11'd0;
		else								count_h <= count_h + 1'b1;
	end
end
always @ (posedge clk or posedge reset)
begin
	if(reset)	count_v <= 11'd0;
	else
	begin
		if(count_v == 11'd625)			count_v <= 11'd0;
		else if(count_h == 11'd1056)	count_v <= count_v + 1'b1;
	end
end
//Define the vaild area
reg flag;
initial flag = 1'b0;
always @ (posedge clk or posedge reset)
begin
	if(reset)	flag <= 1'b0;
	else
	begin
		if((count_h>11'd240 && count_h<11'd1040) && (count_v>11'd24 && count_v<11'd624 ))
			flag <= 1'b1;
		else 		flag <= 1'b0;
	end
end
//Assignment
assign hs = (count_h>11'd80)? 1'b1 : 1'b0;
assign vs = (count_v>11'd3)? 1'b1 : 1'b0;
assign valid = flag;

assign addr_row = flag? count_v-11'd25 : 11'd0;
assign addr_column = flag? count_h-11'd241 : 11'd0;

endmodule

