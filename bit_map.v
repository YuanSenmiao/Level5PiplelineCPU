`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:39 01/05/2015 
// Design Name: 
// Module Name:    bit_map 
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
module bit_map(
   input wire clk, reset,
	input wire [10:0] column,
	input wire [15:0] data,
	output reg color, bc
    );
/*******55--150--30--150--30--150--30--150--55*******/
			/*******33--6--33--6--33--6*******/
always @ (posedge clk or posedge reset)
begin
	if(reset)	begin color<=1'b1;     bc<=1'b0; end
	else
	begin
		if(column >= 10'd55 && column <= 10'd205)
			begin
			if(column>=10'd55 && column<=10'd88)			begin color<=data[15];  bc<=1'b0; end
			else if(column>=10'd94 && column<=10'd127)	begin color<=data[14];  bc<=1'b0; end
			else if(column>=10'd133 && column<=10'd166)	begin color<=data[13];  bc<=1'b0; end
			else if(column>=10'd172 && column<=10'd205)	begin color<=data[12];  bc<=1'b0; end
			else														begin color<=1'b0;     bc<=1'b1; end
			end
		else if(column >= 10'd235 && column <= 10'd385)
			begin
			if(column>= 10'd235 && column<=10'd268)		begin color<=data[11];  bc<=1'b0; end
			else if(column>=10'd274 && column<=10'd307)	begin color<=data[10];  bc<=1'b0; end
			else if(column>=10'd313 && column<=10'd346)	begin color<=data[9];  bc<=1'b0; end
			else if(column>=10'd352 && column<=10'd385)	begin color<=data[8];  bc<=1'b0; end
			else														begin color<=1'b0;     bc<=1'b1; end
			end
		else if(column >= 10'd415 && column <= 10'd565)
			begin
			if(column>=10'd415 && column<=10'd448)			begin color<=data[7];  bc<=1'b0; end
			else if(column>=10'd454 && column<=10'd487)	begin color<=data[6];  bc<=1'b0; end
			else if(column>=10'd493 && column<=10'd526)	begin color<=data[5]; bc<=1'b0; end
			else if(column>=10'd532 && column<=10'd565)	begin color<=data[4]; bc<=1'b0; end
			else														begin color<=1'b0;     bc<=1'b1; end
			end
		else if(column >= 10'd595 && column <= 10'd745)
			begin
			if(column>=10'd595 && column<=10'd628)			begin color<=data[3]; bc<=1'b0; end
			else if(column>=10'd634 && column<=10'd667)	begin color<=data[2]; bc<=1'b0; end
			else if(column>=10'd673 && column<=10'd706)	begin color<=data[1]; bc<=1'b0; end
			else if(column>=10'd712 && column<=10'd745)	begin color<=data[0]; bc<=1'b0; end
			else														begin color<=1'b0;     bc<=1'b1; end
			end
		else															begin color<=1'b0;     bc<=1'b1; end
	end
end

endmodule

