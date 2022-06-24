`timescale 1ns / 1ps

module ALU(alu_out,a_in,b_in,c_in,clk,rst,input_in,alu_in);
	output	[15:0]	alu_out;
	input          	a_in,b_in,c_in,clk,rst;	
	input		[15:0]	input_in,alu_in;
	reg		[15:0]	a_reg,b_reg,c_reg;
	wire     [3:0]    select;
	wire     [14:0]     alu_sig;	
	
	select = c_reg[3:0]
	always @ (select) begin
		case (select)
			4'b0000:	alu_sig = a_reg;					
			4'b0001:	alu_sig = a_reg | b_reg;
			4'b0010:	alu_sig = a_reg ^ b_reg;
			4'b0011:	alu_sig = a_reg & b_reg;
			4'b0100:	alu_sig = a_reg << b_reg[3:0];
			4'b0101:	alu_sig = a_reg >> b_reg[3:0];
			4'b0110:	alu_sig = a_reg + b_reg;
			4'b0111:	alu_sig = a_reg - b_reg;
			4'b1000:	alu_sig = a_reg * b_reg;
			4'b1001: alu_sig = 0 - a_reg;
			4'b1010:	alu_sig = a_reg / b_reg;
			4'b1011:	alu_sig = ~a_reg;
		endcase
		alu_out = {1'b0,alu_sig};
	end
	always @ (posedge clk or posedge rst) begin

		if (rst == 1) begin
			a_reg = 16'b0;
			b_reg = 16'b0;
			c_reg = 16'b0;
		end else if (posedge clk) begin
		if (a_in == 1) begin
			a_reg = input_in[14:0];
		end else if(b_in == 1)
			b_reg =  input_in[14:0];
       end;
		if (c_in == 1) begin
			c_reg = alu_in;
		end	
end		
endmodule
