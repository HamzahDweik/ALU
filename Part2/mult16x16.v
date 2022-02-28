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

//completed
module SixteenBitFullAdder(A,B,C,Carry,Sum);
input [15:0] A;
input [15:0] B;
input C;
output [15:0] Carry;
output [15:0] Sum;
FullAdder FA0(A[0],B[0],C       ,Carry[0],Sum[0]);
FullAdder FA1(A[1],B[1],Carry[0],Carry[1],Sum[1]);
FullAdder FA2(A[2],B[2],Carry[1],Carry[2],Sum[2]);
FullAdder FA3(A[3],B[3],Carry[2],Carry[3],Sum[3]);
FullAdder FA4(A[4],B[4],Carry[3],Carry[4],Sum[4]);
FullAdder FA5(A[5],B[5],Carry[4],Carry[5],Sum[5]);
FullAdder FA6(A[6],B[6],Carry[5],Carry[6],Sum[6]);
FullAdder FA7(A[7],B[7],Carry[6],Carry[7],Sum[7]);
FullAdder FA8(A[8],B[8],Carry[7],Carry[8],Sum[8]);
FullAdder FA9(A[9],B[9],Carry[8],Carry[9],Sum[9]);
FullAdder FA10(A[10],B[10],Carry[9],Carry[10],Sum[10]);
FullAdder FA11(A[11],B[11],Carry[10],Carry[11],Sum[11]);
FullAdder FA12(A[12],B[12],Carry[11],Carry[12],Sum[12]);
FullAdder FA13(A[13],B[13],Carry[12],Carry[13],Sum[13]);
FullAdder FA14(A[14],B[14],Carry[13],Carry[14],Sum[14]);
FullAdder FA15(A[15],B[15],Carry[14],Carry[15],Sum[15]);
endmodule;


module SixteenBitMultiplier(A,B,C);
input  [15:0] A;
input  [15:0] B;
output [31:0] C;

reg [31:0] C;

//Local Variables
reg  [15:0] Augend0;
reg  [15:0] Adend0;
wire [15:0] Sum0;
wire [15:0] Carry0;

reg  [15:0] Augend1;
reg  [15:0] Adend1;
wire [15:0] Sum1;
wire [15:0] Carry1;

reg  [15:0] Augend2;
reg  [15:0] Adend2;
wire [15:0] Sum2;
wire [15:0] Carry2;

reg  [15:0] Augend3;
reg  [15:0] Adend3;
wire [15:0] Sum3;
wire [15:0] Carry3;

reg  [15:0] Augend4;
reg  [15:0] Adend4;
wire [15:0] Sum4;
wire [15:0] Carry4;

reg  [15:0] Augend5;
reg  [15:0] Adend5;
wire [15:0] Sum5;
wire [15:0] Carry5;

reg  [15:0] Augend6;
reg  [15:0] Adend6;
wire [15:0] Sum6;
wire [15:0] Carry6;

reg  [15:0] Augend7;
reg  [15:0] Adend7;
wire [15:0] Sum7;
wire [15:0] Carry7;

reg  [15:0] Augend8;
reg  [15:0] Adend8;
wire [15:0] Sum8;
wire [15:0] Carry8;

reg  [15:0] Augend9;
reg  [15:0] Adend9;
wire [15:0] Sum9;
wire [15:0] Carry9;

reg  [15:0] Augend10;
reg  [15:0] Adend10;
wire [15:0] Sum10;
wire [15:0] Carry10;

reg  [15:0] Augend11;
reg  [15:0] Adend11;
wire [15:0] Sum11;
wire [15:0] Carry11;

reg  [15:0] Augend12;
reg  [15:0] Adend12;
wire [15:0] Sum12;
wire [15:0] Carry12;

reg  [15:0] Augend13;
reg  [15:0] Adend13;
wire [15:0] Sum13;
wire [15:0] Carry13;

reg  [15:0] Augend14;
reg  [15:0] Adend14;
wire [15:0] Sum14;
wire [15:0] Carry14;

reg  [15:0] Augend15;
reg  [15:0] Adend15;
wire [15:0] Sum15;
wire [15:0] Carry15;


SixteenBitFullAdder add0(Augend0,Adend0,1'b0,Carry0,Sum0);
SixteenBitFullAdder add1(Augend1,Adend1,1'b0,Carry1,Sum1);
SixteenBitFullAdder add2(Augend2,Adend2,1'b0,Carry2,Sum2);
SixteenBitFullAdder add3(Augend3,Adend3,1'b0,Carry3,Sum3);
SixteenBitFullAdder add4(Augend4,Adend4,1'b0,Carry4,Sum4);
SixteenBitFullAdder add5(Augend5,Adend5,1'b0,Carry5,Sum5);
SixteenBitFullAdder add6(Augend6,Adend6,1'b0,Carry6,Sum6);
SixteenBitFullAdder add7(Augend7,Adend7,1'b0,Carry7,Sum7);
SixteenBitFullAdder add8(Augend8,Adend8,1'b0,Carry8,Sum8);
SixteenBitFullAdder add9(Augend9,Adend9,1'b0,Carry9,Sum9);
SixteenBitFullAdder add10(Augend10,Adend10,1'b0,Carry10,Sum10);
SixteenBitFullAdder add11(Augend11,Adend11,1'b0,Carry11,Sum11);
SixteenBitFullAdder add12(Augend12,Adend12,1'b0,Carry12,Sum12);
SixteenBitFullAdder add13(Augend13,Adend13,1'b0,Carry13,Sum13);
SixteenBitFullAdder add14(Augend14,Adend14,1'b0,Carry14,Sum14);
SixteenBitFullAdder add15(Augend15,Adend15,1'b0,Carry15,Sum15);

always@(*)
begin

  
  Augend0={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend0={A[1]&B[15],A[1]&B[14],A[1]&B[13],A[1]&B[12], A[1]&B[11],A[1]&B[10],A[1]&B[9],A[1]&B[8], A[1]&B[7],A[1]&B[6],A[1]&B[5],A[1]&B[4],A[1]&B[3],A[1]&B[2],A[1]&B[1],A[1]&B[0]}; //A[1] by B

  Augend1={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
  Adend1={A[2]&B[15],A[2]&B[14],A[2]&B[13],A[2]&B[12],A[2]&B[11],A[2]&B[10],A[2]&B[9],A[2]&B[8],A[2]&B[7],A[2]&B[6],A[2]&B[5],A[2]&B[4],A[2]&B[3],A[2]&B[2],A[2]&B[1],A[2]&B[0]}; //A[2] by B

  Augend2={Carry1[3],  Sum1[3],  Sum1[2],  Sum1[1]};
  Adend2={A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0],A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0],A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0],A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0]}; //A[3] by B

  Augend3={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend3={A[4]&B[3],A[4]&B[2],A[4]&B[1],A[4]&B[0],A[4]&B[3],A[4]&B[2],A[4]&B[1],A[4]&B[0],A[4]&B[3],A[4]&B[2],A[4]&B[1],A[4]&B[0],A[4]&B[3],A[4]&B[2],A[4]&B[1],A[4]&B[0]}; //A[1] by B

  Augend4={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
  Adend4={A[5]&B[3],A[5]&B[2],A[5]&B[1],A[5]&B[0],A[5]&B[3],A[5]&B[2],A[5]&B[1],A[5]&B[0],A[5]&B[3],A[5]&B[2],A[5]&B[1],A[5]&B[0],A[5]&B[3],A[5]&B[2],A[5]&B[1],A[5]&B[0]}; //A[2] by B

  Augend5={Carry1[3],  Sum1[3],  Sum1[2],  Sum1[1]};
  Adend5={A[6]&B[3],A[6]&B[2],A[6]&B[1],A[6]&B[0],A[6]&B[3],A[6]&B[2],A[6]&B[1],A[6]&B[0],A[6]&B[3],A[6]&B[2],A[6]&B[1],A[6]&B[0],A[6]&B[3],A[6]&B[2],A[6]&B[1],A[6]&B[0]}; //A[3] by B
  
  Augend6={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend6={A[7]&B[3],A[7]&B[2],A[7]&B[1],A[7]&B[0],A[7]&B[3],A[7]&B[2],A[7]&B[1],A[7]&B[0],A[7]&B[3],A[7]&B[2],A[7]&B[1],A[7]&B[0],A[7]&B[3],A[7]&B[2],A[7]&B[1],A[7]&B[0]}; //A[1] by B

  Augend7={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
  Adend7={A[8]&B[3],A[8]&B[2],A[8]&B[1],A[8]&B[0],A[8]&B[3],A[8]&B[2],A[8]&B[1],A[8]&B[0],A[8]&B[3],A[8]&B[2],A[8]&B[1],A[8]&B[0],A[8]&B[3],A[8]&B[2],A[8]&B[1],A[8]&B[0]}; //A[2] by B

  Augend8={Carry1[3],  Sum1[3],  Sum1[2],  Sum1[1]};
  Adend8={A[9]&B[3],A[9]&B[2],A[9]&B[1],A[9]&B[0],A[9]&B[3],A[9]&B[2],A[9]&B[1],A[9]&B[0],A[9]&B[3],A[9]&B[2],A[9]&B[1],A[9]&B[0],A[9]&B[3],A[9]&B[2],A[9]&B[1],A[9]&B[0]}; //A[3] by B

  Augend9={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend9={A[10]&B[3],A[10]&B[2],A[10]&B[1],A[10]&B[0],A[10]&B[3],A[10]&B[2],A[10]&B[1],A[10]&B[0],A[10]&B[3],A[10]&B[2],A[10]&B[1],A[10]&B[0],A[10]&B[3],A[10]&B[2],A[10]&B[1],A[10]&B[0]}; //A[1] by B

  Augend10={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
  Adend10={A[11]&B[3],A[11]&B[2],A[11]&B[1],A[11]&B[0],A[11]&B[3],A[11]&B[2],A[11]&B[1],A[11]&B[0],A[11]&B[3],A[11]&B[2],A[11]&B[1],A[11]&B[0],A[11]&B[3],A[11]&B[2],A[11]&B[1],A[11]&B[0]}; //A[2] by B

  Augend11={Carry1[3],  Sum1[3],  Sum1[2],  Sum1[1]};
  Adend11={A[12]&B[3],A[12]&B[2],A[12]&B[1],A[12]&B[0],A[12]&B[3],A[12]&B[2],A[12]&B[1],A[12]&B[0],A[12]&B[3],A[12]&B[2],A[12]&B[1],A[12]&B[0],A[12]&B[3],A[12]&B[2],A[12]&B[1],A[12]&B[0]}; //A[3] by B

  Augend12={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend12={A[13]&B[3],A[13]&B[2],A[13]&B[1],A[13]&B[0],A[13]&B[3],A[13]&B[2],A[13]&B[1],A[13]&B[0],A[13]&B[3],A[13]&B[2],A[13]&B[1],A[13]&B[0],A[13]&B[3],A[13]&B[2],A[13]&B[1],A[13]&B[0]}; //A[1] by B

  Augend13={Carry0[3],  Sum0[3],  Sum0[2],  Sum0[1]};
  Adend13={A[14]&B[3],A[14]&B[2],A[14]&B[1],A[14]&B[0],A[14]&B[3],A[14]&B[2],A[14]&B[1],A[14]&B[0],A[14]&B[3],A[14]&B[2],A[14]&B[1],A[14]&B[0],A[14]&B[3],A[14]&B[2],A[14]&B[1],A[14]&B[0]}; //A[2] by B

  Augend14={     1'b0,A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend14={A[15]&B[3],A[15]&B[2],A[15]&B[1],A[15]&B[0],A[15]&B[3],A[15]&B[2],A[15]&B[1],A[15]&B[0],A[15]&B[3],A[15]&B[2],A[15]&B[1],A[15]&B[0],A[15]&B[3],A[15]&B[2],A[15]&B[1],A[15]&B[0]}; //A[1] by B

  
   
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
