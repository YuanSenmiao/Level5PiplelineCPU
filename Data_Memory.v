`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:45 01/08/2015 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory(
	input wire d_we, mem_clk,
	input wire [7:0] d_addr,
	input wire [15:0] d_dataout,
	output wire [15:0] d_datain
    );
reg [15:0] Memory[255:0];
assign d_datain = Memory[d_addr];
initial
begin
//GCM, LCM
/*Memory[8'b0000_0000] = 16'h0000;
Memory[8'b0000_0001] = 16'h0020;
Memory[8'b0000_0010] = 16'h0018;*/
//Bullble
/*Memory[8'b0000_0000] = 16'h000a;
Memory[8'b0000_0001] = 16'h0004;
Memory[8'b0000_0010] = 16'h0005;
Memory[8'b0000_0011] = 16'h2369;
Memory[8'b0000_0100] = 16'h69c3;
Memory[8'b0000_0101] = 16'h0060;
Memory[8'b0000_0110] = 16'h0fff;
Memory[8'b0000_0111] = 16'h5555;
Memory[8'b0000_1000] = 16'h6152;
Memory[8'b0000_1001] = 16'h1057;
Memory[8'b0000_1010] = 16'h2895;*/
//sort
/*Memory[8'b0000_0000] = 16'h000a;
Memory[8'b0000_0001] = 16'h0009;
Memory[8'b0000_0010] = 16'h0006;
Memory[8'b0000_0011] = 16'h0005;
Memory[8'b0000_0100] = 16'h0001;
Memory[8'b0000_0101] = 16'h0004;
Memory[8'b0000_0110] = 16'h0003;
Memory[8'b0000_0111] = 16'h0011;*/
//64 b adde
/*Memory[8'b0000_0000] = 16'hfffe;
Memory[8'b0000_0001] = 16'hfffe;
Memory[8'b0000_0010] = 16'hfffe;
Memory[8'b0000_0011] = 16'h0000;
Memory[8'b0000_0100] = 16'hffff;
Memory[8'b0000_0101] = 16'hffff;
Memory[8'b0000_0110] = 16'hffff;
Memory[8'b0000_0111] = 16'h0000;
Memory[8'b0000_1000] = 16'h0000;
Memory[8'b0000_1001] = 16'h0000;
Memory[8'b0000_1010] = 16'h0000;
Memory[8'b0000_1011] = 16'h0000;
Memory[8'b0000_1100] = 16'h0000;
Memory[8'b0000_1101] = 16'h0000;
Memory[8'b0000_1110] = 16'h0000;
Memory[8'b0000_1111] = 16'h0000;*/
//init_test
Memory[8'b0000_0000] = 16'hfffd;
Memory[8'b0000_0001] = 16'h0004;
Memory[8'b0000_0010] = 16'h0005;
Memory[8'b0000_0011] = 16'hc369;
Memory[8'b0000_0100] = 16'h69c3;
Memory[8'b0000_0101] = 16'h0041;
Memory[8'b0000_0110] = 16'hffff;
Memory[8'b0000_0111] = 16'h0001;
Memory[8'b0000_1000] = 16'h0000;
Memory[8'b0000_1001] = 16'h0000;
Memory[8'b0000_1010] = 16'h0000;
Memory[8'b0000_1011] = 16'h0000;
Memory[8'b0000_1100] = 16'h0000;
Memory[8'b0000_1101] = 16'h0000;
Memory[8'b0000_1110] = 16'h0000;
Memory[8'b0000_1111] = 16'h0000;

end
always @ (posedge mem_clk)
begin
	if(d_we)	Memory[d_addr] = d_dataout;
end
endmodule

