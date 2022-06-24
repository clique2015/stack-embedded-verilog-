`timescale 1ns / 1ps

module data_path(a_in, top, pointerA, pointerB, great, pushA, pushB, popA, popB, clk, rst, A, B, C, E, d_select, data_in);
	output	[15:0]	a_in, top;
	output	[4:0]		pointerA, pointerB;
	output				great;
	input					pushA, pushB, popA, popB, clk, rst, A, B, C, E;
	input		[1:0]		d_select;
	input		[15:0]	data_in;
	
	wire		[15:0]	in_top, alu_top;
	reg		[15:0]	stackb_reg, storeb_reg;
	
	stack stackA(in_top,pointerA,a_in,popA,pushA,clk,rst);
	stack stackB(alu_top,pointerB,a_in,popB,pushB,clk,rst);

	ALU ALU1(top,in_top,alu_top,A,B,C,clk,rst);

	mux4_2 d_mux(a_in,data_in,top,stackb_reg,storeb_reg,d_select);

	great = (stackb_reg < storeb_reg)?1:0;
	always @(posedge clk)
		if(rst ==1) begin
		stackb_reg = 0;
		storeb_reg = 0;
		end
		else if(C == 1) begin
		stackb_reg = alu_top;
		end
		else if(E == 1) begin
		storeb_reg = alu_top;
		end		
end
endmodule 