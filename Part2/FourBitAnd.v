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
 