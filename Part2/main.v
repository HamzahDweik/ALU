//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(A,B,C,opcode,error);
input [15:0] A;
input [15:0] B;
output [31:0] C;
input [3:0] opcode;
output [1:0]error;

wire [15:0] A;
wire [15:0] B;
reg [31:0] C;
wire [3:0] opcode;
reg [1:0]error;

//==================
//FOR MULITIPLEXER
//==================
wire [15:0][31:0]channels;
wire [15:0] select;
wire [31:0] b;
 
wire [15:0] outputDIV;
wire [15:0] outputMOD;
//wire [15:0] outputAND;
wire [31:0] outputMULT;
wire [15:0] unknown;

//==================
//FOR ADDSUB
//==================
wire [15:0] sum;
wire carry;
wire overflow;
reg mode;
reg addcheck;
reg subcheck;

//====================
//FOR DIVIDER
//====================
wire div0err;
reg divcheck;

//====================
//FOR MODULUS
//====================
wire mod0err;
reg modcheck;

//=====================
//Declare Modules
//=====================

Dec4x16 dec1(opcode,select);
StructMux mux1(channels,select,b);

AddSub             addsub1or2 (A,B,mode,sum,carry,overflow);
SixteenBitMultiplier  mult3      (A,B,outputMULT);
DividerModule      div4       (A,B,outputDIV,div0err); 
ModulusModule      mod5       (A,B,outputMOD,mod0err);
//FourBitAND         and9       (A,B,outputAND);

//=========================
//Connect Wires
//=========================


assign channels[ 0]={16'b0000,unknown};
assign channels[ 1]={{16{sum[15]}},sum};
assign channels[ 2]={{16{sum[15]}},sum};
assign channels[ 3]=         outputMULT;
assign channels[ 4]={{16{outputDIV[15]}},outputDIV};
assign channels[ 5]={{16{outputMOD[15]}},outputMOD};
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

//Check for Subtraction
mode    =~opcode[3]&~opcode[2]&opcode[1]&~opcode[0];




//To Tidy Up the Error Mode
addcheck=~opcode[3]&~opcode[2]&~opcode[1]&opcode[0];
subcheck=mode;
divcheck=~opcode[3]& opcode[2]&~opcode[1]&~opcode[0];
modcheck=~opcode[3]& opcode[2]&~opcode[1]&opcode[0];

//Error Codes
error[0]=(overflow       )&(addcheck|subcheck);
error[1]=(div0err|mod0err)&(divcheck|modcheck);

//Return value, register C(Testbench) = to wire b(Multiplexer)
assign C=b;

end


endmodule

//================================================
//
//TEST BENCH
//
//================================================
module testbench();

//Local Variables
   reg  [15:0] inputA;
   reg  [15:0] inputB;
   reg  [3:0] opcode;
   wire [31:0] outputC;
   wire [1:0] error;
   

// create breadboard
	breadboard bb8(inputA,inputB,outputC,opcode,error);

//STIMULOUS
	initial begin//Start Stimulous Thread
	#2;	
	
	//---------------------------------
	$write("[        A       ]");
	$write("[        B       ]");
	$write("[       OP       ]");
	$write("[                C               ]");
	$write("[ E]");
	$display(";");

	
	//---------------------------------
	inputA=16'b0100;
	inputB=16'b0010;
	opcode=16'b0001;//ADD
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Add without Carry Error");
	$display(";");


	//---------------------------------
	inputA=16'b0111000000000000;
	inputB=16'b0010000000000000;
	opcode=16'b0001;//ADD
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Add with Carry Error");
	$display(";");

 

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0010;//SUBTRACT
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Subtraction without overflow");
	$display(";");
	
	inputA=16'b1000000000000000;
	inputB=16'b0000000000000001;
	opcode=16'b0010;//SUBTRACT
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Subtraction with overflow");
	$display(";");
	



	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0011;//Multiply
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Multiplication");
	$display(";");

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0100;//Divide
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Division");
	$display(";");

	inputA=16'b0111;
	inputB=16'b0000;
	opcode=16'b0100;//Divide
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);
	$write(": Division with Div0 Error");	
	$display(";");

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0101;//Modulus
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Modulus");
	$display(";");


	inputA=16'b0111;
	inputB=16'b0000;
	opcode=16'b0101;//Modulus
	#10	
	$write("[%16b]",inputA);
	$write("[%16b]",inputB);
	$write("[%16b]",opcode);
	$write("[%31b]",outputC);
	$write("[%2b]",error);	
	$write(": Modulus with Mod0 Error");	
	$display(";");


	//inputA=16'b0111;
	//inputB=16'b0010;
	//opcode=16'b1001;//AND
	//#10		
	//$write("[%16b]",inputA);
	//$write("[%16b]",inputB);
	//$write("[%16b]",opcode);
	//$write("[%31b]",outputC);
	//$write("[%2b]",error);	
	//$write(": AND gate");
	//$display(";");

	$display();
	$display("Decimal Test");
	$display();
	
	//---------------------------------
	$write("[        A       ]");
	$write("[        B       ]");
	$write("[       OP       ]");
	$write("[                C              ]");
	$write("[ E]");
	$display(";");
	//---------------------------------
	inputA=16'b0100;
	inputB=16'b0010;
	opcode=16'b0001;//ADD
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Add without Carry Error");
	$display(";");


	//---------------------------------
	inputA=16'b0111000000000000;
	inputB=16'b0010000000000000;
	opcode=16'b0001;//ADD
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Add with Carry Error");
	$display(";");

 

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0010;//SUBTRACT
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Subtraction without overflow");
	$display(";");
	
	inputA=16'b1000000000000000;
	inputB=16'b0000000000000001;
	opcode=16'b0010;//SUBTRACT
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Subtraction with overflow");
	$display(";");
	



	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0011;//Multiply
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Multiplication");
	$display(";");

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0100;//Divide
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Division");
	$display(";");

	inputA=16'b0111;
	inputB=16'b0000;
	opcode=16'b0100;//Divide
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);
	$write(": Division with Div0 Error");	
	$display(";");

	inputA=16'b0111;
	inputB=16'b0010;
	opcode=16'b0101;//Modulus
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Modulus");
	$display(";");


	inputA=16'b0111;
	inputB=16'b0000;
	opcode=16'b0101;//Modulus
	#10	
	$write("[%16d]",inputA);
	$write("[%16d]",inputB);
	$write("[%16d]",opcode);
	$write("[%31d]",outputC);
	$write("[%2d]",error);	
	$write(": Modulus with Mod0 Error");	
	$display(";");


	//inputA=16'b0111;
	//inputB=16'b0010;
	//opcode=16'b1001;//AND
	//#10		
	//$write("[%16d]",inputA);
	//$write("[%16d]",inputB);
	//$write("[%16d]",opcode);
	//$write("[%31d]",outputC);
	//$write("[%2d]",error);	
	//$write(": AND gate");
	//$display(";");

	
	$finish;
	end

endmodule