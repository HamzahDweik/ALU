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
	    sum=s1; 
		sum= A^B^C; 
	    carry=c1|c0; 
		carry= ((A^B)&C)|(A&B);  
	  end
//---------------------------------------------
	
endmodule

module AddSub(inputA,inputB,mode,sum,carry,overflow);
    input [3:0] inputA;
	input [3:0] inputB;
    input mode;
    output [3:0] sum;
	output carry;
    output overflow;

	wire c0; //MOde assigned to C0

    wire b0,b1,b2,b3; //XOR Interfaces
	wire c1,c2,c3,c4; //Carry Interfaces
	
	assign c0=mode;//Mode=0, Addition; Mode=1, Subtraction
	
    assign b0 = inputB[0] ^ mode;//Flip the Bit if Subtraction
    assign b1 = inputB[1] ^ mode;//Flip the Bit if Subtraction
    assign b2 = inputB[2] ^ mode;//Flip the Bit if Subtraction
    assign b3 = inputB[3] ^ mode;//Flip the Bit if Subtraction

	
 
	FullAdder FA0(inputA[0],b0,  c0,c1,sum[0]);
	FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
	FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
	FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);

	assign carry=c4;
	assign overflow=c4^c3;
 
endmodule



module testbench();


//Data Inputs
reg [3:0]dataA;
reg [3:0]dataB;
reg mode;

//Outputs
wire[3:0]result;
wire carry;
wire err;

//Instantiate the Modules
AddSub addsub(dataA,dataB,mode,result,carry,err);


initial
begin
//        0123456789ABCDEF
$display("Addition");
mode=0; 
dataA=4'b0100; 
dataB=4'b0010;
#100;
$write("mode=%b;",mode);
$write("%b+%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d+%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


mode=0; 
dataA=4'b1111;
dataB=4'b0001;
#100;
$write("mode=%b;",mode);
$write("%b+%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d+%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


mode=0; 
dataA=4'b1000;
dataB=4'b1100;
#100;
$write("mode=%b;",mode);
$write("%b+%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d+%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


$display("Subtraction");
mode=1; 
dataA=4'b0100; 
dataB=4'b0010;
#100;
$write("mode=%b;",mode);
$write("%b-%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d-%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


mode=1; 
dataA=4'b1111;
dataB=4'b0001;
#100;
$write("mode=%b;",mode);
$write("%b-%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d-%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


mode=1; 
dataA=4'b0100;
dataB=4'b0101;
#100;
$write("mode=%b;",mode);
$write("%b-%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d-%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);


end




endmodule
