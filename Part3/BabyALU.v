
//============================================
//D Flip-Flop
//============================================
module DFF(clk,in,out);
	input          clk;
	input   in;
	output  out;
	reg     out;

	always @(posedge clk)
	out = in;
endmodule

//============================================
//HALF-ADDER
//============================================
module Add_half (input a, b,  output c_out, sum);
   xor G1(sum, a, b);	 
   and G2(c_out, a, b);
endmodule

//============================================
//FULL-ADDER
//============================================
module Add_full (input a, b, c_in, output c_out, sum);
   wire w1, w2, w3;	 
   Add_half M1 (a, b, w1, w2);
   Add_half M0 (w2, c_in, w3, sum);
   or (c_out, w1, w3);
endmodule


//============================================
//Decoder (n to M)
//============================================
module Dec(a,b);

parameter n=4;
parameter m=16;
input [n-1:0] a;
output [m-1:0] b;

assign  b= 1<<a; //Shift 1 a places. Makes a 1-hot.

endmodule


//============================================
//MUX Multiplexer 16 by 4
//============================================
module Mux(channels,select,b);
input [15:0][31:0]channels;
input       [15:0] select;
output      [31:0] b;
wire  [15:0][31:0] channels;
reg         [31:0] b;

always @(*)
begin
 b=channels[select]; //This is disgusting....
end

endmodule

//============================================
//ADD operation
//============================================
module ADDER(inputA,inputB,outputC,carry,error);
//---------------------------------------
input [15:0] inputA;
input [15:0] inputB;
wire  [15:0] inputA;
wire  [15:0] inputB;
//---------------------------------------
output [15:0] outputC;
output       carry;
output error;
reg error;
reg    [15:0] outputC;
reg          carry;
//---------------------------------------

wire [15:0] S;
wire [15:0] Cin;
wire [15:0] Cout;

//Link the wires between the Adders
assign Cin[0]=0;
assign Cin[1]=Cout[0];
assign Cin[2]=Cout[1];
assign Cin[3]=Cout[2];
assign Cin[4]=Cout[3];
assign Cin[5]=Cout[4];
assign Cin[6]=Cout[5];
assign Cin[7]=Cout[6];
assign Cin[8]=Cout[7];
assign Cin[9]=Cout[8];
assign Cin[10]=Cout[9];
assign Cin[11]=Cout[10];
assign Cin[12]=Cout[11];
assign Cin[13]=Cout[12];
assign Cin[14]=Cout[13];
assign Cin[15]=Cout[14];


//Declare and Allocate 4 Full adders
Add_full FA [15:0] (inputA,inputB,Cin,Cout,S);

always @(*)
begin
 carry=Cout[1];
 outputC=S;
 error=1;
end

endmodule

module m16bitDivider(inputA,inputB,result,err);

input [15:0]inputA;
input [15:0]inputB;
output [15:0]result;
output err;

wire [15:0] inputA;
wire [15:0] inputB;
reg [15:0] result;
reg err;

always@(*)
begin
 
   assign err=0;

   if (inputB==0)
      begin
	     assign err=1;
      end
 
   result=inputA/inputB;

 end

endmodule

module m16bitModulus(inputA,inputB,result,err);

input [15:0]inputA;
input [15:0]inputB;
output [15:0]result;
output err;

wire [15:0] inputA;
wire [15:0] inputB;
reg [15:0] result;
reg err;



always@(*)
begin
   assign err=0;

   if (inputB==0)
      begin
	     assign err=1;
      end
 
   result=inputA%inputB;
 
end

endmodule

module m16bitMultiplier(A,B,C);
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

  
   
  C[0]=  A[0]&B[0];
  C[1]=  Sum0[0];
  C[2]=  Sum1[0];
  C[3] = Sum2[0]; 
  C[4] = Sum3[0];
  C[5] = Sum4[0]; 
  C[6] = Sum5[0]; 
  C[7] = Sum6[0];
  C[8] = Sum7[0];  
  C[9] = Sum8[0];  
  C[10] = Sum9[0];  
  C[11] = Sum10[0];  
  C[12] = Sum11[0];  
  C[13] = Sum12[0];  
  C[14] = Sum13[0];  
  C[15] = Sum14[0];  
  C[16] = Sum14[1];  
  C[17] = Sum14[2];  
  C[18] = Sum14[3];  
  C[19] = Sum14[4];  
  C[20] = Sum14[5];  
  C[21] = Sum14[6];  
  C[22] = Sum14[7];  
  C[23] = Sum14[8];  
  C[24] = Sum14[9];  
  C[25] = Sum14[10];  
  C[26] = Sum14[11];  
  C[27] = Sum14[12];  
  C[28] = Sum14[13];  
  C[29] = Sum14[14];  
  C[30] = Sum14[15];  
  C[31] = Carry14[15];

  
end


endmodule


//============================================
//AND operation
//============================================
module AND(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]&inputB[0];
	result[1]=inputA[1]&inputB[1];
	result[2]=inputA[2]&inputB[2];
	result[3]=inputA[3]&inputB[3];
	result[4]=inputA[4]&inputB[4];
	result[5]=inputA[5]&inputB[5];
	result[6]=inputA[6]&inputB[6];
	result[7]=inputA[7]&inputB[7];
	result[8]=inputA[8]&inputB[8];
	result[9]=inputA[9]&inputB[9];
	result[10]=inputA[10]&inputB[10];
	result[11]=inputA[11]&inputB[11];
	result[12]=inputA[12]&inputB[12];
	result[13]=inputA[13]&inputB[13];
	result[14]=inputA[14]&inputB[14];
	result[15]=inputA[15]&inputB[15];

	outputC=result;
end

endmodule

//============================================
//OR operation
//============================================
module OR(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]|inputB[0];
	result[1]=inputA[1]|inputB[1];
	result[2]=inputA[2]|inputB[2];
	result[3]=inputA[3]|inputB[3];
	result[4]=inputA[4]|inputB[4];
	result[5]=inputA[5]|inputB[5];
	result[6]=inputA[6]|inputB[6];
	result[7]=inputA[7]|inputB[7];
	result[8]=inputA[8]|inputB[8];
	result[9]=inputA[9]|inputB[9];
	result[10]=inputA[10]|inputB[10];
	result[11]=inputA[11]|inputB[11];
	result[12]=inputA[12]|inputB[12];
	result[13]=inputA[13]|inputB[13];
	result[14]=inputA[14]|inputB[14];
	result[15]=inputA[15]|inputB[15];

	outputC=result;
end

endmodule

//============================================
//XOR operation
//============================================
module XOR(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]^inputB[0];
	result[1]=inputA[1]^inputB[1];
	result[2]=inputA[2]^inputB[2];
	result[3]=inputA[3]^inputB[3];
	result[4]=inputA[4]^inputB[4];
	result[5]=inputA[5]^inputB[5];
	result[6]=inputA[6]^inputB[6];
	result[7]=inputA[7]^inputB[7];
	result[8]=inputA[8]^inputB[8];
	result[9]=inputA[9]^inputB[9];
	result[10]=inputA[10]^inputB[10];
	result[11]=inputA[11]^inputB[11];
	result[12]=inputA[12]^inputB[12];
	result[13]=inputA[13]^inputB[13];
	result[14]=inputA[14]^inputB[14];
	result[15]=inputA[15]^inputB[15];

	outputC=result;
end

endmodule

//============================================
//XNOR operation
//============================================
module XNOR(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]~^inputB[0];
	result[1]=inputA[1]~^inputB[1];
	result[2]=inputA[2]~^inputB[2];
	result[3]=inputA[3]~^inputB[3];
	result[4]=inputA[4]~^inputB[4];
	result[5]=inputA[5]~^inputB[5];
	result[6]=inputA[6]~^inputB[6];
	result[7]=inputA[7]~^inputB[7];
	result[8]=inputA[8]~^inputB[8];
	result[9]=inputA[9]~^inputB[9];
	result[10]=inputA[10]~^inputB[10];
	result[11]=inputA[11]~^inputB[11];
	result[12]=inputA[12]~^inputB[12];
	result[13]=inputA[13]~^inputB[13];
	result[14]=inputA[14]~^inputB[14];
	result[15]=inputA[15]~^inputB[15];

	outputC=result;
end

endmodule

//============================================
//NOR operation
//============================================
module NOR(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]~|inputB[0];
	result[1]=inputA[1]~|inputB[1];
	result[2]=inputA[2]~|inputB[2];
	result[3]=inputA[3]~|inputB[3];
	result[4]=inputA[4]~|inputB[4];
	result[5]=inputA[5]~|inputB[5];
	result[6]=inputA[6]~|inputB[6];
	result[7]=inputA[7]~|inputB[7];
	result[8]=inputA[8]~|inputB[8];
	result[9]=inputA[9]~|inputB[9];
	result[10]=inputA[10]~|inputB[10];
	result[11]=inputA[11]~|inputB[11];
	result[12]=inputA[12]~|inputB[12];
	result[13]=inputA[13]~|inputB[13];
	result[14]=inputA[14]~|inputB[14];
	result[15]=inputA[15]~|inputB[15];

	outputC=result;
end

endmodule

//============================================
//NAND operation
//============================================
module NAND(inputA,inputB,outputC);
input  [15:0] inputA;
input  [15:0] inputB;
output [15:0] outputC;
wire   [15:0] inputA;
wire   [15:0] inputB;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=inputA[0]~&inputB[0];
	result[1]=inputA[1]~&inputB[1];
	result[2]=inputA[2]~&inputB[2];
	result[3]=inputA[3]~&inputB[3];
	result[4]=inputA[4]~&inputB[4];
	result[5]=inputA[5]~&inputB[5];
	result[6]=inputA[6]~&inputB[6];
	result[7]=inputA[7]~&inputB[7];
	result[8]=inputA[8]~&inputB[8];
	result[9]=inputA[9]~&inputB[9];
	result[10]=inputA[10]~&inputB[10];
	result[11]=inputA[11]~&inputB[11];
	result[12]=inputA[12]~&inputB[12];
	result[13]=inputA[13]~&inputB[13];
	result[14]=inputA[14]~&inputB[14];
	result[15]=inputA[15]~&inputB[15];

	outputC=result;
end

endmodule

//============================================
//NOT operation
//============================================
module NOT(inputA,outputC);
input  [15:0] inputA;
output [15:0] outputC;
wire   [15:0] inputA;
reg    [15:0] outputC;

reg    [15:0] result;

always@(*)
begin
	result[0]=~inputA[0];
	result[1]=~inputA[1];
	result[2]=~inputA[2];
	result[3]=~inputA[3];
	result[4]=~inputA[4];
	result[5]=~inputA[5];
	result[6]=~inputA[6];
	result[7]=~inputA[7];
	result[8]=~inputA[8];
	result[9]=~inputA[9];
	result[10]=~inputA[10];
	result[11]=~inputA[11];
	result[12]=~inputA[12];
	result[13]=~inputA[13];
	result[14]=~inputA[14];
	result[15]=~inputA[15];

	outputC=result;
end

endmodule



//=================================================
//Breadboard
//=================================================
module breadboard(clk,rst,A,B,C,opcode,error);
//----------------------------------
input clk;
input rst;
input [15:0] A;
input [15:0] B;
input [3:0] opcode;
wire clk;
wire rst;
wire [15:0] A;
wire [15:0] B;
wire [3:0] opcode;

output error;
reg error;
//----------------------------------
output [31:0] C;
reg [31:0] C;
//----------------------------------

wire [15:0][31:0] channels;
wire [15:0] b;
wire [15:0] outputADD;
wire [15:0] outputAND;
wire ADDerror;

reg [15:0] regA;
reg [15:0] regB;

reg  [31:0] next;
wire [31:0] cur;

Mux mux1(channels,opcode,b);
ADDER add1(regA,regB,outputADD,carry,ADDerror);
AND and1(regA,regB,outputAND);


//Accumulator Register
DFF ACC1 [31:0] (clk,next,cur);


assign channels[0]=cur;//NO-OP
assign channels[1]=0;//RESET
assign channels[2]=0;//GROUND=0
assign channels[3]=0;//GROUND=0
assign channels[4]=0;//GROUND=0
assign channels[5]={16'b0000000000000000,outputADD};
assign channels[6]=0;//GROUND=0
assign channels[7]=0;//GROUND=0
assign channels[8]=0;//GROUND=0
assign channels[9]={16'b0000000000000000,outputAND};
assign channels[10]=0;//GROUND=0
assign channels[11]=0;//GROUND=0
assign channels[12]=0;//GROUND=0
assign channels[13]=0;//GROUND=0
assign channels[14]=0;//GROUND=0
assign channels[15]=0;//GROUND=0

always @(*)
begin
 regA= A;
 regB= cur[31:0]; //to get the lower two bytes...
 //high bytes=cur[31:16]
 //low bytes=cur[15:0]
 
 //error=Div0 | Overflow;//Register=wire.
 
 if (opcode==4'b1)
 begin
   error=0;
 end

 assign C=b;//Might be better if C = Cur value....
 assign next=b;
end

endmodule


//=================================================
//TEST BENCH
//=================================================
module testbench();

//Local Variables
   reg  clk;
   reg  rst;
   reg  [15:0] inputA;
   reg  [15:0] inputB;
   wire [15:0] outputC;
   reg  [3:0] opcode;
   reg [31:0] count;
   wire error;

// create breadboard
breadboard bb8(clk,rst,inputA,inputB,outputC,opcode,error);


//=================================================
 //CLOCK Thread
 //=================================================
   initial begin //Start Clock Thread
     forever //While TRUE
        begin //Do Clock Procedural
          clk=0; //square wave is low
          #5; //half a wave is 5 time units
          clk=1;//square wave is high
          #5; //half a wave is 5 time units
		  $display("Tick");
        end
    end



//=================================================
// Display Thread
//=================================================

    initial begin //Start Output Thread
	forever
         begin
 
		 
		 case (opcode)
		 0: $display("%32b ==> %32b         , NO-OP",bb8.cur,bb8.b);
		 1: $display("%32b ==> %32b         , RESET",32'b00000000000000000000000000000000,bb8.b);
		 5: $display("%32b  +  %32b = %32b  , ADD"  ,bb8.cur,inputA,bb8.b);
		 9: $display("%32b AND %32b = %32b  , AND"  ,bb8.cur,inputA,bb8.b);
		 endcase
		 
		 #10;
		 end
	end

//=================================================
//STIMULOUS Thread
//=================================================
	initial begin//Start Stimulous Thread
	#6;	
	//---------------------------------
	inputA=16'b0000;
	opcode=4'b0000;//NO-OP
	#10; 
	//---------------------------------
	inputA=16'b0000;
	opcode=4'b0001;//RESET
	#10
	//---------------------------------	
	inputA=16'b0001;
	opcode=4'b0101;//ADD
	#10;
	//---------------------------------	
	inputA=16'b0001;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=16'b0001;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0001;//RESET
	#10;
	//---------------------------------	
	inputA=16'b1111;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=16'b1011;
	opcode=4'b1001;//AND
	#10;
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0000;//NOOP
	//---------------------------------	
	#5;
	$display("Left in Ready State...OOPS!");
	#5;
	#50;
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0001;//Reset
	#10;
	//---------------------------------	
	inputA=16'b00;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=16'b0001;
	opcode=4'b0101;//ADD
	#5;
	$display("Left in ADD State...OOPS!");
	#5;
	//Uh-oh...it was left in the ADD operation...its an addtion STATE!
	#100
	//---------------------------------	
	inputA=16'b0000;
	opcode=4'b0001;//RESET
	#10;
	//---------------------------------	
 
	$finish;
	end

endmodule
