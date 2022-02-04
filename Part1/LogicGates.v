
module Breadboard	(w,x,y,z,r0,r1,r2, r3, r4, r5, r6, r7, r8, r9);
input w,x,y,z;
output r0, r1, r2;  
reg r0,r1,r2, r3, r4, r5, r6, r7, r8, r9;
wire w,x,y,z;

always @ ( w,x,y,z,r1,r2,r3) begin

//f0 = wx' + xyz' + y'z
r0= (x)|((~y)&z);

//f1 = 
r1= ~(~(~y&z)&(~x));

//f2 = 
r2= (w&x&y&z)|(~w&~x&~y&~z);

//f3 = 
r3=

//f4 = 
r4=

//f5 = 
r5=

//f6 = 
r6=

//f7 = 
r7=

//f8 = 
r8=

//f9 = 
r9=

end

endmodule


module testbench();

  reg [4:0] i;
  reg  a;
  reg  b;
  reg  c;
  reg  d;
  
  wire  f0,f1,f2,f3,f4,f5,f6,f7,f8,f9;
  Breadboard zap(a,b,c,d,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9);
 
  initial begin
   	
  $display ("|##|A|B|C|D|F0|F1|F2|F3|F4|F5|F6|F7|F8|F9|");
  $display ("|==+==+==+==+==+==+==+==+==+==+==+==+==+=|");

	for (i = 0; i < 16; i = i + 1) 
	begin
		a=(i/8)%2;
		b=(i/4)%2;
		c=(i/2)%2;
		d=(i/1)%2;
		 
	    #60;
		 	
		$display ("|%2d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|%1d|",i,a,b,c,d,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9);
		if(i%4==3)
		 $write ("|--+--+--+--+--+--+--+--+--+--+--+--+--+-|\n");

	end
 
	#10;
	$finish;
  end
  
endmodule

