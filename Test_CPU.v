`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:19:43 06/01/2015
// Design Name:   CPU_NOIP
// Module Name:   F:/WorkSpace/ISE_workspace/CPU/level5/Test_CPU.v
// Project Name:  level5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU_NOIP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define NOP		5'b00000
`define HALT	5'b00001
`define LOAD	5'b00010
`define STORE	5'b00011
`define LDIH	5'b10000
`define ADD		5'b01000
`define ADDI	5'b01001
`define ADDC	5'b10001
`define SUB		5'b01010
`define SUBI	5'b01011
`define SUBC	5'b10010
`define CMP		5'b01100
//Logical / shift
`define AND		5'b01101
`define OR		5'b01110
`define XOR		5'b01111
`define SLL		5'b00100
`define SRL		5'b00111
`define SLA		5'b00101
`define SRA		5'b00110
//Control
`define JUMP	5'b11000
`define JMPR	5'b11001
`define BZ		5'b11010
`define BNZ		5'b11011
`define BN		5'b11100
`define BNN		5'b11101
`define BC		5'b11110
`define BNC		5'b11111
//Statement
`define idle	1'b0
`define exec	1'b1
//gr
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111
/***********************************************************************/
module Test_CPU;

	// Inputs
	reg clk;
	reg reset;
	reg start;
	reg enable;

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hs;
	wire vs;

	// Instantiate the Unit Under Test (UUT)
	CPU_NOIP uut (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.enable(enable), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hs(hs), 
		.vs(vs)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		start = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#1;
        
		// Add stimulus here
		$display("pc:     id_ir      :reg_A:reg_B:ALUo :reg_C:da:dd  :w:reC1:gr1 :gp:gr2 :gr3 :gr4 :ddin:zf:nf:cf:beq:md4");
		$monitor("%h:%b:%h :%h :%h :%h :%h:%h:%b:%h:%h:%h:%h:%h:%h:%h: %b: %b: %h :%h :%h", 
			uut.pc, uut.Used.id_ir, uut.Used.reg_A, uut.Used.reg_B, uut.Used.ALU0,uut.Used.reg_C,
			uut.Used.d_addr, uut.Used.d_dataout, uut.Used.d_we, uut.Used.reg_C1, uut.Used.gr[1], uut.Used.d_addr,uut.Used.gr[2],
			uut.Used.gr[3],uut.Used.gr[4],uut.Used.d_datain,uut.Used.zf,uut.Used.nf, uut.Used.cf, uut.Used.beq, uut.m1.Memory[8'h3]);
			enable <= 1; start <= 0;
			#1 reset  <= 1;
			#1 reset  <= 0;
			#1 enable <= 1;
			#1 start  <= 1;
			#100;
			#10 start <= 0;
	end
      always #5 clk = ~clk;
endmodule

