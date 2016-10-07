`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:52 01/08/2015 
// Design Name: 
// Module Name:    PCPU 
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
`define exec	1'b1*/
/**********************************************************/
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
/*register 
`define gr0	3'b000
`define gr1	3'b001
`define gr2	3'b010
`define gr3	3'b011
`define gr4	3'b100
`define gr5	3'b101
`define gr6	3'b110
`define gr7	3'b111*/
/******************************************************************************************/

module PCPU(
	input wire clk, mclk, reset, enable, start,
	input wire [15:0] i_datain, d_datain,
	output reg d_we, 
	output reg [7:0]d_addr, pc,
	output reg [15:0]d_dataout,
	output wire [2:0] red, green,
	output wire [1:0] blue,
	output hs, vs
    );
/**********************************************************/
/**********************************************************/
reg state, PcFlag;
reg [7:0] beq;
reg [15:0] gr[7:0];
reg [15:0] id_ir, wb_ir, mem_ir;
reg signed [15:0] reg_A;
reg [15:0] reg_B, smdr=16'b0, ex_ir;
reg [15:0] reg_C, reg_C1;
reg [15:0] smdr1, ALU0;
reg cf, in;
wire zf,nf;
/**********************************************************/
initial
begin
	beq <= 8'b0;
	pc <= 8'b0;
end
assign i_addr = pc;
/**********************************************************/
//CPU_Control
reg next_state = 1'b0;
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		state <= `idle;
	else
		state <= next_state;
end
always @ (*)
begin
	case(state)
		`idle: begin
					if((enable==1'b1)&&(start==1'b1))	next_state <= `exec;
					else											next_state <= `idle;
				 end
		`exec: begin
					if((enable==1'b0)||(wb_ir[15:11]==`HALT))	next_state <= `idle;
					else													next_state <= `exec;
				 end
		default:	next_state <= `idle;
	endcase
end
/*******************************************************************************/
/*******************************************************************************/
//CPU_IF 
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		begin
			id_ir <= 16'b0;
			pc <= 8'b0;
		end
	else if(state == `exec)
		begin
			if(((id_ir[15:11]==`BZ)&&(zf==1'b1))||((id_ir[15:11]==`BNZ)&&(zf==1'b0))
				||((id_ir[15:11]==`BN)&&(nf==1'b1))||((id_ir[15:11]==`BNN)&&(nf==1'b0))
				||((id_ir[15:11]==`BC)&&(cf==1'b1))||((id_ir[15:11]==`BNC)&&(cf==1'b0))||(id_ir[15:11]==`JMPR))
				begin
					pc <= beq;
					id_ir <= {`NOP, 11'b000_0000_0000};
					//id_ir <= i_datain;
				end
			else if(id_ir[15:11]==`JUMP)
				begin
					pc <= id_ir[7:0];
					id_ir <= {`NOP, 11'b000_0000_0000};
					//id_ir <= i_datain;
				end
				/*****************************Operation of "LOAD"*****************************/
			else if ((id_ir[15:11]==`LOAD)&&(i_datain[15:11]!=`JUMP)&&(i_datain[15:11]!=`NOP)
						&&(i_datain[15:11]!=`HALT)&&(i_datain[15:11]!=`LOAD))
				begin
					/*********r1*********/
					if((id_ir[10:8]==i_datain[2:0])&&((i_datain[15:11]==`ADD)||(i_datain[15:11]==`ADDC)
						||(i_datain[15:11]==`SUB)||(i_datain[15:11]==`SUBC)||(i_datain[15:11]==`CMP)
						||(i_datain[15:11]==`AND)||(i_datain[15:11]==`OR)||(i_datain[15:11]==`XOR)))
						begin
							pc <= pc;
							id_ir <= 16'bx;
						end
					/*********r2*********/
					else if((id_ir[10:8]==i_datain[6:4])&&((i_datain[15:11]==`STORE)||(i_datain[15:11]==`ADD)||(i_datain[15:11]==`ADDC)
						||(i_datain[15:11]==`SUB)||(i_datain[15:11]==`SUBC)||(i_datain[15:11]==`CMP)||(i_datain[15:11]==`AND)
						||(i_datain[15:11]==`OR)||(i_datain[15:11]==`XOR)||(i_datain[15:11]==`SLL)||(i_datain[15:11]==`SRL)
						||(i_datain[15:11]==`SLA)||(i_datain[15:11]==`SRA)))		//r2
						begin
							pc <= pc;
							id_ir <= 16'bx;
						end
					/*********r3*********/
					else if((id_ir[10:8]==i_datain[10:8])&&((i_datain[15:11]==`STORE)||(i_datain[15:11]==`LDIH)
							||(i_datain[15:11]==`ADDI)||(i_datain[15:11]==`SUBI)||(i_datain[15:11]==`JMPR)||(i_datain[15:11]==`BZ)
							||(i_datain[15:11]==`BNZ)||(i_datain[15:11]==`BN)||(i_datain[15:11]==`BNN)||(i_datain[15:11]==`BC)
							||(i_datain[15:11]==`BNC)))
						begin
							pc <= pc;
							id_ir <= 16'bx;
						end
					else
					begin
						pc <= pc +1'b1;
						id_ir <= i_datain;
					end
				end
			else
				begin
					/*******************************************************************/
					if((i_datain[15:11]==`BZ)||(i_datain[15:11]==`BNZ)||(i_datain[15:11]==`BN)||(i_datain[15:11]==`BNN)
						||(i_datain[15:11]==`BC)||(i_datain[15:11]==`BNC)||(i_datain[15:11]==`JMPR))
					begin
						if((i_datain[10:8]==id_ir[10:8])&&(id_ir[15:11]!=`NOP)&&(id_ir[15:11]!=`HALT)&&(id_ir[15:11]!=`STORE)
						&&(id_ir[15:11]!=`CMP)&&(id_ir[15:11]!=`JUMP)&&(id_ir[15:11]!=`JMPR)&&(id_ir[15:11]!=`BZ)
							&&(id_ir[15:11]!=`BNZ)&&(id_ir[15:11]!=`BN)&&(id_ir[15:11]!=`BNN)&&(id_ir[15:11]!=`BC)
							&&(id_ir[15:11]!=`BNC))
							begin
								pc <= pc;
								id_ir <= 16'bx;
							end
						else if((i_datain[10:8]==ex_ir[10:8])&&(ex_ir[15:11]!=`NOP)&&(ex_ir[15:11]!=`HALT)&&(ex_ir[15:11]!=`LOAD)
						&&(ex_ir[15:11]!=`CMP)&&(ex_ir[15:11]!=`JUMP)&&(ex_ir[15:11]!=`JMPR)&&(ex_ir[15:11]!=`BZ)
							&&(ex_ir[15:11]!=`BNZ)&&(ex_ir[15:11]!=`BN)&&(ex_ir[15:11]!=`BNN)&&(ex_ir[15:11]!=`BC)
							&&(ex_ir[15:11]!=`BNC))
							begin
								beq <= ALU0 + i_datain[7:0];
								pc <= pc + 1'b1;
								id_ir <= i_datain;
							end
						else if((i_datain[10:8]==mem_ir[10:8])&&(mem_ir[15:11]!=`NOP)&&(mem_ir[15:11]!=`HALT)
						&&(mem_ir[15:11]!=`CMP)&&(mem_ir[15:11]!=`JUMP)&&(mem_ir[15:11]!=`JMPR)&&(mem_ir[15:11]!=`BZ)
							&&(mem_ir[15:11]!=`BNZ)&&(mem_ir[15:11]!=`BN)&&(mem_ir[15:11]!=`BNN)&&(mem_ir[15:11]!=`BC)
							&&(mem_ir[15:11]!=`BNC))
							begin
								if(mem_ir[15:11]==`LOAD)	beq <= d_datain+i_datain[7:0];
								else								beq <= reg_C+i_datain[7:0];
								pc <= pc + 1'b1;
								id_ir <= i_datain;
							end
						else if((i_datain[10:8]==wb_ir[10:8])&&(wb_ir[15:11]!=`NOP)&&(wb_ir[15:11]!=`HALT)
						&&(wb_ir[15:11]!=`CMP)&&(wb_ir[15:11]!=`JUMP)&&(wb_ir[15:11]!=`JMPR)&&(wb_ir[15:11]!=`BZ)
							&&(wb_ir[15:11]!=`BNZ)&&(wb_ir[15:11]!=`BN)&&(wb_ir[15:11]!=`BNN)&&(wb_ir[15:11]!=`BC)
							&&(wb_ir[15:11]!=`BNC))
							begin
								beq <= reg_C1+i_datain[7:0];
								pc <= pc + 1'b1;
								id_ir <= i_datain;
							end
						else
							begin
								beq <= gr[i_datain[10:8]] + i_datain[7:0];
								pc <= pc + 1'b1;
								id_ir <= i_datain;
							end
					end
					else
					begin
						pc <= pc + 1'b1;
						id_ir <= i_datain;
					end
/*******************************************************************************/
				end
		end
		else if(state == `idle)
			pc <= pc;
end
/*******************************************************************************/
/*******************************************************************************/
//CPU_ID 
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		begin
			reg_A	<= 16'b0;
			reg_B	<= 16'b0;
			smdr	<= 16'b0;
			ex_ir	<= 16'b0;
		end
/*******************************************************************************/
	else if(state == `exec)
		begin
			ex_ir <= id_ir;
			/*********************Hazard for reg_A*********************/
/****************************************************************************/
			if((id_ir[15:11]==`ADDI)||(id_ir[15:11]==`SUBI)||(id_ir[15:11]==`LDIH))
				begin
					if((id_ir[10:8]==ex_ir[10:8])&&(ex_ir[15:11]!=`NOP)&&(ex_ir[15:11]!=`HALT)&&(ex_ir[15:11]!=`LOAD)
						&&(ex_ir[15:11]!=`CMP)&&(ex_ir[15:11]!=`JUMP)&&(ex_ir[15:11]!=`JMPR)&&(ex_ir[15:11]!=`BZ)
							&&(ex_ir[15:11]!=`BNZ)&&(ex_ir[15:11]!=`BN)&&(ex_ir[15:11]!=`BNN)&&(ex_ir[15:11]!=`BC)
							&&(ex_ir[15:11]!=`BNC))
						begin		reg_A <= ALU0;		end
					else if((id_ir[10:8]==mem_ir[10:8])&&(mem_ir[15:11]!=`NOP)&&(mem_ir[15:11]!=`HALT)
						&&(mem_ir[15:11]!=`CMP)&&(mem_ir[15:11]!=`JUMP)&&(mem_ir[15:11]!=`JMPR)&&(mem_ir[15:11]!=`BZ)
							&&(mem_ir[15:11]!=`BNZ)&&(mem_ir[15:11]!=`BN)&&(mem_ir[15:11]!=`BNN)&&(mem_ir[15:11]!=`BC)
							&&(mem_ir[15:11]!=`BNC))
						begin
							if(mem_ir[15:11]==`LOAD)	reg_A <= d_datain;
							else								reg_A <= reg_C;
						end
					else if((id_ir[10:8]==wb_ir[10:8])&&(wb_ir[15:11]!=`NOP)&&(wb_ir[15:11]!=`HALT)
						&&(wb_ir[15:11]!=`CMP)&&(wb_ir[15:11]!=`JUMP)&&(wb_ir[15:11]!=`JMPR)&&(wb_ir[15:11]!=`BZ)
							&&(wb_ir[15:11]!=`BNZ)&&(wb_ir[15:11]!=`BN)&&(wb_ir[15:11]!=`BNN)&&(wb_ir[15:11]!=`BC)
							&&(wb_ir[15:11]!=`BNC))
						begin		reg_A <= reg_C1;		end
					else
						begin		reg_A <= gr[id_ir[10:8]];		end	//r1
				end
			else if((id_ir[15:11]==`LOAD)||(id_ir[15:11]==`STORE)||(id_ir[15:11]==`ADD)||(id_ir[15:11]==`ADDC)
				||(id_ir[15:11]==`SUB)||(id_ir[15:11]==`SUBC)||(id_ir[15:11]==`CMP)||(id_ir[15:11]==`AND)||(id_ir[15:11]==`OR)
				||(id_ir[15:11]==`XOR)||(id_ir[15:11]==`SLL)||(id_ir[15:11]==`SRL)||(id_ir[15:11]==`SLA)||(id_ir[15:11]==`SRA))
				begin
					if((id_ir[6:4]==ex_ir[10:8])&&(ex_ir[15:11]!=`NOP)&&(ex_ir[15:11]!=`HALT)&&(ex_ir[15:11]!=`LOAD)
						&&(ex_ir[15:11]!=`CMP)&&(ex_ir[15:11]!=`JUMP)&&(ex_ir[15:11]!=`JMPR)&&(ex_ir[15:11]!=`BZ)
							&&(ex_ir[15:11]!=`BNZ)&&(ex_ir[15:11]!=`BN)&&(ex_ir[15:11]!=`BNN)&&(ex_ir[15:11]!=`BC)
							&&(ex_ir[15:11]!=`BNC))
						begin		reg_A <= ALU0;		end
					else if((id_ir[6:4]==mem_ir[10:8])&&(mem_ir[15:11]!=`NOP)&&(mem_ir[15:11]!=`HALT)
						&&(mem_ir[15:11]!=`CMP)&&(mem_ir[15:11]!=`JUMP)&&(mem_ir[15:11]!=`JMPR)&&(mem_ir[15:11]!=`BZ)
							&&(mem_ir[15:11]!=`BNZ)&&(mem_ir[15:11]!=`BN)&&(mem_ir[15:11]!=`BNN)&&(mem_ir[15:11]!=`BC)
							&&(mem_ir[15:11]!=`BNC))
						begin
							if(mem_ir[15:11]==`LOAD)	reg_A <= d_datain;
							else								reg_A <= reg_C;
						end
					else if((id_ir[6:4]==wb_ir[10:8])&&((wb_ir[15:11]!=`NOP)&&(wb_ir[15:11]!=`HALT)
						&&(wb_ir[15:11]!=`CMP)&&(wb_ir[15:11]!=`JUMP)&&(wb_ir[15:11]!=`JMPR)&&(wb_ir[15:11]!=`BZ)
							&&(wb_ir[15:11]!=`BNZ)&&(wb_ir[15:11]!=`BN)&&(wb_ir[15:11]!=`BNN)&&(wb_ir[15:11]!=`BC)
							&&(wb_ir[15:11]!=`BNC)))
						begin		reg_A <= reg_C1;		end
					else
						begin		reg_A <= gr[id_ir[6:4]];		end	//r2
				end
			/*********************Hazard for reg_B*********************/
/****************************************************************************/
			if(id_ir[15:11]==`LDIH)
				begin		reg_B <= {id_ir[7:0], 8'b0000_0000};	end
			else if((id_ir[15:11]==`ADDI)||(id_ir[15:11]==`SUBI))
				begin		reg_B <= {8'b0000_0000, id_ir[7:0]};	end
			else if((id_ir[15:11]==`STORE)||(id_ir[15:11]==`LOAD)||(id_ir[15:11]==`SLL)||(id_ir[15:11]==`SRL)
				||(id_ir[15:11]==`SLA)||(id_ir[15:11]==`SRA))
				begin		reg_B <= {12'b0000_0000_0000, id_ir[3:0]};	end
			else if((id_ir[15:11]==`ADD)||(id_ir[15:11]==`ADDC)||(id_ir[15:11]==`SUB)||(id_ir[15:11]==`SUBC)
				||(id_ir[15:11]==`CMP)||(id_ir[15:11]==`AND)||(id_ir[15:11]==`OR)||(id_ir[15:11]==`XOR))
				begin
					if((id_ir[2:0]==ex_ir[10:8])&&((ex_ir[15:11]!=`NOP)&&(ex_ir[15:11]!=`HALT)&&(ex_ir[15:11]!=`LOAD)
						&&(ex_ir[15:11]!=`CMP)&&(ex_ir[15:11]!=`JUMP)&&(ex_ir[15:11]!=`JMPR)&&(ex_ir[15:11]!=`BZ)
							&&(ex_ir[15:11]!=`BNZ)&&(ex_ir[15:11]!=`BN)&&(ex_ir[15:11]!=`BNN)&&(ex_ir[15:11]!=`BC)
							&&(ex_ir[15:11]!=`BNC)))
						begin		reg_B <= ALU0;		end
					else if((id_ir[2:0]==mem_ir[10:8])&&((mem_ir[15:11]!=`NOP)&&(mem_ir[15:11]!=`HALT)
						&&(mem_ir[15:11]!=`CMP)&&(mem_ir[15:11]!=`JUMP)&&(mem_ir[15:11]!=`JMPR)&&(mem_ir[15:11]!=`BZ)
							&&(mem_ir[15:11]!=`BNZ)&&(mem_ir[15:11]!=`BN)&&(mem_ir[15:11]!=`BNN)&&(mem_ir[15:11]!=`BC)
							&&(mem_ir[15:11]!=`BNC)))
						begin
							if(mem_ir[15:11]==`LOAD)	reg_B <= d_datain;
							else								reg_B <= reg_C;
						end
					else if((id_ir[2:0]==wb_ir[10:8])&&((wb_ir[15:11]!=`NOP)&&(wb_ir[15:11]!=`HALT)
						&&(wb_ir[15:11]!=`CMP)&&(wb_ir[15:11]!=`JUMP)&&(wb_ir[15:11]!=`JMPR)&&(wb_ir[15:11]!=`BZ)
							&&(wb_ir[15:11]!=`BNZ)&&(wb_ir[15:11]!=`BN)&&(wb_ir[15:11]!=`BNN)&&(wb_ir[15:11]!=`BC)
							&&(wb_ir[15:11]!=`BNC)))
						begin		reg_B <= reg_C1;		end
					else
						begin		reg_B <= gr[id_ir[2:0]];		end	//r3
				end
				/*********************Get smdr*********************/
/****************************************************************************/
			if(id_ir[15:11]==`STORE)
				begin
					if((id_ir[10:8]==ex_ir[10:8])&&((ex_ir[15:11]!=`NOP)&&(ex_ir[15:11]!=`HALT)&&(ex_ir[15:11]!=`LOAD)
						&&(ex_ir[15:11]!=`CMP)&&(ex_ir[15:11]!=`JUMP)&&(ex_ir[15:11]!=`JMPR)&&(ex_ir[15:11]!=`BZ)
							&&(ex_ir[15:11]!=`BNZ)&&(ex_ir[15:11]!=`BN)&&(ex_ir[15:11]!=`BNN)&&(ex_ir[15:11]!=`BC)
							&&(ex_ir[15:11]!=`BNC)))
						begin		smdr <= ALU0;		end
					else if((id_ir[10:8]==mem_ir[10:8])&&((mem_ir[15:11]!=`NOP)&&(mem_ir[15:11]!=`HALT)
						&&(mem_ir[15:11]!=`CMP)&&(mem_ir[15:11]!=`JUMP)&&(mem_ir[15:11]!=`JMPR)&&(mem_ir[15:11]!=`BZ)
							&&(mem_ir[15:11]!=`BNZ)&&(mem_ir[15:11]!=`BN)&&(mem_ir[15:11]!=`BNN)&&(mem_ir[15:11]!=`BC)
							&&(mem_ir[15:11]!=`BNC)))
						begin
							if(mem_ir[15:11]==`LOAD)	smdr <= d_datain;
							else								smdr <= reg_C;
						end
					else if((id_ir[10:8]==wb_ir[10:8])&&((wb_ir[15:11]!=`NOP)&&(wb_ir[15:11]!=`HALT)
						&&(wb_ir[15:11]!=`CMP)&&(wb_ir[15:11]!=`JUMP)&&(wb_ir[15:11]!=`JMPR)&&(wb_ir[15:11]!=`BZ)
							&&(wb_ir[15:11]!=`BNZ)&&(wb_ir[15:11]!=`BN)&&(wb_ir[15:11]!=`BNN)&&(wb_ir[15:11]!=`BC)
							&&(wb_ir[15:11]!=`BNC)))
						begin		smdr <= reg_C1;		end
					else
						begin		smdr <= gr[id_ir[10:8]];		end
				end
			/*if((id_ir[15:11]==`LDIH)||(id_ir[15:11]==`ADD)||(id_ir[15:11]==`ADDI)||(id_ir[15:11]==`ADDC)
				||(id_ir[15:11]==`SUB)||(id_ir[15:11]==`SUBI)||(id_ir[15:11]==`SUBC)||(id_ir[15:11]==`CMP)
				||(id_ir[15:11]==`AND)||(id_ir[15:11]==`OR)||(id_ir[15:11]==`XOR)||(id_ir[15:11]==`SLL)
				||(id_ir[15:11]==`SRL)||(id_ir[15:11]==`SLA)||(id_ir[15:11]==`SRA))
				begin		PcFlag <= 1'b1;	end*/
		end
end
/*******************************************************************************/
/*******************************************************************************/
//CPU_EX 
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		begin
			in <= 1'b0;
			PcFlag <= 1'b0;
			mem_ir <= 16'b0;
			reg_C <= 16'b0;
			smdr1 <= 16'b0;
			d_we <= 1'b0;
			d_dataout <= 16'b0;
			d_addr <= 8'b0;
		end
	else if(state == `exec)
		begin
			in <= cf;
			mem_ir <= ex_ir;
			reg_C <= ALU0;
			d_addr <= ALU0[7:0];
			if((ex_ir[15:11]==`LDIH)||(ex_ir[15:11]==`ADD)||(ex_ir[15:11]==`ADDI)||(ex_ir[15:11]==`ADDC)
				||(ex_ir[15:11]==`SUB)||(ex_ir[15:11]==`SUBI)||(ex_ir[15:11]==`SUBC)||(ex_ir[15:11]==`CMP)
				||(ex_ir[15:11]==`AND)||(ex_ir[15:11]==`OR)||(ex_ir[15:11]==`XOR)||(ex_ir[15:11]==`SLL)
				||(ex_ir[15:11]==`SRL)||(ex_ir[15:11]==`SLA)||(ex_ir[15:11]==`SRA))
				begin		PcFlag <= 1'b1;	end
			if(ex_ir[15:11] == `STORE)
				begin
					d_we <= 1'b1;
					d_dataout <= smdr;
				end
			else		begin	d_we <= 1'b0;	end
		end
		
end
assign zf = ((ALU0==16'b0)?1'b1:1'b0)&PcFlag;
assign nf = ALU0[15]&PcFlag;
/*******************************************************************************/
/*******************************************************************************/
//CPU_ALU 
always @ (reg_A or reg_B or ex_ir[15:11])
begin
	if(reset)	{cf, ALU0} <= 17'b0;
	else
	case(ex_ir[15:11])
		`LOAD:	ALU0 <= reg_A + reg_B;
		`STORE:	ALU0 <= reg_A + reg_B;
		`LDIH:	{cf, ALU0} <= reg_A + reg_B;
		`ADD:		{cf, ALU0} <= reg_A + reg_B;
		`ADDI:	{cf, ALU0} <= reg_A + reg_B;
		`ADDC:	{cf, ALU0} <= reg_A + reg_B + in;
		`SUB:		{cf, ALU0} <= reg_A - reg_B;
		`SUBI:	{cf, ALU0} <= reg_A - reg_B;
		`SUBC:	{cf, ALU0} <= reg_A - reg_B - in;
		`CMP:		{cf, ALU0} <= reg_A - reg_B;
		`AND:		ALU0 <= (reg_A & reg_B);
		`OR:		ALU0 <= (reg_A | reg_B);
		`XOR:		ALU0 <= (reg_A ^ reg_B);
		`SLL:		ALU0 <= (reg_A << reg_B[3:0]);
		`SRL:		ALU0 <= (reg_A >> reg_B[3:0]);
		`SLA:		ALU0 <= (reg_A <<< reg_B[3:0]);
		`SRA:		ALU0 <= (reg_A >>> reg_B[3:0]);
		default:	begin cf <= cf; ALU0 <= ALU0;	end
	endcase
end
/*******************************************************************************/
/*******************************************************************************/
/*******************************************************************************/
/*******************************************************************************/
//CPU_MEM
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		begin
			wb_ir <= 16'b0;
			reg_C1 <= 16'b0;
		end
	else if(state == `exec)
		begin
			wb_ir <= mem_ir;
			if(mem_ir[15:11]==`LOAD)	reg_C1 <= d_datain;
			else								reg_C1 <= reg_C;
		end
end
/*******************************************************************************/
/*******************************************************************************/
//CPU_WB
always @ (posedge mclk or posedge reset)
begin
	if(reset)
		begin
			gr[0] <= 16'b0;
			gr[1] <= 16'b0;
			gr[2] <= 16'b0;
			gr[3] <= 16'b0;
			gr[4] <= 16'b0;
			gr[5] <= 16'b0;
			gr[6] <= 16'b0;
			gr[7] <= 16'b0;
		end
	else if(state == `exec)
		begin
			if((wb_ir[15:11]==`LOAD)||(wb_ir[15:11]==`LDIH)||(wb_ir[15:11]==`ADD)||(wb_ir[15:11]==`ADDI)
				||(wb_ir[15:11]==`ADDC)||(wb_ir[15:11]==`SUB)||(wb_ir[15:11]==`SUBI)||(wb_ir[15:11]==`SUBC)
				||(wb_ir[15:11]==`AND)||(wb_ir[15:11]==`OR)||(wb_ir[15:11]==`XOR)||(wb_ir[15:11]==`SLL)
				||(wb_ir[15:11]==`SRL)||(wb_ir[15:11]==`SLA)||(wb_ir[15:11]==`SRA))
				begin		gr[wb_ir[10:8]] <= reg_C1;		end
		end
end
/*******************************************************************************/
/*******************************************************************************/
wire [15:0] treg_A, treg_B, treg_C, treg_C1, tALU0;
wire [15:0] tid_ir, tex_ir, tmem_ir, twb_ir, tsmdr;
wire [15:0] tpc, td_addr, td_dataout, flag;
assign treg_A = reg_A;
assign treg_B = reg_B;
assign treg_C = reg_C;
assign treg_C1 = reg_C1;
assign tALU0 = ALU0;
assign tid_ir = id_ir;
assign tex_ir = ex_ir;
assign tmem_ir = mem_ir;
assign twb_ir = wb_ir;
assign tsmdr = smdr;
assign td_dataout = d_dataout;
assign tpc = {4'b0000, pc, 4'b0000};
assign td_addr = {4'b0000, d_addr, 4'b0000};
assign flag = {3'b000, d_we, 3'b000, zf, 3'b000, nf, 3'b000, cf};
/*******************************************************************************/
VGA show(
	.clk(clk),	.red(red),	.green(green),	.blue(blue),	.reset(reset),	.hs(hs),	.vs(vs),
	.reg_A(treg_A),	.reg_B(treg_B),	.reg_C(treg_C),	.reg_C1(treg_C1),	.ALU0(tALU0),
	.id_ir(tid_ir),	.ex_ir(tex_ir),	.mem_ir(tmem_ir),	.wb_ir(twb_ir),	.smdr(tsmdr),
	.pc(tpc),	.d_addr(td_addr),	.d_dataout(td_dataout),	.flag(flag)
	);
/********************************************************************************/

	
endmodule

