`timescale 1ns / 1ps

module core(mem_addr,mem_write,mem_data,clk,rst);
	output	[10:0]	Peek;
	output				isEmpty;
	input					jmp, push, clk,rst;
	input		[4:0] 	Addr;
	input		[15:0] 	data;
	wire		[15:0]	A_in, data_in;
	wire		[4:0]		inpos, PosA, posB;
	wire		[1:0]		Dselect;
	wire					great, PopA, popB, PushA, PushB, Pusha, Popp, AluA, AluSel, AluB, D;
	
	
	Pusha = PushA | PushB;
	Popp = Pusha & (Dselect == 0); 
	
	control controll(.inpos(inpos), .PosA(PosA), .posB(posB), .great(great), .clk(clk), .rst(rst), .A_in(A_in),
	.Done(isEmpty), .PopA(PopA), .PopB(popB), .PushA(PushA), .PushB(PushB), .AluA(AluA), .AluB(AluB), .D(D), .AluSel(AluSel), .Dselect(Dselect))
	
data_path data_in(a_in(A_in), .top(Peek), .pointerA(PosA), .pointerB(posB), .great(great), .pushA(PushA), 
.pushB(PushB), .popA(PopA), .popB(popB), .clk(clk), .rst(rst), .A(AluA), .B(AluB), .C(AluSel), .E(D), .d_select(Dselect), .data_in(data_in)); 
	
		
		inn inn(peek(data_in), .stack_pointer(inpos), .jump(Addr), .inn(data), .jmp(jmp), .pop(Popp), .push(push), .clk(clk));
		
		
endmodule 