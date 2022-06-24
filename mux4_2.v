`timescale 1ns / 1ps

module mux4_2(out_data,input_data,alu_data,bstack_data,bstored_data,in_sel);
	output	[15:0]	out_data;
	input		[15:0]	input_data,alu_data,bstack_data,bstored_data;
	input		[1:0]		in_sel;
	reg		[15:0]	out_data;
	
	always @ (A or B or C or D or select) begin
		case (select)
			2'b11:	out_data = input_data;
			2'b10:	out_data = alu_data;
			2'b01:	out_data = bstack_data;
			2'b00:	out_data = bstored_data;
		endcase
	end
endmodule
