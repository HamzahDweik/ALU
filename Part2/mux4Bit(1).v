//=================================================================
//
// DECODER
//
//=================================================================
module Dec4x16(binary,onehot);
	input [3:0] binary;
	output [15:0]onehot;
	
	assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule

//=================================================================
//
// BEHAVIORAL MULTIPLEXER
//
// Behavioral MUX.
// Tends to upset Students.
// MUX Multiplexer 16 by 4
//
//=================================================================
module Mux(channels,select,b);
input [15:0][3:0]channels; 
input       [3:0] select;
output      [3:0] b;
wire  [15:0][3:0] channels;
reg         [3:0] b;

always @(*)
begin
 b=channels[select]; //This is disgusting....
end

endmodule

//=================================================================
//
// STRUCTURAL MULTIPLEXER
//
// StructMux
//
// Combinational Logic of GATES
// Parallels Course Material
//
//=================================================================

//=================================================================
module StructMux(channels, select, b);
input [15:0][7:0] channels;
input      [15:0] select;
output      [7:0] b;


	assign b = ({4{select[15]}} & channels[15]) | 
               ({4{select[14]}} & channels[14]) |
			   ({4{select[13]}} & channels[13]) |
			   ({4{select[12]}} & channels[12]) |
			   ({4{select[11]}} & channels[11]) |
			   ({4{select[10]}} & channels[10]) |
			   ({4{select[ 9]}} & channels[ 9]) | //AND
			   ({4{select[ 8]}} & channels[ 8]) |
			   ({4{select[ 7]}} & channels[ 7]) |
			   ({4{select[ 6]}} & channels[ 6]) |
			   ({4{select[ 5]}} & channels[ 5]) | //MODULO
			   ({4{select[ 4]}} & channels[ 4]) | //DIVIDE
			   ({4{select[ 3]}} & channels[ 3]) | //MULTIPLY
			   ({4{select[ 2]}} & channels[ 2]) | //SUBTRACT
               ({4{select[ 1]}} & channels[ 1]) | //ADD
               ({4{select[ 0]}} & channels[ 0]) ;

endmodule

//=============================================
//
// Half Adder
//
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
//
// Full Adder
//
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
//=============================================
//
// FourBitFullAdder
//
//=============================================
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
//=================================================================
//
// FourBitMultiplier
//
// Inputs:
// A, a 4-Bit Integer Input
// B, a 4-Bit Integer Input
// C, an 8-Bit Integer Output
//=================================================================
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

//=================================================================
//
// FourBitAND 
//
// Inputs
// inputA, a 4-bit integer
// inputB, a 4-bit integer
//
// Output
// outputC, a 4-bit integer
//
//==================================================================

module FourBitAND(inputA,inputB,outputC);
input  [3:0] inputA;
input  [3:0] inputB;
output [3:0] outputC;
wire   [3:0] inputA;
wire   [3:0] inputB;
reg    [3:0] outputC;

reg    [3:0] result;

always@(*)
begin
	result[0]=inputA[0]&inputB[0];
	result[1]=inputA[1]&inputB[1];
	result[2]=inputA[2]&inputB[2];
	result[3]=inputA[3]&inputB[3];
	outputC=result;
end
 
endmodule
 
//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(A,B,C,opcode,error);
//----------------------------------
input [3:0] A;
input [3:0] B;
input [3:0] opcode;
wire clk;
wire rst;
wire [3:0] A;
wire [3:0] B;
wire [3:0] opcode;

output [1:0]error;
reg [1:0]error;
//----------------------------------
output [7:0] C;
reg [7:0] C;
//----------------------------------

wire [15:0][7:0]channels;
wire [15:0] select;
wire [7:0] b;
wire [3:0] outputADD;
wire [3:0] outputAND;
wire [7:0] outputMULT;
wire ADDerror;

wire [3:0] Carry;

wire [3:0] unknown;

Dec4x16 dec1(opcode,select);
StructMux mux1(channels,select,b);
FourBitMultiplier mult1(A,B,outputMULT);
FourBitFullAdder  add1(A,B,1'b0,Carry,outputADD);
FourBitAND and1(A,B,outputAND);
 
assign channels[ 0]={4'b0000,unknown};
assign channels[ 1]={4'b0000,outputADD};
assign channels[ 2]={4'b0000,unknown};
assign channels[ 3]=outputMULT;
assign channels[ 4]={4'b0000,unknown};
assign channels[ 5]={4'b0000,unknown};
assign channels[ 6]={4'b0000,unknown};
assign channels[ 7]={4'b0000,unknown};
assign channels[ 8]={4'b0000,unknown};
assign channels[ 9]={4'b0000,outputAND};
assign channels[10]={4'b0000,unknown};
assign channels[11]={4'b0000,unknown};
assign channels[12]={4'b0000,unknown};
assign channels[13]={4'b0000,unknown};
assign channels[14]={4'b0000,unknown};
assign channels[15]={4'b0000,unknown};

always@(*)
begin
assign error=2'b00;
assign C=b;
end


endmodule


//TEST BENCH
module testbench();

//Local Variables
   reg  [3:0] inputA;
   reg  [3:0] inputB;
   reg  [3:0] opcode;
   wire [7:0] outputC;
   wire [1:0] error;
   

// create breadboard
	breadboard bb8(inputA,inputB,outputC,opcode,error);

//STIMULOUS
	initial begin//Start Stimulous Thread
	#2;	
	
	//---------------------------------
	$write("[   A]");
	$write("[   B]");
	$write("[  OP]");
	$write("[       C]");
	$write("[ E]");
	$display(";");
	//---------------------------------
	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b0001;//ADD
	#10	
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Addition");
	$display(";");


	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b0010;//SUBTRACT
	#10	
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Not Connected");
	$display(";");
	
	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b0011;//Multiply
	#10	
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Multiply");
	$display(";");

	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b0100;//Divide
	#10	
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Not Connected");
	$display(";");

	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b0101;//Modulus
	#10	
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Not Connected");
	$display(";");

	inputA=4'b0100;
	inputB=4'b0010;
	opcode=4'b1001;//AND
	#10		
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Logical AND");
	$display(";");

	inputA=4'b1111;
	inputB=4'b0010;
	opcode=4'b1001;//AND
	#10		
	$write("[%4b]",inputA);
	$write("[%4b]",inputB);
	$write("[%4b]",opcode);
	$write("[%7b]",outputC);
	$write("[%2b]",error);	
	$write(":Logical AND");
	$display(";");


	
	$finish;
	end

endmodule