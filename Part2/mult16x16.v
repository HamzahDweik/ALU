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

  
  Augend0={     1'b0,A[0]&B[15],A[0]&B[14],A[0]&B[13],A[0]&B[12],A[0]&B[11],A[0]&B[10],A[0]&B[9],A[0]&B[8],A[0]&B[7],A[0]&B[6],A[0]&B[5],A[0]&B[4],A[0]&B[3],A[0]&B[2],A[0]&B[1]}; //A[0] by B
  Adend0={A[1]&B[15],A[1]&B[14],A[1]&B[13],A[1]&B[12],A[1]&B[11],A[1]&B[10],A[1]&B[9],A[1]&B[8],A[1]&B[7],A[1]&B[6],A[1]&B[5],A[1]&B[4],A[1]&B[3],A[1]&B[2],A[1]&B[1],A[1]&B[0]}; //A[1] by B

  Augend1={Carry0[15],Sum0[15],Sum0[14],Sum0[13],Sum0[12],Sum0[11],Sum0[10],Sum0[9],Sum0[8],Sum0[7],Sum0[6],Sum0[5],Sum0[4],Sum0[3],Sum0[2],Sum0[1]};
  Adend1={A[2]&B[15],A[2]&B[14],A[2]&B[13],A[2]&B[12],A[2]&B[11],A[2]&B[10],A[2]&B[9],A[2]&B[8],A[2]&B[7],A[2]&B[6],A[2]&B[5],A[2]&B[4],A[2]&B[3],A[2]&B[2],A[2]&B[1],A[2]&B[0]}; //A[2] by B

  Augend2={Carry1[15],Sum1[15],Sum1[14],Sum1[13],Sum1[12],Sum1[11],Sum1[10],Sum1[9],Sum1[8],Sum1[7],Sum1[6],Sum1[5],Sum1[4],Sum1[3],Sum1[2],Sum1[1]};
  Adend2={A[3]&B[15],A[3]&B[14],A[3]&B[13],A[3]&B[12],A[3]&B[11],A[3]&B[10],A[3]&B[9],A[3]&B[8],A[3]&B[7],A[3]&B[6],A[3]&B[5],A[3]&B[4],A[3]&B[3],A[3]&B[2],A[3]&B[1],A[3]&B[0]}; //A[3] by B

  Augend3={Carry2[15],Sum2[15],Sum2[14],Sum2[13],Sum2[12],Sum2[11],Sum2[10],Sum2[9],Sum2[8],Sum2[7],Sum2[6],Sum2[5],Sum2[4],Sum2[3],Sum2[2],Sum2[1]}; //A[0] by B
  Adend3={A[4]&B[15],A[4]&B[14],A[4]&B[13],A[4]&B[12],A[4]&B[11],A[4]&B[10],A[4]&B[9],A[4]&B[8],A[4]&B[7],A[4]&B[6],A[4]&B[5],A[4]&B[4],A[4]&B[3],A[4]&B[2],A[4]&B[1],A[4]&B[0]}; //A[1] by B

  Augend4={Carry3[15],Sum3[15],Sum3[14],Sum3[13],Sum3[12],Sum3[11],Sum3[10],Sum3[9],Sum3[8],Sum3[7],Sum3[6],Sum3[5],Sum3[4],Sum3[3],Sum3[2],Sum3[1]};
  Adend4={A[5]&B[15],A[5]&B[14],A[5]&B[13],A[5]&B[12],A[5]&B[11],A[5]&B[10],A[5]&B[9],A[5]&B[8],A[5]&B[7],A[5]&B[6],A[5]&B[5],A[5]&B[4],A[5]&B[3],A[5]&B[2],A[5]&B[1],A[5]&B[0]}; //A[2] by B

  Augend5={Carry4[15],Sum4[15],Sum4[14],Sum4[13],Sum4[12],Sum4[11],Sum4[10],Sum4[9],Sum4[8],Sum4[7],Sum4[6],Sum4[5],Sum4[4],Sum4[3],Sum4[2],Sum4[1]};
  Adend5={A[6]&B[15],A[6]&B[14],A[6]&B[13],A[6]&B[12],A[6]&B[11],A[6]&B[10],A[6]&B[9],A[6]&B[8],A[6]&B[7],A[6]&B[6],A[6]&B[5],A[6]&B[4],A[6]&B[3],A[6]&B[2],A[6]&B[1],A[6]&B[0]}; //A[3] by B
  
  Augend6={Carry5[15],Sum5[15],Sum5[14],Sum5[13],Sum5[12],Sum5[11],Sum5[10],Sum5[9],Sum5[8],Sum5[7],Sum5[6],Sum5[5],Sum5[4],Sum5[3],Sum5[2],Sum5[1]}; //A[0] by B
  Adend6={A[7]&B[15],A[7]&B[14],A[7]&B[13],A[7]&B[12],A[7]&B[11],A[7]&B[10],A[7]&B[9],A[7]&B[8],A[7]&B[7],A[7]&B[6],A[7]&B[5],A[7]&B[4],A[7]&B[3],A[7]&B[2],A[7]&B[1],A[7]&B[0]}; //A[1] by B

  Augend7={Carry6[15],Sum6[15],Sum6[14],Sum6[13],Sum6[12],Sum6[11],Sum6[10],Sum6[9],Sum6[8],Sum6[7],Sum6[6],Sum6[5],Sum6[4],Sum6[3],Sum6[2],Sum6[1]};
  Adend7={A[8]&B[15],A[8]&B[14],A[8]&B[13],A[8]&B[12],A[8]&B[11],A[8]&B[10],A[8]&B[9],A[8]&B[8],A[8]&B[7],A[8]&B[6],A[8]&B[5],A[8]&B[4],A[8]&B[3],A[8]&B[2],A[8]&B[1],A[8]&B[0]}; //A[2] by B

  Augend8={Carry7[15],Sum7[15],Sum7[14],Sum7[13],Sum7[12],Sum7[11],Sum7[10],Sum7[9],Sum7[8],Sum7[7],Sum7[6],Sum7[5],Sum7[4],Sum7[3],Sum7[2],Sum7[1]};
  Adend8={A[9]&B[15],A[9]&B[14],A[9]&B[13],A[9]&B[12],A[9]&B[11],A[9]&B[10],A[9]&B[9],A[9]&B[8],A[9]&B[7],A[9]&B[6],A[9]&B[5],A[9]&B[4],A[9]&B[3],A[9]&B[2],A[9]&B[1],A[9]&B[0]}; //A[3] by B

  Augend9={Carry8[15],Sum8[15],Sum8[14],Sum8[13],Sum8[12],Sum8[11],Sum8[10],Sum8[9],Sum8[8],Sum8[7],Sum8[6],Sum8[5],Sum8[4],Sum8[3],Sum8[2],Sum8[1]}; //A[0] by B
  Adend9={A[10]&B[15],A[10]&B[14],A[10]&B[13],A[10]&B[12],A[10]&B[11],A[10]&B[10],A[10]&B[9],A[10]&B[8],A[10]&B[7],A[10]&B[6],A[10]&B[5],A[10]&B[4],A[10]&B[3],A[10]&B[2],A[10]&B[1],A[10]&B[0]}; //A[1] by B

  Augend10={Carry9[15],Sum9[15],Sum9[14],Sum9[13],Sum9[12],Sum9[11],Sum9[10],Sum9[9],Sum9[8],Sum9[7],Sum9[6],Sum9[5],Sum9[4],Sum9[3],Sum9[2],Sum9[1]};
  Adend10={A[11]&B[15],A[11]&B[14],A[11]&B[13],A[11]&B[12],A[11]&B[11],A[11]&B[10],A[11]&B[9],A[11]&B[8],A[11]&B[7],A[11]&B[6],A[11]&B[5],A[11]&B[4],A[11]&B[3],A[11]&B[2],A[11]&B[1],A[11]&B[0]}; //A[2] by B

  Augend11={Carry10[15],Sum10[15],Sum10[14],Sum10[13],Sum10[12],Sum10[11],Sum10[10],Sum10[9],Sum10[8],Sum10[7],Sum10[6],Sum10[5],Sum10[4],Sum10[3],Sum10[2],Sum10[1]};
  Adend11={A[12]&B[15],A[12]&B[14],A[12]&B[13],A[12]&B[12],A[12]&B[11],A[12]&B[10],A[12]&B[9],A[12]&B[8],A[12]&B[7],A[12]&B[6],A[12]&B[5],A[12]&B[4],A[12]&B[3],A[12]&B[2],A[12]&B[1],A[12]&B[0]}; //A[3] by B

  Augend12={Carry11[15],Sum11[15],Sum11[14],Sum11[13],Sum11[12],Sum11[11],Sum11[10],Sum11[9],Sum11[8],Sum11[7],Sum11[6],Sum11[5],Sum11[4],Sum11[3],Sum11[2],Sum11[1]}; //A[0] by B
  Adend12={A[13]&B[15],A[13]&B[14],A[13]&B[13],A[13]&B[12],A[13]&B[11],A[13]&B[10],A[13]&B[9],A[13]&B[8],A[13]&B[7],A[13]&B[6],A[13]&B[5],A[13]&B[4],A[13]&B[3],A[13]&B[2],A[13]&B[1],A[13]&B[0]}; //A[1] by B

  Augend13={Carry12[15],Sum12[15],Sum12[14],Sum12[13],Sum12[12],Sum12[11],Sum12[10],Sum12[9],Sum12[8],Sum12[7],Sum12[6],Sum12[5],Sum12[4],Sum12[3],Sum12[2],Sum12[1]};
  Adend13={A[14]&B[15],A[14]&B[14],A[14]&B[13],A[14]&B[12],A[14]&B[11],A[14]&B[10],A[14]&B[9],A[14]&B[8],A[14]&B[7],A[14]&B[6],A[14]&B[5],A[14]&B[4],A[14]&B[3],A[14]&B[2],A[14]&B[1],A[14]&B[0]}; //A[2] by B

  Augend14={Carry13[15],Sum13[15],Sum13[14],Sum13[13],Sum13[12],Sum13[11],Sum13[10],Sum13[9],Sum13[8],Sum13[7],Sum13[6],Sum13[5],Sum13[4],Sum13[3],Sum13[2],Sum13[1]}; //A[0] by B
  Adend14={A[15]&B[15],A[15]&B[14],A[15]&B[13],A[15]&B[12],A[15]&B[11],A[15]&B[10],A[15]&B[9],A[15]&B[8],A[15]&B[7],A[15]&B[6],A[15]&B[5],A[15]&B[4],A[15]&B[3],A[15]&B[2],A[15]&B[1],A[15]&B[0]}; //A[1] by B

  
   
  C[0]=  A[0]&B[0];//From Gates
//=================================  
  C[1]=  Sum0[0];//From Adder0
 //=================================
  C[2]=  Sum1[0];//From Adder1
 //=================================
  C[3] = Sum2[0];//From Adder2
  C[4] = Sum3[0];//From Adder2
  C[5] = Sum4[0];//From Adder2
  C[6] = Sum5[0];//From Adder2
  C[7] = Sum6[0];//From Adder2
  C[8] = Sum7[0];//From Adder2
  C[9] = Sum8[0];//From Adder2
  C[10] = Sum9[0];//From Adder2
  C[11] = Sum10[0];//From Adder2
  C[12] = Sum11[0];//From Adder2
  C[13] = Sum12[0];//From Adder2
  C[14] = Sum13[0];//From Adder2
  C[15] = Sum14[0];//From Adder2
  C[16] = Sum15[0];//From Adder2
  C[17] = Sum2[2];//From Adder2
  C[18] = Sum2[3];//From Adder2
  C[19] = Carry2[3];//From Adder2
  C[20] = Sum2[1];//From Adder2
  C[21] = Sum2[2];//From Adder2
  C[22] = Sum2[3];//From Adder2
  C[23] = Carry2[3];//From Adder2
  C[24] = Sum2[1];//From Adder2
  C[25] = Sum2[2];//From Adder2
  C[26] = Sum2[3];//From Adder2
  C[27] = Carry2[3];//From Adder2
  C[28] = Sum2[1];//From Adder2
  C[29] = Sum2[2];//From Adder2
  C[30] = Sum2[3];//From Adder2
  C[31] = Carry2[3];//From Adder2

  
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
