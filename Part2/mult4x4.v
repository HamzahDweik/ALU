//=============================================
// Half Adder
//=============================================
module HalfAdder(A,B,carry,sum);
	input A;
	input B;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	always @(*) 
	  begin
	    sum= A ^ B;
	    carry= A & B;
	  end
//---------------------------------------------
endmodule
//=============================================
// Full Adder
//=============================================
module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	wire c0;
	wire s0;
	wire c1;
	wire s1;
//---------------------------------------------
	HalfAdder ha1(A ,B,c0,s0);
	HalfAdder ha2(s0,C,c1,s1);
//---------------------------------------------
	always @(*) 
	  begin
	    sum=s1;//
		sum= A^B^C;
	    carry=c1|c0;//
		carry= ((A^B)&C)|(A&B);  
	  end
//---------------------------------------------
	
endmodule

module FourBitFullAdder(A,B,C,Carry,Sum);
input [3:0] A;
input [3:0] B;
input C;
output [3:0] Carry;
output [3:0] Sum;
FullAdder FA0(A[0],B[0],C       ,Carry[0],Sum[0]);
FullAdder FA1(A[1],B[1],Carry[0],Carry[1],Sum[1]);
FullAdder FA2(A[2],B[2],Carry[1],Carry[2],Sum[2]);
FullAdder FA3(A[3],B[3],Carry[2],Carry[3],Sum[3]);
endmodule;


module FourBitMultiplier(A,B,C);
input  [3:0] A;
input  [3:0] B;
output [7:0] C;

reg [7:0] C;

//Local Variables
reg  [3:0] Augend0;
reg  [3:0] Adend0;
wire [3:0] Sum0;
wire [3:0]Carry0;

reg  [3:0] Augend1;
reg  [3:0] Adend1;
wire [3:0] Sum1;
wire [3:0]Carry1;

reg  [3:0] Augend2;
reg  [3:0] Adend2;
wire [3:0] Sum2;
wire [3:0]Carry2;

reg  [3:0] Augend3;
reg  [3:0] Adend3;
wire [3:0] Sum3;
wire [3:0]Carry3;


FourBitFullAdder add0(Augend0,Adend0,1'b0,Carry0,Sum0);
FourBitFullAdder add1(Augend1,Adend1,1'b0,Carry1,Sum1);
FourBitFullAdder add2(Augend2,Adend2,1'b0,Carry2,Sum2);
FourBitFullAdder add3(Augend3,Adend3,1'b0,Carry3,Sum3);

always@(*)
begin

  
  Augend0={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
   Adend0={A[1]&B[3],A[1]&B[2],A[1]&B[1],A[1]&B[0]}; //A[1] by B

  Augend1={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
   Adend1={A[2]&B[3],A[2]&B[2],A[2]&B[1],A[2]&B[0]}; //A[2] by B

  Augend2={Carry1[3],  Sum1[3],  Sum1[2],  Sum1[1]};
   Adend2={A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0]}; //A[3] by B
   

  
   
  C[0]=  A[0]&B[0];//From Gates
//=================================  
  C[1]=  Sum0[0];//From Adder0
 //=================================
  C[2]=  Sum1[0];//From Adder1
 //=================================
  C[3] = Sum2[0];//From Adder2
  C[4] = Sum2[1];//From Adder2
  C[5] = Sum2[2];//From Adder2
  C[6] = Sum2[3];//From Adder2
  C[7] = Carry2[3];//From Adder2
  
end


endmodule


module testbench();

reg  [3:0] A4;
reg  [3:0] B4;
wire [7:0] C4;

reg [15:0] loopi;
reg [15:0] loopj;

reg [15:0] results [7:0] [7:0];
reg indexi;
reg indexj;

FourBitMultiplier mult4(A4,B4,C4);

initial
begin


for (loopi=0;loopi<16;loopi+=1)
begin
for (loopj=0;loopj<16;loopj+=1)
begin
	A4=loopi;
	B4=loopj;
	#10;
	results[loopi][loopj]=C4;
	$write(" %3d",C4);
	end
	$display(";");

	
end

#10;
 
	
end
endmodule
