module ModulusModule(inputA,inputB,result,err);

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

