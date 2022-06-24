`timescale 1ns / 1ps

module stack(peek, stack_pointer, jump, inn, jmp, pop, push, clk);
	output	[15:0]	peek;
	output	[4:0]		stack_pointer;
	input 	[4:0]		jump;
	input		[15:0]	inn;
	input					jmp,pop,push,clk;
	reg		[15:0]	stack_ram[31:0];
	reg		[4:0]		stack_pointer_reg;
	wire              we;

	
    we = (push ==1)?1:0;
	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			pointer_reg = 5'b0;
		end else if (clk == 1) begin
		
			if (pop == 1) begin
				pointer_reg = pointer_reg - 1;
				peek = stack_ram[pointer_reg];				
			end else if (push == 1) begin
				pointer_reg = pointer_reg + 1;
				if(we ==1)begin
				stack_ram[pointer_reg] = inn;
			end else if (jmp == 1) begin
				pointer_reg = jump;
			end
	end
endmodule 