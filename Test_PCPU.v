`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:02:02 06/01/2015
// Design Name:   PCPU
// Module Name:   F:/WorkSpace/ISE_workspace/CPU/level5/Test_PCPU.v
// Project Name:  level5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCPU
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
/********************************************************************/
module Test_PCPU;

	// Inputs
	reg clk;
	reg mclk;
	reg reset;
	reg enable;
	reg start;
	reg [15:0] i_datain;
	reg [15:0] d_datain;

	// Outputs
	wire d_we;
	wire [7:0] d_addr;
	wire [7:0] pc;
	wire [15:0] d_dataout;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hs;
	wire vs;

	// Instantiate the Unit Under Test (UUT)
	PCPU uut (
		.clk(clk), 
		.mclk(mclk), 
		.reset(reset), 
		.enable(enable), 
		.start(start), 
		.i_datain(i_datain), 
		.d_datain(d_datain), 
		.d_we(d_we), 
		.d_addr(d_addr), 
		.pc(pc), 
		.d_dataout(d_dataout), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hs(hs), 
		.vs(vs)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		mclk = 0;
		reset = 0;
		enable = 0;
		start = 0;
		i_datain = 0;
		d_datain = 0;

		// Wait 100 ns for global reset to finish
		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		//************* test pattern *************//	
		$display("LOAD, ADDI, LDIH, '''ALL ADD AND SUB'''");
		$display("pc:     id_ir      :reg_A:reg_B:ALUo :reg_C:da:dd  :w:reC1:gr1 :gr2 :gr3 :ddin:exir:mmir:wbir:smdr:zf:nf:cf:beq");
		$monitor("%h:%b:%h :%h :%h :%h :%h:%h:%b:%h:%h:%h:%h:%h:%h:%h:%h:%h:%b: %b: %b: %h", 
			uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.ALU0,uut.reg_C,
			d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[1], uut.gr[2], uut.gr[3],uut.d_datain,uut.ex_ir,uut.mem_ir,
			uut.wb_ir,uut.smdr,uut.zf,uut.nf, uut.cf, uut.beq);
			
		enable <= 1; start <= 0; i_datain <= 0; d_datain <= 0; /*select_y <= 0;*/

		#10 reset  <= 1;
		#10 reset  <= 0;
		#10 enable <= 1;
		#10 start  <= 1;
		#10 start  <= 0;
		#10 i_datain <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
		#10 i_datain <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
			 d_datain <= 16'b0000_0000_1100_0011;
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		#10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr1, 4'b1111, 4'b1111};
		#10 i_datain <= {`LDIH, `gr2, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr3, 4'b1111, 4'b1111};
      #10 i_datain <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		#10 i_datain <= {`ADD, `gr3, 1'b0, `gr2, 1'b0, `gr2};
		#10 i_datain <= {`ADDC, `gr3, 1'b0, `gr2, 1'b0, `gr1};
		#10 i_datain <= {`SUB, `gr3, 1'b0, `gr2, 1'b0, `gr1};
		#10 i_datain <= {`BN, `gr0, 4'b0011,4'b1100};
		#10 i_datain <= {`SUBC, `gr3, 1'b0, `gr2, 1'b0, `gr1};
		#10 i_datain <= {`SUBI, `gr1, 4'b1111, 4'b1111 };
      #10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1111 };
		$display("SLL,SLA,SRA,SRL");
		$display("pc:     id_ir      :reg_A:reg_B:ALUo :reg_C:da:dd  :w:reC1:gr1 :gr2 :gr3 :ddin:exir:mmir:wbir:smdr:zf:nf:cf");
		#10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr1, 4'b1111, 4'b1111};
		#10 i_datain <= {`LDIH, `gr2, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr3, 4'b1111, 4'b1111};
		#10 i_datain <= {`SLL, `gr2, 1'b0, `gr1, 4'b0001};
		#10 i_datain <= {`SLA, `gr2, 1'b0, `gr1, 4'b0001};
		#10 i_datain <= {`SRA, `gr3, 1'b0, `gr2, 4'b0010};
		#10 i_datain <= {`SRL, `gr3, 1'b0, `gr2, 4'b0010};
		$display("LDIH,BZ,ADDI,AND,SUBI,OR,XOR");
		$display("pc:     id_ir      :reg_A:reg_B:ALUo :reg_C:da:dd  :w:reC1:gr1 :gr2 :gr3 :ddin:exir:mmir:wbir:smdr:zf:nf:cf");
		#10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr1, 4'b1111, 4'b1111};
		#10 i_datain <= {`CMP, `gr1, 1'b0, `gr1, 1'b0, `gr1};
		#10 i_datain <= {`BZ, `gr0, 4'b1011,4'b1100};
		#10 i_datain <= {`LDIH, `gr2, 4'b1111, 4'b1100};
		
      #10 i_datain <= {`ADDI, `gr3, 4'b1111, 4'b1111};
		#10 i_datain <= {`LDIH, `gr1, 8'b0000_0100 };
		#10 i_datain <= {`ADDI, `gr1, 4'b1111, 4'b1111 };
		#10 i_datain <= {`AND, `gr3, 1'b0,`gr1, 1'b0,`gr2 };
		#10 i_datain <= {`SUBI, `gr1, 4'b1100, 4'b1111 };
		#10 i_datain <= {`OR, `gr3,1'b0, `gr1,1'b0, `gr2 };
		#10 i_datain <= {`XOR, `gr3, 1'b0,`gr1, 1'b0,`gr2 };
		#10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr1, 4'b1111, 4'b1111};
		#10 i_datain <= {`LDIH, `gr2, 4'b1111, 4'b1100};					
      #10 i_datain <= {`ADDI, `gr3, 4'b1111, 4'b1111};
		#10 i_datain <= {`HALT,11'b000_0000_0000};
	end
      
	always #5 mclk = ~mclk;
   always #1 clk = ~clk;
      
endmodule

