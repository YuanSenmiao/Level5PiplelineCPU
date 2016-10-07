`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:02 01/05/2015 
// Design Name: 
// Module Name:    line_map 
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
module line_map(
   input wire clk, reset,
	input wire [10:0] row,
	input wire [15:0] reg_A, reg_B, reg_C, reg_C1, ALU0,
	input wire [15:0] id_ir, ex_ir, mem_ir, wb_ir, smdr,
	input wire [15:0] d_dataout, pc, d_addr, flag,
	output reg all,
	output reg [15:0] data
    );

/*******25--150--10--150--10--150--10--70--25*******/	
		/*******30--10--30--10--30--10*******/
				/*******30--10--30*******/
always @ (posedge clk or posedge reset)
begin
	if(reset)	begin data<=16'b0; all<=1'b0; end
	else
	begin
		if(row>=10'd25 && row<=10'd175)
			begin
			if(row>=10'd25 && row<=10'd55)			begin data<=reg_A; all<=1'b0; end
			else	if(row>=10'd65 && row<=10'd95)	begin data<=reg_B; all<=1'b0; end
			else	if(row>=10'd105 && row<=10'd135)	begin data<=reg_C; all<=1'b0; end
			else	if(row>=10'd145 && row<=10'd175)	begin data<=reg_C1; all<=1'b0; end
			else												begin data<=16'b0; all<=1'b1; end
			end
		else if(row>=10'd185 && row<=10'd335)
			begin
			if(row>=10'd185 && row<=10'd215)			begin data<=ALU0; all<=1'b0; end
			else	if(row>=10'd225 && row<=10'd255)	begin data<=id_ir; all<=1'b0; end
			else	if(row>=10'd265 && row<=10'd295)	begin data<=ex_ir; all<=1'b0; end
			else	if(row>=10'd305 && row<=10'd335)	begin data<=mem_ir; all<=1'b0; end
			else												begin data<=16'b0; all<=1'b1; end
			end
		else if(row>=10'd345 && row<=10'd495)
			begin
			if(row>=10'd345 && row<=10'd375)			begin data<=wb_ir; all<=1'b0; end
			else	if(row>=10'd385 && row<=10'd415)	begin data<=smdr; all<=1'b0; end
			else	if(row>=10'd425 && row<=10'd455)	begin data<=d_dataout; all<=1'b0; end
			else	if(row>=10'd465 && row<=10'd495)	begin data<=pc; all<=1'b0; end
			else												begin data<=16'b0; all<=1'b1; end
			end
		else if(row>=10'd505 && row<=10'd575)
			begin
			if(row>=10'd505 && row<=10'd535)			begin data<=d_addr; all<=1'b0; end
			else	if(row>=10'd545 && row<=10'd575)	begin data<=flag; all<=1'b0; end
			else												begin data<=16'b0; all<=1'b1; end
			end
		else												begin data<=16'b0; all<=1'b1; end
	end
end

endmodule

