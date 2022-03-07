//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(A,B,Result,Op,Error);
input [15:0] A;
input [15:0] B;
output [31:0] Result;
input [3:0] Op;
output [1:0] Error;

wire [15:0] A;
wire [15:0] B;
reg [31:0] Result;
wire [3:0] Op;
reg [1:0] Error;

//==================
//FOR MULITIPLEXER
//==================
wire [15:0][31:0]channels;
wire [15:0] Onehot;
wire [31:0] b;
 
wire [15:0] Quotient;
wire [15:0] Remainder;
wire [31:0] Product;
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

//=====================
//Declare Modules
//=====================

m4x16Decoder Decoder(Op,Onehot);
m16x32Mux Mux(channels,Onehot,b);

m16bitAddSub AdderSubtractor (A,B,Mode,Sum,carry,OFErr);
m16bitMultiplier Multiplier (A,B,Product);
m16bitDivider Divider (A,B,Quotient,Div0Err); 
m16bitModulus Modulus (A,B,Remainder,Mod0Err);
//FourBitAND         and9       (A,B,outputAND);

//=========================
//Connect Wires
//=========================


assign channels[ 0]={16'b0000,unknown};
assign channels[ 1]={{16{Sum[15]}},Sum};
assign channels[ 2]={{16{Sum[15]}},Sum};
assign channels[ 3]=         Product;
assign channels[ 4]={{16{Quotient[15]}},Quotient};
assign channels[ 5]={{16{Remainder[15]}},Remainder};
assign channels[ 6]={16'b0000,unknown};
assign channels[ 7]={16'b0000,unknown};
assign channels[ 8]={16'b0000,unknown};
assign channels[ 9]={16'b0000,unknown};
assign channels[10]={16'b0000,unknown};
assign channels[11]={16'b0000,unknown};
assign channels[12]={16'b0000,unknown};
assign channels[13]={16'b0000,unknown};
assign channels[14]={16'b0000,unknown};
assign channels[15]={16'b0000,unknown};

 

always@(*)
begin

//NOTE TO GRADER
//=================================================================
//
//Error-handling - Tried to keep the top-level diagram top-level. We did not want to draw out too many "And" and "Or" gates
// Encapsulated the logic below in a block called Error-handling
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

end


endmodule

//================================================
//
//TEST BENCH
//
//================================================
module testbench();

//Local Variables
   reg  [15:0] A;
   reg  [15:0] B;
   reg  [3:0] Op;
   wire [31:0] Result;
   wire [1:0] Error;
   

// create breadboard
	breadboard Tester(A,B,Result,Op,Error);

//STIMULOUS
	initial begin//Start Stimulous Thread
	#2;	
	
	//---------------------------------
	$write("[        A       ]");
	$write("[        B       ]");
	$write("[       OP       ]");
	$write("[                C              ]");
	$write("[ E]");
	$display(";");

	
	//---------------------------------

	A=16'b0100;
	B=16'b0010;
	Op=16'b0001;//ADD
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Adding two inputs less than 250");
	$display(";");

	A=16'b0100;
	B=16'b0010;
	Op=16'b0001;//ADD
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Adding two inputs less than 250");
	$display(";");

	A=16'b0111;
	B=16'b0010;
	Op=16'b0010;//SUBTRACT
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Subtracting two inputs less than 250");
	$display(";");

	A=16'b0111;
	B=16'b0010;
	Op=16'b0011;//Multiply
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);
	$write(": Multiplying two inputs less than 250");
	$display(";");

	A=16'b0111;
	B=16'b0010;
	Op=16'b0100;//Divide
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Dividing two inputs less than 250");
	$display(";");

	A=16'b0111;
	B=16'b0010;
	Op=16'b0101;//Modulus
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);
	$write(": Modulo of two inputs less than 250");
	$display(";");
	
	//---------------------------------
	A=16'b0100000000000100;
	B=16'b0100000000000010;
	Op=16'b0001;//ADD
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);
	$write(": Adding two inputs greater than 16000");
	$display(";");

	A=16'b0100000000000111;
	B=16'b0100000000000010;
	Op=16'b0010;//SUBTRACT
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Subtracting two inputs greater than 16000");
	$display(";");

	A=16'b0100000000000111;
	B=16'b0100000000000010;
	Op=16'b0011;//Multiply
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);
	$write(": Multiplying two inputs greater than 16000");
	$display(";");

	A=16'b0100000000000111;
	B=16'b0100000000000010;
	Op=16'b0100;//Divide
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Dividing two inputs greater than 16000");
	$display(";");

	A=16'b0100000000000111;
	B=16'b0100000000000010;
	Op=16'b0101;//Modulus
	#10	
	$write("[%16d]",A);
	$write("[%16d]",B);
	$write("[%16d]",Op);
	$write("[%31d]",Result);
	$write("[%2d]",Error);	
	$write(": Modulo of two inputs greater than 16000");
	$display(";");

	
	$finish;
	end

endmodule