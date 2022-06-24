`timescale 1ns / 1ps

module stack(top,pointer,data_in,pop,push,clk,rst);
	output	[15:0]	top;
	output	[4:0]		pointer;
	input		[15:0]	data_in;
	input					pop,push,clk,rst;
	reg		[15:0]	stack_ram[31:0];
	reg		[4:0]		pointer_reg;
	wire              we;

	
    we = (push ==1)?1:0;
	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			pointer_reg = 5'b0;
		end else if (clk == 1) begin
		
			if (pop == 1) begin
				pointer_reg = pointer_reg - 1;
				top = stack_ram[pointer_reg - 1];				
			end else if (push == 1) begin
				pointer_reg = pointer_reg + 1;
				if(we ==1)begin
				stack_ram[pointer_reg] = data_in;
			end	
			end
	end
endmodule 