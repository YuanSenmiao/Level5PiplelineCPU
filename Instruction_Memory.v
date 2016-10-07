`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:11:37 01/08/2015 
// Design Name: 
// Module Name:    Instruction_Memory 
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
/*`define NOP		5'b00000
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
`define gr7 3'b111*/
/********************************************************************/
/********************************************************************/
/*module Instruction_Memory(
	input wire mem_clk,
	input wire [7:0] i_addr,
	output wire [15:0] i_datain
    );

reg [15:0] Memory[255:0];
assign i_datain = Memory[i_addr];
always @ (i_addr)
begin
	case(i_addr)
		8'h01: Memory[i_addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};		//1
		8'h03: Memory[i_addr] <= {`LDIH, `gr1, 4'b1111, 4'b1100 };			//3	
      8'h04: Memory[i_addr] <= {`ADDI, `gr3, 4'b1111, 4'b1111};			//4
      8'h05: Memory[i_addr] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};		//5
		8'h06: Memory[i_addr] <= {`ADD, `gr3, 1'b0, `gr2, 1'b0, `gr2};		//6
		8'h07: Memory[i_addr] <= {`ADDC, `gr3, 1'b0, `gr2, 1'b0, `gr1};	//7
		8'h08: Memory[i_addr] <= {`SUB, `gr3, 1'b0, `gr2, 1'b0, `gr1};		//8
		8'h09: Memory[i_addr] <= {`SUBC, `gr3, 1'b0, `gr2, 1'b0, `gr1};	//9
		8'h0a: Memory[i_addr] <= {`SUBI, `gr1, 4'b1111, 4'b1111 };			//10
      8'h0b: Memory[i_addr] <= {`LDIH, `gr1, 4'b1111, 4'b1111 };			//11
		8'h0e: Memory[i_addr] <= {`SLL, `gr2, 1'b0, `gr1, 4'b0001};			//14
		8'h0f: Memory[i_addr] <= {`SLA, `gr2, 1'b0, `gr1, 4'b0001};			//15
		8'h10: Memory[i_addr] <= {`SRA, `gr3, 1'b0, `gr2, 4'b0010};			//16
		8'h11: Memory[i_addr] <= {`SRL, `gr3, 1'b0, `gr2, 4'b0010};			//17
		8'h14: Memory[i_addr] <= {`LDIH, `gr1, 8'b0000_0100 };				//20
		8'h15: Memory[i_addr] <= {`BZ, `gr3, 4'b0000, 4'b0001 };				//21
		8'h16: Memory[i_addr] <= {`ADDI, `gr1, 4'b1111, 4'b1111 };			//22
		8'h17: Memory[i_addr] <= {`AND, `gr3, 1'b0,`gr1, 1'b0,`gr2 };		//23
		8'h18: Memory[i_addr] <= {`SUBI, `gr1, 4'b1100, 4'b1111 };			//24
		8'h19: Memory[i_addr] <= {`OR, `gr3,1'b0, `gr1,1'b0, `gr2 };		//25
		8'h1a: Memory[i_addr] <= {`XOR, `gr3, 1'b0,`gr1, 1'b0,`gr2 };		//26
		8'h1b: Memory[i_addr] <= {`JUMP, 3'b000, 4'b0010, 4'b0010};			//27
		8'h22: Memory[i_addr] <= {`HALT, 11'b000_0000_0000};					//34
		8'h23: Memory[i_addr] <= {`HALT, 11'b000_0000_0000};					//35
		default:	Memory[i_addr] <= {`NOP, 11'b000_0000_0000};
	endcase
end*/
/******************************************************************************************/
`define idle	1'b0
`define exec	1'b1
// instruction 
`define NOP	5'b00000
`define HALT	5'b00001
`define LOAD	5'b00010
`define STORE	5'b00011
`define SLL	5'b00100
`define SLA	5'b00101
`define SRL	5'b00110
`define SRA	5'b00111
`define ADD	5'b01000
`define ADDI	5'b01001
`define SUB	5'b01010
`define SUBI	5'b01011
`define CMP	5'b01100
`define AND	5'b01101
`define OR	5'b01110
`define XOR	5'b01111
`define LDIH	5'b10000
`define ADDC	5'b10001
`define SUBC	5'b10010
`define JUMP	5'b11000
`define JMPR	5'b11001
`define BZ	5'b11010
`define BNZ	5'b11011
`define BN	5'b11100
`define BNN	5'b11101
`define BC	5'b11110
`define BNC	5'b11111
//register 
`define gr0	3'b000
`define gr1	3'b001
`define gr2	3'b010
`define gr3	3'b011
`define gr4	3'b100
`define gr5	3'b101
`define gr6	3'b110
`define gr7	3'b111
/******************************************************************************************/
module Instruction_Memory(
	input wire mem_clk,
	input wire [7:0] addr,
	output wire [15:0] i_datain
    );

reg [15:0] i_mem [255:0];

assign i_datain = i_mem[addr];
always @(addr)
	case(addr)
	
	//------------------------------------TA的测试---------------------------------------//
	//最大公因数 最小公倍数：gcm
	/*8'h00: i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h01: i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
	8'h02: i_mem[addr] <= {`ADD, `gr3, 1'b0, `gr0, 1'b0, `gr1};//(1)
	8'h03: i_mem[addr] <= {`SUB, `gr1, 1'b0, `gr1, 1'b0, `gr2};
	8'h04: i_mem[addr] <= {`BZ, `gr0, 8'b0000_1001}; //jump to (2)
	8'h05: i_mem[addr] <= {`BNN, `gr0,  8'b0000_0010}; //jump to (1)
	8'h06: i_mem[addr] <= {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr2};
	8'h07: i_mem[addr] <= {`ADD, `gr2, 1'b0, `gr0, 1'b0, `gr3};
	8'h08:i_mem[addr] <= {`JUMP, 11'b000_0000_0010};//jump to (1)
	8'h09:i_mem[addr] <= {`STORE, `gr2, 1'b0, `gr0, 4'b0011}; //(2)
	8'h0a: i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h0b: i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
	8'h0c:i_mem[addr] <= {`ADDI, `gr4, 8'h1}; //(3)
	8'h0d:i_mem[addr] <= {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr3};
	8'h0e:i_mem[addr] <= {`BZ, `gr0, 8'b0001_0000}; //jump to (4)
	8'h0f:i_mem[addr] <= {`JUMP, 11'b000_0000_1100}; //jump to (3)
	8'h10:i_mem[addr] <= {`SUBI, `gr4, 8'h1}; //(4)
	8'h11:i_mem[addr] <= {`BN, `gr0, 8'b0001_0100}; //jump to (5)
	8'h12:i_mem[addr] <= {`ADD, `gr5, 1'b0, `gr5, 1'b0, `gr1};
	8'h13:i_mem[addr] <= {`JUMP, 11'b000_0001_0000}; //jump to (4)
	8'h14:i_mem[addr] <= {`STORE, `gr5, 1'b0, `gr0, 4'b0100}; //(5)
	8'h15:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};//最大公因数
	8'h16:i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0100};//最小公倍数
	8'h17:i_mem[addr] <= {`HALT, 11'b000_0000_0000};*/
	
	//冒泡排序
	/*8'h00: i_mem[addr] <= {`LOAD, `gr3, 1'b0, `gr0, 4'b0000};
	8'h01: i_mem[addr] <= {`SUBI, `gr3, 4'd0, 4'd2};
	8'h02: i_mem[addr] <= {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr0};
	8'h03: i_mem[addr] <= {`ADD, `gr2, 1'b0, `gr3, 1'b0, `gr0}; // loop1
	8'h04: i_mem[addr] <= {`LOAD, `gr4, 1'b0, `gr2, 4'd1}; // loop2
	8'h05: i_mem[addr] <= {`LOAD, `gr5, 1'b0, `gr2, 4'd2};
	8'h06: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr5, 1'b0, `gr4};
	8'h07: i_mem[addr] <= {`BN, `gr0, 4'b0000, 4'b1010};
	8'h08:i_mem[addr] <= {`STORE, `gr4, 1'b0, `gr2, 4'd2};
	8'h09:i_mem[addr] <= {`STORE, `gr5, 1'b0, `gr2, 4'd1};
	8'h0a: i_mem[addr] <= {`SUBI, `gr2, 4'd0, 4'd1};
	8'h0b: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr2, 1'b0, `gr1};
	8'h0c:i_mem[addr] <= {`BNN, `gr0, 4'h0, 4'b0100};
	8'h0d:i_mem[addr] <= {`ADDI, `gr1, 4'd0, 4'd1};
	8'h0e:i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr1};
	8'h0f:i_mem[addr] <= {`BNN, `gr0, 4'h0, 4'b0011};
	8'h10:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h11:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h12:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h13:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'h14:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'h15:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'h16:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'h17:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'h18:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'h19:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'h1a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'h1b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'h1c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'h1d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'h1e:i_mem[addr] <= {`HALT, 11'd0};*/
	//sort
	/*8'h00: i_mem[addr] <= {`ADDI, `gr1, 4'b0000,  4'b1001};
	8'h01: i_mem[addr] <= {`ADDI, `gr2, 4'b0000,  4'b1001};
	8'h02: i_mem[addr] <= {`JUMP, 11'b000_0000_0101};//jump to start
	8'h03: i_mem[addr] <= {`SUBI, `gr1, 4'd0, 4'd1};//new_round
	8'h04: i_mem[addr] <= {`BZ, `gr7, 4'b0001, 4'b0010};//jump to end
	8'h05: i_mem[addr] <= {`LOAD, `gr3, 1'b0, `gr0, 4'd0};//start
	8'h06: i_mem[addr] <= {`LOAD, `gr4, 1'b0, `gr0, 4'd1};
	8'h07: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr4};
	8'h08:i_mem[addr] <= {`BN, `gr7, 4'h0, 4'b1011};//jump to NO_op
	8'h09:i_mem[addr] <= {`STORE, `gr3, 1'b0, `gr0, 4'd1};
	8'h0a: i_mem[addr] <= {`STORE, `gr4, 1'b0, `gr0, 4'd0};
	8'h0b: i_mem[addr] <= {`ADDI, `gr0, 4'b0000, 4'b0001};//NO_OP
	8'h0c:i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr0, 1'b0, `gr2};
	8'h0d:i_mem[addr] <= {`BN, `gr7, 4'b0001, 4'b0001};//jump to continue 
	8'h0e:i_mem[addr] <= {`SUBI, `gr2, 4'd0, 4'd1};
	8'h0f:i_mem[addr] <= {`SUB, `gr0, 1'b0,`gr0, 1'b0,`gr0};
	8'h10:i_mem[addr] <= {`JUMP, 11'b000_0000_0011};//jump to new round
	8'h11:i_mem[addr] <= {`JUMP, 11'b000_0000_0101};//jump to start,continue
	8'h12:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h13:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h14:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h15:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'h16:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'h17:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'h18:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'h19:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'h1a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'h1b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'h1c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'h1d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'h1e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'h1f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'h20:i_mem[addr] <= {`HALT, 11'd0};//end */
	   
	//64位加法:64badder
	/*8'h00:i_mem[addr] <=16'h4c04 ;	//{`ADDI, `gr4, 8'h4};
	8'h01:i_mem[addr] <=16'h1100 ;	//{`LOAD, `gr1, 8'h0};
	8'h02:i_mem[addr] <=16'h1204 ;	//{`LOAD, `gr2, 8'h4};
	8'h03:i_mem[addr] <=16'h4312 ;	//{`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
	8'h04:i_mem[addr] <=16'hfd06 ;	//{`BNC, `gr5, 8'h6};//bnc to 6	
	8'h05:i_mem[addr] <=16'h4e01 ;	//{`ADDI, `gr6, 8'h1};
	8'h06:i_mem[addr] <=16'h4337 ;	//{`ADD, `gr3, 1'b0, `gr3, 1'b0, `gr7};
	8'h07:i_mem[addr] <=16'hfd0b ;	//{`BNC, `gr5, 8'hb};//bnc to 11
	8'h08:i_mem[addr] <=16'h5e00 ;	//{`SUBI, `gr6, 8'h0};
	8'h09:i_mem[addr] <=16'hdd0b ;	//{`BNZ, `gr5, 8'hb};//bnz to 11
	8'h0a:i_mem[addr] <=16'h4e01 ;	//{`ADDI, `gr6, 8'h1};
	8'h0b:i_mem[addr] <=16'h5777 ;	//{`SUB, `gr7, 1'b0, `gr7, 1'b0, `gr7};
	8'h0c:i_mem[addr] <=16'h4776 ;	//{`ADD, `gr7, 1'b0, `gr7, 1'b0, `gr6};
	8'h0d:i_mem[addr] <=16'h5666 ;	//{`SUB, `gr6, 1'b0, `gr6, 1'b0, `gr6};
	8'h0e:i_mem[addr] <=16'h1b08 ;	//{`STORE, `gr6, 8'h8};
	8'h0f:i_mem[addr] <=16'h4801 ;	//{`ADDI, `gr0,8'h1};
	8'h10:i_mem[addr] <=16'h6004 ;	//{`CMP, 4'b0, `gr0, 1'b0, `gr4};
	8'h11:i_mem[addr] <=16'he501 ;	//{`BN, `gr5, 8'h1};//bn to 1
	8'h12:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0000};
	8'h13:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0001};
	8'h14:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0010};
	8'h15:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0011};
	8'h16:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0100};
	8'h17:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0101};
	8'h18:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0110};
	8'h19:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b0111};
	8'h1a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1000};
	8'h1b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1001};
	8'h1c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1010};
	8'h1d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1011};
	8'h1e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1100};
	8'h1f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr5, 4'b1101};
	8'h20:i_mem[addr] <=16'h0800 ;	//{`HALT, 11'b0};*/
		     	
	//所有指令测一遍：tinit_test
	8'h00:i_mem[addr]=16'h4f10 ;//00{`ADDI,`gr7,4'd1,4'd0};              // gr7 <= 16'h10 for store address
	8'h01:i_mem[addr]=16'h81b6 ;//01{`LDIH,`gr1,4'b1011,4'b0110};        // test for LDIH  gr1<="16'hb600"
	8'h02:i_mem[addr]=16'h1970 ;//02{`STORE,`gr1,1'b0,`gr7,4'h0};        ;// store to mem10	
	8'h03:i_mem[addr]=16'h1100 ;//03{`LOAD,`gr1,1'b0,`gr0,4'h0};         ;// gr1 <= fffd 
	8'h04:i_mem[addr]=16'h1201 ;//04{`LOAD,`gr2,1'b0,`gr0,4'h1};         ;// gr2 <= 4
	8'h05:i_mem[addr]=16'h8b12 ;//05{`ADDC,`gr3,1'b0,`gr1,1'b0,`gr2};    ;// gr3 <= fffd + 4 + cf(=0) = 1, cf<=1
	8'h06:i_mem[addr]=16'h1b71 ;//06{`STORE,`gr3,1'b0,`gr7,4'h1};        ;// store to mem11		
	8'h07:i_mem[addr]=16'h8b02 ;//07{`ADDC,`gr3,1'b0,`gr0,1'b0,`gr2};    ;// gr3 <= 0 + 4 + cf(=1) = 5, cf<=0
	8'h08:i_mem[addr]=16'h1b72 ;//08{`STORE,`gr3,1'b0,`gr7,4'h2};        ;// store to mem12
	8'h09:i_mem[addr]=16'h1102 ;//09{`LOAD,`gr1,1'b0,`gr0,4'h2};          ;// gr1 <= 5 
	8'h0a:i_mem[addr]=16'h9312 ;//0a{`SUBC,`gr3,1'b0,`gr1,1'b0,`gr2};    ;// gr3 <= 5 - 4 + cf(=0) =1, cf<=0    
	8'h0b:i_mem[addr]=16'h1b73 ;//0b{`STORE,`gr3,1'b0,`gr7,4'h3};        ;// store to mem13		
	8'h0c:i_mem[addr]=16'h5321 ;//0c{`SUB,`gr3,1'b0,`gr2,1'b0,`gr1};     ;// gr3 <= 4 - 5 = -1, cf<=1    
	8'h0d:i_mem[addr]=16'h1b74 ;//0d{`STORE,`gr3,1'b0,`gr7,4'h4};        ;// store to mem14		
	8'h0e:i_mem[addr]=16'h9321 ;//0e{`SUBC,`gr3,1'b0,`gr2,1'b0,`gr1};    ;// gr3 <= 5 - 4 - cf(=1) =2, cf<=0 
	8'h0f:i_mem[addr]=16'h1b75 ;//0f{`STORE,`gr3,1'b0,`gr7,4'h5};        ;// store to mem15		
	8'h10:i_mem[addr]=16'h1103 ;//10{`LOAD,`gr1,1'b0,`gr0,4'h3};         ;// gr1 <= c369
	8'h11:i_mem[addr]=16'h1204 ;//11{`LOAD,`gr2,1'b0,`gr0,4'h4};         ;// gr2 <= 69c3		
	8'h12:i_mem[addr]=16'h6b12 ;//12{`AND,`gr3,1'b0,`gr1,1'b0,`gr2};     ;// gr3 <= gr1 & gr2 = 4141
	8'h13:i_mem[addr]=16'h1b76 ;//13{`STORE,`gr3,1'b0,`gr7,4'h6};        ;// store to mem16		
	8'h14:i_mem[addr]=16'h7312 ;//14{`OR,`gr3,1'b0,`gr1,1'b0,`gr2};      ;// gr3 <= gr1 | gr2 = ebeb
	8'h15:i_mem[addr]=16'h1b77 ;//15{`STORE,`gr3,1'b0,`gr7,4'h7};        ;// store to mem17		
	8'h16:i_mem[addr]=16'h7b12 ;//16{`XOR,`gr3,1'b0,`gr1,1'b0,`gr2};     ;// gr3 <= gr1 ^ gr2 = aaaa
	8'h17:i_mem[addr]=16'h1b78 ;//17{`STORE,`gr3,1'b0,`gr7,4'h8};        ;// store to mem18
	8'h18:i_mem[addr]=16'h2310 ;//18{`SLL,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 < 0 
	8'h19:i_mem[addr]=16'h1b79 ;//19{`STORE,`gr3,1'b0,`gr7,4'h9};        ;// store to mem19		
	8'h1a:i_mem[addr]=16'h2311 ;//1a{`SLL,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 < 1 
	8'h1b:i_mem[addr]=16'h1b7a ;//1b{`STORE,`gr3,1'b0,`gr7,4'ha};        ;// store to mem1a		
	8'h1c:i_mem[addr]=16'h2314 ;//1c{`SLL,`gr3,1'b0,`gr1,4'h4};          ;// gr3 <= gr1 < 8 
	8'h1d:i_mem[addr]=16'h1b7b ;//1d{`STORE,`gr3,1'b0,`gr7,4'hb};        ;// store to mem1b	
	8'h1e:i_mem[addr]=16'h231f ;//1e{`SLL,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 < 15 
	8'h1f:i_mem[addr]=16'h1b7c ;//1f{`STORE,`gr3,1'b0,`gr7,4'hc};        ;// store to mem1c
	8'h20:i_mem[addr]=16'h3310 ;//20{`SRL,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 > 0
	8'h21:i_mem[addr]=16'h1b7d ;//21{`STORE,`gr3,1'b0,`gr7,4'hd};        ;// store to mem1d		
	8'h22:i_mem[addr]=16'h3311 ;//22{`SRL,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 > 1
	8'h23:i_mem[addr]=16'h1b7e ;//23{`STORE,`gr3,1'b0,`gr7,4'he};        ;// store to mem1e		
	8'h24:i_mem[addr]=16'h3318 ;//24{`SRL,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 > 8
	8'h25:i_mem[addr]=16'h1b7f ;//25{`STORE,`gr3,1'b0,`gr7,4'hf};        ;// store to mem1f		
	8'h26:i_mem[addr]=16'h331f ;//26{`SRL,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 > 15
	8'h27:i_mem[addr]=16'h4f10 ;//27{`ADDI,`gr7,4'd1,4'd0};              ;// gr7 <= 16'h20 for store address
	8'h28:i_mem[addr]=16'h1b70 ;//28{`STORE,`gr3,1'b0,`gr7,4'h0};        ;// store to mem20
	8'h29:i_mem[addr]=16'h2b10 ;//29{`SLA,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 < 0
	8'h2a:i_mem[addr]=16'h1b71 ;//2a{`STORE,`gr3,1'b0,`gr7,4'h1};        ;// store to mem21
	8'h2b:i_mem[addr]=16'h2b11 ;//2b{`SLA,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 < 1 
	8'h2c:i_mem[addr]=16'h1b72 ;//2c{`STORE,`gr3,1'b0,`gr7,4'h2};        ;// store to mem22
	8'h2d:i_mem[addr]=16'h2b18 ;//2d{`SLA,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 < 8 
	8'h2e:i_mem[addr]=16'h1b73 ;//2e{`STORE,`gr3,1'b0,`gr7,4'h3};        ;// store to mem23
	8'h2f:i_mem[addr]=16'h2b1f ;//2f{`SLA,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 < 15
	8'h30:i_mem[addr]=16'h1b74 ;//30{`STORE,`gr3,1'b0,`gr7,4'h4};        ;// store to mem24
	8'h31:i_mem[addr]=16'h2b20 ;//31{`SLA,`gr3,1'b0,`gr2,4'h0};          ;// gr3 <= gr1 < 0
	8'h32:i_mem[addr]=16'h1b75 ;//32{`STORE,`gr3,1'b0,`gr7,4'h5};        ;// store to mem25
	8'h33:i_mem[addr]=16'h2b21 ;//33{`SLA,`gr3,1'b0,`gr2,4'h1};          ;// gr3 <= gr1 < 1
	8'h34:i_mem[addr]=16'h1b76 ;//34{`STORE,`gr3,1'b0,`gr7,4'h6};        ;// store to mem26
	8'h35:i_mem[addr]=16'h2b28 ;//35{`SLA,`gr3,1'b0,`gr2,4'h8};          ;// gr3 <= gr1 < 8
	8'h36:i_mem[addr]=16'h1b77 ;//36{`STORE,`gr3,1'b0,`gr7,4'h7};        ;// store to mem27
	8'h37:i_mem[addr]=16'h2b2f ;//37{`SLA,`gr3,1'b0,`gr2,4'hf};          ;// gr3 <= gr1 < 15
	8'h38:i_mem[addr]=16'h1b78 ;//38{`STORE,`gr3,1'b0,`gr7,4'h8};        ;// store to mem28
	8'h39:i_mem[addr]=16'h3b10 ;//39{`SRA,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 > 0
	8'h3a:i_mem[addr]=16'h1b79 ;//3a{`STORE,`gr3,1'b0,`gr7,4'h9};        ;// store to mem29
	8'h3b:i_mem[addr]=16'h3b11 ;//3b{`SRA,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 > 1
	8'h3c:i_mem[addr]=16'h1b7a ;//3c{`STORE,`gr3,1'b0,`gr7,4'ha};        ;// store to mem2a
	8'h3d:i_mem[addr]=16'h3b18 ;//3d{`SRA,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 > 8
	8'h3e:i_mem[addr]=16'h1b7b ;//3e{`STORE,`gr3,1'b0,`gr7,4'hb};        ;// store to mem2b
	8'h3f:i_mem[addr]=16'h3b1f ;//3f{`SRA,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 > 15
	8'h40:i_mem[addr]=16'h1b7c ;//40{`STORE,`gr3,1'b0,`gr7,4'hc};        ;// store to mem2c
	8'h41:i_mem[addr]=16'h3b20 ;//41{`SRA,`gr3,1'b0,`gr2,4'h0};          ;// gr3 <= gr1 > 0
	8'h42:i_mem[addr]=16'h1b7d ;//42{`STORE,`gr3,1'b0,`gr7,4'hd};        ;// store to mem2d
	8'h43:i_mem[addr]=16'h3b21 ;//43{`SRA,`gr3,1'b0,`gr2,4'h1};          ;// gr3 <= gr1 > 1
	8'h44:i_mem[addr]=16'h1b7e ;//44{`STORE,`gr3,1'b0,`gr7,4'he};        ;// store to mem2e
	8'h45:i_mem[addr]=16'h3b28 ;//45{`SRA,`gr3,1'b0,`gr2,4'h8};          ;// gr3 <= gr1 > 8
	8'h46:i_mem[addr]=16'h1b7f ;//46{`STORE,`gr3,1'b0,`gr7,4'hf};        ;// store to mem2f
	8'h47:i_mem[addr]=16'h4f10 ;//47{`ADDI,`gr7,4'd1,4'd0};              ;// gr7 <= 16'h30 for store address
	8'h48:i_mem[addr]=16'h3b2f ;//48{`SRA,`gr3,1'b0,`gr2,4'hf};          ;// gr3 <= gr1 > 15
	8'h49:i_mem[addr]=16'h1b70 ;//49{`STORE,`gr3,1'b0,`gr7,4'h0};        ;// store to mem30		
	8'h4a:i_mem[addr]=16'h1105 ;//4a{`LOAD,`gr1,1'b0,`gr0,4'h5};         ;// gr1 <= 41
	8'h4b:i_mem[addr]=16'h1206 ;//4b{`LOAD,`gr2,1'b0,`gr0,4'h6};         ;// gr2 <= ffff
	8'h4c:i_mem[addr]=16'h1307 ;//4c{`LOAD,`gr3,1'b0,`gr0,4'h7};         ;// gr3 <= 1
	8'h4d:i_mem[addr]=16'hc04f ;//4d{`JUMP, 3'd0,8'h4f};                 ;// jump to 4f
	8'h4e:i_mem[addr]=16'h1f71 ;//4e{`STORE,`gr7,1'b0,`gr7,4'h1};        ;// store to mem31
	8'h4f:i_mem[addr]=16'hc910 ;//4f{`JMPR, `gr1,8'h10};                 ;// jump to 41+10 = 51
	8'h50:i_mem[addr]=16'h1f72 ;//50{`STORE,`gr7,1'b0,`gr7,4'h2};        ;// store to mem32
	8'h51:i_mem[addr]=16'h4423 ;//51{`ADD, `gr4,1'b0,`gr2,1'b0,`gr3};    ;// gr4<= ffff + 1,cf<=1
	8'h52:i_mem[addr]=16'hf928 ;//52{`BNC,`gr1,8'h28};                   ;// if(cf==0) jump to 69
	8'h53:i_mem[addr]=16'hf114 ;//53{`BC,`gr1,8'h14};                    ;// if(cf==1) jump to 55
	8'h54:i_mem[addr]=16'h1f73 ;//54{`STORE,`gr7,1'b0,`gr7,4'h3};        ;// store to mem33
	8'h55:i_mem[addr]=16'h4433 ;//55{`ADD, `gr4,1'b0,`gr3,1'b0,`gr3};    ;// gr4<= 1 + 1 , cf<=0
	8'h56:i_mem[addr]=16'hf128 ;//56{`BC,`gr1,8'h28};                    ;// if(cf==1) jump to 69
	8'h57:i_mem[addr]=16'hf918 ;//57{`BNC,`gr1,8'h18};                   ;// if(cf==0) jump to 59
	8'h58:i_mem[addr]=16'h1f74 ;//58{`STORE,`gr7,1'b0,`gr7,4'h4};        ;// store to mem34
	8'h59:i_mem[addr]=16'h6033 ;//59{`CMP, 3'd0,1'b0,`gr3,1'b0,`gr3};    ;// 1-1=0 , zf<=1,nf<=0
	8'h5a:i_mem[addr]=16'hd928 ;//5a{`BNZ,`gr1,8'h28};                   ;// if(zf==0) jump to 69
	8'h5b:i_mem[addr]=16'hd11c ;//5b{`BZ,`gr1,8'h1c};                    ;// if(zf==1) jump to 5d
	8'h5c:i_mem[addr]=16'h1f75 ;//5c{`STORE,`gr7,1'b0,`gr7,4'h5};        ;// store to mem35
	8'h5d:i_mem[addr]=16'h6043 ;//5d{`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    ;// 2-1=1 , zf<=0,nf<=0 
	8'h5e:i_mem[addr]=16'hd128 ;//5e{`BZ,`gr1,8'h28};                    ;// if(zf==1) jump to 69
	8'h5f:i_mem[addr]=16'hd920 ;//5f{`BNZ,`gr1,8'h20};                   ;// if(zf==0) jump to 61
	8'h60:i_mem[addr]=16'h1f76 ;//60{`STORE,`gr7,1'b0,`gr7,4'h6};        ;// store to mem36
	8'h61:i_mem[addr]=16'h6034 ;//61{`CMP, 3'd0,1'b0,`gr3,1'b0,`gr4};    ;// 1-2=-1, nf<=1,zf<=0
	8'h62:i_mem[addr]=16'he928 ;//62{`BNN,`gr1,8'h28};                   ;// if(nf==0) jump to 69
	8'h63:i_mem[addr]=16'he124 ;//63{`BN,`gr1,8'h24};                    ;// if(nf==1) jump to 65 
	8'h64:i_mem[addr]=16'h1f77 ;//64{`STORE,`gr7,1'b0,`gr7,4'h7};        ;// store to mem37
	8'h65:i_mem[addr]=16'h6043 ;//65{`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    ;// 2-1=1, nf<=0,zf<=0
	8'h66:i_mem[addr]=16'he128 ;//66{`BN,`gr1,8'h28};                    ;// if(nf==1) jump to 69
	8'h67:i_mem[addr]=16'he927 ;//67{`BNN,`gr1,8'h27};                   ;// if(nf==0) jump to 68
	8'h68:i_mem[addr]=16'h1f78 ;//68{`STORE,`gr7,1'b0,`gr7,4'h8};        ;// store to mem38
	8'h69:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h6a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h6b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h6c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'h6d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'h6e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'h6f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'h70:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'h71:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'h72:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'h73:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'h74:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'h75:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'h76:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'h77:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1110};
	8'h78:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1111};
	8'h79:i_mem[addr] <= {`ADDI, `gr0, 8'h10};
	8'h7a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h7b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h7c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h7d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'h7e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'h7f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'h80:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'h81:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'h82:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'h83:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'h84:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'h85:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'h86:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'h87:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'h88:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1110};
	8'h89:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1111};
	8'h8a:i_mem[addr] <= {`ADDI, `gr0, 8'h10};
	8'h8b:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h8c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h8d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h8e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'h8f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'h90:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'h91:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'h92:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'h93:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'h94:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'h95:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'h96:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'h97:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'h98:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'h99:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1110};
	8'h9a:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1111};
	8'h9b:i_mem[addr] <= {`ADDI, `gr0, 8'h10};
	8'h9c:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
	8'h9d:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	8'h9e:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0010};
	8'h9f:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};
	8'ha0:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0100};
	8'ha1:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0101};
	8'ha2:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0110};
	8'ha3:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0111};
	8'ha4:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1000};
	8'ha5:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1001};
	8'ha6:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1010};
	8'ha7:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1011};
	8'ha8:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1100};
	8'ha9:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1101};
	8'haa:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1110};
	8'hab:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b1111};
	8'hac:i_mem[addr]=16'h0800 ;//69{`HALT, 11'd0};                      // STOP
	default: i_mem[addr] <= {`HALT, 11'b000_0000_0000};
	endcase
endmodule

