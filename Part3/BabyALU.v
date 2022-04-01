//============================================
//D Flip-Flop
//============================================
module m16bitDFF(clk,in,out);
	input          clk;
	input   in;
	output  out;
	reg     out;

	always @(posedge clk)
	out = in;
endmodule

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

//=============================================
// SixteenBitFullAdder
//=============================================
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
endmodule


//=================================================================
// DECODER
//=================================================================
module m4x16Dec(binary,onehot);
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
// STRUCTURAL MULTIPLEXER
//
// StructMux
//
// Combinational Logic of GATES
// Parallels Course Material
//
//=================================================================

//=================================================================
module m16x32Mux(channels, select, b);
input [15:0][31:0] channels;
input      [15:0] select;
output      [31:0] b;


	assign b = ({32{select[15]}} & channels[15]) |
               ({32{select[14]}} & channels[14]) |
			   ({32{select[13]}} & channels[13]) |
			   ({32{select[12]}} & channels[12]) |
			   ({32{select[11]}} & channels[11]) |
			   ({32{select[10]}} & channels[10]) |
			   ({32{select[ 9]}} & channels[ 9]) |
			   ({32{select[ 8]}} & channels[ 8]) |
			   ({32{select[ 7]}} & channels[ 7]) |
			   ({32{select[ 6]}} & channels[ 6]) |
			   ({32{select[ 5]}} & channels[ 5]) |
			   ({32{select[ 4]}} & channels[ 4]) |
			   ({32{select[ 3]}} & channels[ 3]) |
			   ({32{select[ 2]}} & channels[ 2]) |
               ({32{select[ 1]}} & channels[ 1]) |
               ({32{select[ 0]}} & channels[ 0]) ;

endmodule

//============================================
//ADD,SUB operations
//============================================
module m16bitAddSub(inputA,inputB,mode,sum,carry,overflow);
    input [15:0] inputA;
	input [15:0] inputB;
    input mode;
    output [15:0] sum;
	output carry;
    output overflow;

	wire c0; //MOde assigned to C0

    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15; //XOR Interfaces
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16; //Carry Interfaces

	assign c0=mode;//Mode=0, Addition; Mode=1, Subtraction

    assign b0 = inputB[0] ^ mode;//Flip the Bit if Subtraction
    assign b1 = inputB[1] ^ mode;//Flip the Bit if Subtraction
    assign b2 = inputB[2] ^ mode;//Flip the Bit if Subtraction
    assign b3 = inputB[3] ^ mode;//Flip the Bit if Subtraction
	assign b4 = inputB[4] ^ mode;//Flip the Bit if Subtraction
    assign b5 = inputB[5] ^ mode;//Flip the Bit if Subtraction
    assign b6 = inputB[6] ^ mode;//Flip the Bit if Subtraction
    assign b7 = inputB[7] ^ mode;//Flip the Bit if Subtraction
	assign b8 = inputB[8] ^ mode;//Flip the Bit if Subtraction
    assign b9 = inputB[9] ^ mode;//Flip the Bit if Subtraction
    assign b10 = inputB[10] ^ mode;//Flip the Bit if Subtraction
    assign b11 = inputB[11] ^ mode;//Flip the Bit if Subtraction
	assign b12 = inputB[12] ^ mode;//Flip the Bit if Subtraction
    assign b13 = inputB[13] ^ mode;//Flip the Bit if Subtraction
    assign b14 = inputB[14] ^ mode;//Flip the Bit if Subtraction
    assign b15 = inputB[15] ^ mode;//Flip the Bit if Subtraction

	FullAdder FA0(inputA[0],b0,  c0,c1,sum[0]);
	FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
	FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
	FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);
	FullAdder FA4(inputA[4],b4,  c4,c5,sum[4]);
	FullAdder FA5(inputA[5],b5,  c5,c6,sum[5]);
	FullAdder FA6(inputA[6],b6,  c6,c7,sum[6]);
	FullAdder FA7(inputA[7],b7,  c7,c8,sum[7]);
	FullAdder FA8(inputA[8],b8,  c8,c9,sum[8]);
	FullAdder FA9(inputA[9],b9,  c9,c10,sum[9]);
	FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
	FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
	FullAdder FA12(inputA[12],b12,  c12,c13,sum[12]);
	FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
	FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
	FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);

	assign carry=c16;
	assign overflow=c16^c15;

endmodule

//============================================
//DIV operation
//============================================
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


//============================================
//MOD operation
//============================================
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

//============================================
//MULT operation with SHIFTING (bonus)
//============================================
module m16bitMultiplier(A,B,C);
input  [15:0] A;
input  [15:0] B;
output [31:0] C;

reg [31:0] A_temp;
reg [31:0] Q_temp;

integer i;
always @(A,B)
begin
A_temp ={16'b0,A[15:0]};//a_temp=32'b0;
Q_temp = 32'b0;
for(i=0;i<16;i=i+1)
begin
   if(B[i] == 1)
        Q_temp=Q_temp+A_temp;//add based on multiplier bit
   else
        Q_temp=Q_temp;
   A_temp={A_temp[30:0]<<1};//shift in each iteration
end
end
assign C=Q_temp[31:0];
endmodule

//============================================
//AND operation
//============================================
module m16bitAND(inputA,inputB,outputC);
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
module m16bitOR(inputA,inputB,outputC);
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
module m16bitXOR(inputA,inputB,outputC);
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
module m16bitXNOR(inputA,inputB,outputC);
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
module m16bitNOR(inputA,inputB,outputC);
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
module m16bitNAND(inputA,inputB,outputC);
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
module m16bitNOT(inputA,outputC);
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


//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(Clock,Reset,A,B,Result,Op,Error);

input Clock;
input Reset;
input [15:0] A;
input [15:0] B;
input [3:0] Op;
output [31:0] Result;
output [1:0] Error;

wire Clock;
wire Reset;
wire [15:0] A;
wire [15:0] B;
wire [3:0] Op;
reg [31:0] Result;
reg [1:0] Error;

reg [15:0] regA;
reg [15:0] regB;

//==================
//FOR MULITIPLEXER
//==================
wire [15:0][31:0]channels;
wire [15:0] Onehot;
wire [31:0] b;

wire [31:0] Product;
wire [15:0] Quotient;
wire [15:0] Remainder;
wire [15:0] Anded;
wire [15:0] Nanded;
wire [15:0] Nored;
wire [15:0] Noted;
wire [15:0] Ored;
wire [15:0] Xnored;
wire [15:0] Xored;
wire [15:0] unknown;

//==================
//FOR ADDSUB
//==================
wire [15:0] Sum;
wire carry;
wire OFErr;
reg Mode;
reg addcheck;
reg subcheck;

//====================
//FOR DIVIDER
//====================
wire Div0Err;
reg divcheck;

//====================
//FOR MODULUS
//====================
wire Mod0Err;
reg modcheck;

//====================
//FOR FLIPFLOP
//====================

reg  [31:0] Next;
wire [31:0] Current;

//=====================
//Declare Modules
//=====================

m4x16Dec Decoder(Op,Onehot);
m16x32Mux Mux(channels,Onehot,b);

m16bitAddSub AdderSubtractor (regA,regB,Mode,Sum,carry,OFErr);
m16bitMultiplier Multiplier (regA,regB,Product);
m16bitDivider Divider (regB,regA,Quotient,Div0Err); 
m16bitModulus Modulus (regB,regA,Remainder,Mod0Err);
m16bitAND And (regA,regB,Anded);
m16bitNAND Nand (regA,regB, Nanded);
m16bitNOR Nor (regA,regB, Nored);
m16bitNOT Not (A, Noted);
m16bitOR Or (regA,regB, Ored);
m16bitXNOR Xnor (regA,regB, Xnored);
m16bitXOR Xor (regA,regB, Xored);
m16bitDFF Accumulator [31:0] (Clock,Next,Current);

//=========================
//Connect Wires
//=========================

assign channels[ 0]=		Current;
assign channels[ 1]={{16{Sum[15]}},Sum};
assign channels[ 2]={{16{Sum[15]}},Sum};
assign channels[ 3]=         Product;
assign channels[ 4]={16'b0,Quotient};
assign channels[ 5]={16'b0,Remainder};
assign channels[ 6]={16'b0,Anded};
assign channels[ 7]={16'b0,Nanded};
assign channels[ 8]={16'b0,Nored};
assign channels[ 9]={16'b0,Noted};
assign channels[10]={16'b0,Ored};
assign channels[11]={16'b0,Xnored};
assign channels[12]={16'b0,Xored};
assign channels[13]=32'b0;
assign channels[14]=32'b11111111111111111111111111111111;
assign channels[15]={16'b0000,unknown};

always@(*)
begin

regA=A;
regB= Current[15:0];

//NOTE TO GRADER
//=================================================================
//
//Professors code - Tried to keep the top-level diagram top-level. We did not want to draw out too many "And" and "Or" gates
// Encapsulated the logic below in a block called professor's code, as instructed by the professor himself
//					|
//					V
//=================================================================

//Check for Subtraction
Mode    =~Op[3]&~Op[2]&Op[1]&~Op[0];

//To Tidy Up the Error Mode
addcheck=~Op[3]&~Op[2]&~Op[1]&Op[0];
subcheck= Mode;
divcheck=~Op[3]& Op[2]&~Op[1]&~Op[0];
modcheck=~Op[3]& Op[2]&~Op[1]&Op[0];

//Error Codes
Error[0]=(OFErr       )&(addcheck|subcheck);
Error[1]=(Div0Err|Mod0Err)&(divcheck|modcheck);

//Return value, register C(Testbench) = to wire b(Multiplexer)
assign Result=b;
assign Next=b;

end
endmodule

//=================================================
//TEST BENCH
//=================================================
module testbench();

//Local Variables
   reg  Clock;
   reg  Reset;
   reg  [15:0] A;
   reg  [15:0] B;
   wire [31:0] Result;
   reg  [3:0] Op;
   reg [31:0] count;
   wire [1:0] Error;
   wire [15:0] x;

// create breadboard
breadboard bb8(Clock,Reset,A,B,Result,Op,Error);

function [15:0] trunc(input [31:0] val32);
  trunc = val32[15:0];
endfunction

assign x = trunc(bb8.Current);

//=================================================
 //CLOCK Thread
 //=================================================
   initial begin //Start Clock Thread
     forever //While TRUE
        begin //Do Clock Procedural
          Clock=0; //square wave is low
          #5; //half a wave is 5 time units
          Clock=1;//square wave is high
          #5; //half a wave is 5 time units
        end
    end

//=================================================
// Display Thread
//=================================================

    initial begin //Start Output Thread
	forever
         begin
			 
		 case (Op)
		 0: $display("| %6d | %16b | %6d | %16b |   No-op   |  %4b  | %10d | %32b |  %2b   |",0,16'b0,x,x, Op,bb8.b,bb8.b,Error);
		 1: $display("| %6d | %16b | %6d | %16b |   Add     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 2: $display("| %6d | %16b | %6d | %16b |   Sub     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 3: $display("| %6d | %16b | %6d | %16b |   Mult    |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 4: $display("| %6d | %16b | %6d | %16b |   Div     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 5: $display("| %6d | %16b | %6d | %16b |   Mod     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 6: $display("| %6d | %16b | %6d | %16b |   And     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 7: $display("| %6d | %16b | %6d | %16b |   Nand    |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 8: $display("| %6d | %16b | %6d | %16b |   Nor     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 9: $display("| %6d | %16b | %6d | %16b |   Not     |  %4b  | %10d | %32b |  %2b   |",0,16'b0,x,x,Op,bb8.b,bb8.b,Error);
		 10: $display("| %6d | %16b | %6d | %16b |   Or      |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 11: $display("| %6d | %16b | %6d | %16b |   Xnor    |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 12: $display("| %6d | %16b | %6d | %16b |   Xor     |  %4b  | %10d | %32b |  %2b   |",bb8.regA,bb8.regA,x,x,Op,bb8.b,bb8.b,Error);
		 13: $display("| %6d | %16b | %6d | %16b |   Reset   |  %4b  | %10d | %32b |  %2b   |",0,16'b0,0,16'b0,Op,bb8.b,bb8.b,Error);
		 14: $display("| %6d | %16b | %6d | %16b |   Preset  |  %4b  | %10d | %32b |  %2b   |",0,16'b0,0,16'b0,Op,bb8.b,bb8.b,Error);
		 endcase

		 #10;
		 end
	end

//=================================================
//STIMULOUS Thread
//=================================================
	initial begin//Start Stimulous Thread
	
	$display("--------------------------------------------------------------------------------------------------------------------------------------");
	$display("|   I    |      Input       |   F    |     Feedback     | Operation | Opcode |     O      |              Output              | Error |");
	$display("--------------------------------------------------------------------------------------------------------------------------------------");


	#6;
	A=16'b0000;
	Op=4'b1101;//RESET
	#10
	//---------------------------------
	A=16'b0000;
	Op=4'b0000;//NO-OP
	#10;
	//---------------------------------
	A=16'b0001;
	Op=4'b0001;//ADD
	#10;
	//---------------------------------
	A=16'b0010;
	Op=4'b0001;//ADD
	#10
	//---------------------------------
	A=16'b0101;
	Op=4'b0001;//ADD
	#10
	//---------------------------------
	A=16'b0000;
	Op=4'b0000;//NOOP
	#10;
	//---------------------------------
	A=16'b0010;
	Op=4'b0011;//MULT
	#10;
	//---------------------------------	
	A=16'b0100;
	Op=4'b0100;//DIV
	#10;
	//---------------------------------
	A=16'b0011;
	Op=4'b0101;//MOD
	#10;
	//---------------------------------
	A=16'b0000;
	Op=4'b1110;//PRESET
	#10;
	//---------------------------------	
	A=16'b1100110010111011;
	Op=4'b0010;//SUB
	#10;
	//---------------------------------
	A=16'b1010101010101010;
	Op=4'b0110;//AND
	#10
	//---------------------------------
	A=16'b1110100010100010;
	Op=4'b0111;//NAND
	#10;
	//---------------------------------
	A=16'b0011100000111011;
	Op=4'b1000;//NOR
	#10;
	//---------------------------------	
	A=16'b0101000000101100;
	Op=4'b1010;//OR
	#10;
	//---------------------------------
	A=16'b1010111100001010;
	Op=4'b1011;//XNOR
	#10;
	//---------------------------------
	A=16'b0000101011111010;
	Op=4'b1100;//XOR
	#10
	//---------------------------------
	A=16'b0000;
	Op=4'b1001;//RESET
	#10;
	//---------------------------------
	
	$display("-------------------------------------------------------------------------------------------------------------------------------------");

	$finish;
	end

endmodule
