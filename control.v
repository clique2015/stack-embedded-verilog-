`timescale 1ns / 1ps

module control(inpos, PosA, posB, great, clk, rst, A_in, Done, PopA, PopB, PushA, PushB, AluA, AluB, D, AluSel, Dselect);

	
	input 	[4:0]	   inpos, PosA, posB;
	input 	         great, clk, rst;
	input 	[15:0]	A_in;
	output        		Done, PopA, PopB, PushA, PushB, AluA, AluB, D, AluSel;
	output   [1:0]	   Dselect;	
	reg		[4:0]		counter, AluA;	
	reg               DoneReg, Push0, Push1, Push2, Push3, resetDselect, startReg, PopB0, PopB1, PopA0, PushA0, PushB0, PopB, PopA0;
	wire              resetCounter, setcounterone, multione, setPopA, setPush0, setPush2, abSel, PushAsig, PushBsig, setPopB,
							setPush3, setDone, setDselect,select,Push,DoneSignal,PushOut,PopAand, AluBsig;
	 
	
	multione      = PopA | PopB | Push2 | Push3;
	setcounterone = setPopA | setPush0;
	DoneSignal    = resetCounter | DoneReg;
	Done          = DoneReg;
	setDone 		  =((inpos == 0)&(PosA == 1)&(posB == 0));
	setDselect    = Push2 | Push3;
	select        = counter -1;
	Push    		  = Push0 | Push1 | Push2 | Push3 ; 
	setPush0      = great & (~PopB0) & PopB1 ; 
	setPush2		  = ~PopA & PopA0;
	setPush3		  = (PosB == 1) & PushOut;
	PushOut		  = (~PushAsig) & (~PushBsig) & (~PushA0) & (PushB0);
	abSel			  = (A_in[15] ==1)?1:0;
	PushAsig		  = Push & (~abSel);
	PushBsig		  = Push & abSel;
	PushA		     = PushAsig;
	PushB			  = PushBsig;
	setPopB		  = PushOut & (posB > 1);
	setPopA		  = (~PopB0) & (~great) & PopB1;
	PopAand		  = PopA0 & PopA;
	AluB 			  = AluBsig;
	AluSel		  = ~PopB & PopB0;
	D				  = PopB & (counter == 2);
	
		always @ (PopA, counter, DoneSignal) begin
      if(counter ==2) begin
		if(PopA) begin
		AluB = 1;
		end;
		end else if(DoneSignal) begin
		AluB = 0;
		end;
		end;
		end;
	
	
	always @ (setDselect,resetDselect, counter) begin
      if(resetDselect) begin
		Dselect = 0;
		end;
		else if (setDselect) begin
		   if(Push2) begin
			case (select[0])
			1'b0:	Dselect = 2'b01;
			1'b1:	Dselect = 2'b11;
		endcase
			end else
			case (select[0])
			1'b0:	Dselect = 2'b00;
			1'b1:	Dselect = 2'b00;
		endcase
			end;
		
		end else 
				case (select[1:0])
			2'b00:	Dselect = 2'b10;
			2'b01:	Dselect = 2'b11;
			2'b10:	Dselect = 2'b00;
			2'b11:	Dselect = 2'b00;
		endcase
		end 
		end
	always @ (multione, counter) begin
		if(multione == 1) begin
		resetcounter = (counter ==2)?1:0;
		else 
		resetcounter = (counter ==4)?1:0;
		end;
	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			counter = 5'b0;
         DoneReg = 1'b0;
			resetDselect = 1'b0;
			startReg = 1'b1;
		end else if (posedge clk) 
		begin
		PushA0 = PushAsig;
		PushB0 = PushBsig;
		PopB0  = PopB;
		PopB1  = PopB0;
		AluA	 = AluBsig;
		
		if(resetcounter == 1) begin
		counter = 0;
		end else if(setcounterone ==1)
		begin
		counter = 1;
		end else 
		counter = counter + 1;
		end;
		
	   if(startReg == 1) begin
		DoneReg = 1;
		end;
	
	   if(Push == 1) begin
		startReg = 0;
		end;
		
	   if(setDone == 1) begin
		resetDselect = 1;
		end else if(PopB == 1) begin
		resetDselect = 0;		
		end;
		
		if(setPush0 == 1) begin
		Push0 = 1;
		end else if(DoneSignal == 1) begin
		Push0 = 0;		
		end;	
		
		if(startReg == 1) begin
		Push1 = 1;
		end else if(DoneSignal == 1) begin
		Push1 = 0;		
		end;	
		
		if(setPush2 == 1) begin
		Push2 = 1;
		end else if(DoneSignal == 1) begin
		Push2 = 0;		
		end;	
		
		if(setPush3 == 1) begin
		Push3 = 1;
		end else if(DoneSignal == 1) begin
		Push3 = 0;		
		end;	
		
		if(setPopB == 1) begin
		PopB = 1;
		end else if(DoneSignal == 1) begin
		PopB = 0;		
		end;			
		
		if(setPopA == 1) begin
		PopA = 1;
		end else if(PopAand == 1) begin
		PopA = 0;		
		end;			
			
		

	end
endmodule 