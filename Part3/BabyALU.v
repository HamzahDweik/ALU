
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

//============================================
//ADD operation
//============================================
module ADDER(inputA,inputB,outputC,carry,error);
//---------------------------------------
input [3:0] inputA;
input [3:0] inputB;
wire  [3:0] inputA;
wire  [3:0] inputB;
//---------------------------------------
output [3:0] outputC;
output       carry;
output error;
reg error;
reg    [3:0] outputC;
reg          carry;
//---------------------------------------

wire [3:0] S;
wire [3:0] Cin;
wire [3:0] Cout;
//Link the wires between the Adders
assign Cin[0]=0;
assign Cin[1]=Cout[0];
assign Cin[2]=Cout[1];
assign Cin[3]=Cout[2];

//Declare and Allocate 4 Full adders
Add_full FA [3:0] (inputA,inputB,Cin,Cout,S);

always @(*)
begin
 carry=Cout[1];
 outputC=S;
 error=1;
end

endmodule

//============================================
//AND operation
//============================================
module ANDER(inputA,inputB,outputC);
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



//=================================================
//Breadboard
//=================================================
module breadboard(clk,rst,A,B,C,opcode,error);
//----------------------------------
input clk; 
input rst;
input [3:0] A;
input [3:0] B;
input [3:0] opcode;
wire clk;
wire rst;
wire [3:0] A;
wire [3:0] B;
wire [3:0] opcode;

output error;
reg error;
//----------------------------------
output [3:0] C;
reg [3:0] C;
//----------------------------------

wire [15:0][3:0]channels;
wire [3:0] b;
wire [3:0] outputADD;
wire [3:0] outputAND;
wire ADDerror;

reg [3:0] regA;
reg [3:0] regB;

reg  [3:0] next;
wire [3:0] cur;

Mux mux1(channels,opcode,b);
ADDER add1(regA,regB,outputADD,carry,ADDerror);
ANDER and1(regA,regB,outputAND);


//Accumulator Register
DFF ACC1 [3:0] (clk,next,cur);


assign channels[0]=cur;//NO-OP
assign channels[1]=0;//RESET
assign channels[2]=0;//GROUND=0
assign channels[3]=0;//GROUND=0
assign channels[4]=0;//GROUND=0
assign channels[5]=outputADD;
assign channels[6]=0;//GROUND=0
assign channels[7]=0;//GROUND=0
assign channels[8]=0;//GROUND=0
assign channels[9]=outputAND;
assign channels[10]=0;//GROUND=0
assign channels[11]=0;//GROUND=0
assign channels[12]=0;//GROUND=0
assign channels[13]=0;//GROUND=0
assign channels[14]=0;//GROUND=0
assign channels[15]=0;//GROUND=0

always @(*)
begin
 regA= A;
 regB= cur[15:0]; //to get the lower two bytes...
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
   reg  [3:0] inputA;
   reg  [3:0] inputB;
   wire [3:0] outputC;
   reg  [3:0] opcode;
   reg [15:0] count;
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
		 0: $display("%4b ==> %4b         , NO-OP",bb8.cur,bb8.b);
		 1: $display("%4b ==> %4b         , RESET",4'b0000,bb8.b);
		 5: $display("%4b  +  %4b = %4b  , ADD"  ,bb8.cur,inputA,bb8.b);
		 9: $display("%4b AND %4b = %4b  , AND"  ,bb8.cur,inputA,bb8.b);
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
	inputA=4'b0000;
	opcode=4'b0000;//NO-OP
	#10; 
	//---------------------------------
	inputA=4'b0000;
	opcode=4'b0001;//RESET
	#10
	//---------------------------------	
	inputA=4'b0001;
	opcode=4'b0101;//ADD
	#10;
	//---------------------------------	
	inputA=4'b0001;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=4'b0001;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0001;//RESET
	#10;
	//---------------------------------	
	inputA=4'b1111;
	opcode=4'b0101;//ADD
	#10
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=4'b1011;
	opcode=4'b1001;//AND
	#10;
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0000;//NOOP
	//---------------------------------	
	#5;
	$display("Left in Ready State...OOPS!");
	#5;
	#50;
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0001;//Reset
	#10;
	//---------------------------------	
	inputA=4'b00;
	opcode=4'b0000;//NOOP
	#10;
	//---------------------------------	
	inputA=4'b0001;
	opcode=4'b0101;//ADD
	#5;
	$display("Left in ADD State...OOPS!");
	#5;
	//Uh-oh...it was left in the ADD operation...its an addtion STATE!
	#100
	//---------------------------------	
	inputA=4'b0000;
	opcode=4'b0001;//RESET
	#10;
	//---------------------------------	
 
	$finish;
	end

endmodule
