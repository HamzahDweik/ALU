
module Breadboard	(w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9);
input w,x,y,z;
output r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;  
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
wire w,x,y,z;

always @ (w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9) begin

//f0 = wx' + xyz' + y'z
r0= (w&(~x))|(x&y&(~z))|((~y)&z);

//f1 = wx + xz' + yz
r1= (w&x)|(x&(~z))|(y&z);

//f2 = yz + w'y'z' + w'xy' + xy'z'+ wx'z + wx'y 
r2= (y&z)|(~w&~y&~z)|(~w&x&~y)|(x&~y&~z)|(w&~x&z)|(w&~x&y); 

//f3 = w'xy'z' + x'z + w'x'y + wy'z + wx'y'
r3= (~w&x&~y&~z)|(~x&z)|(~w&~x&y)|(w&~y&z)|(w&~x&~y);

//f4 =  
r4=

//f5 = 
r5=

//f6 = 
r6=

//f7 = 
r7=

//f8 = w'z' + w'y + xy' + wy'z
r8= (~w&~z)|(~w&y)|(x&~y)|(w&~y&z);

//f9 =  xz + x`yz` + wxy` + wy`z
r9= (x&z)|(~x&y&~z)|(w&x&~y)|(w&~y&z);

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
   	
  $display ("|##|W|X|Y|Z|F0|F1|F2|F3|F4|F5|F6|F7|F8|F9|");
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

