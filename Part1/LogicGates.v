
module Breadboard	(w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9);
input w,x,y,z;
output r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;  
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
wire w,x,y,z;

always @ (w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9) begin

// f0 = w'x'y'z + w'xy'z + w'xyz' + wx'y'z' + wx'y'z + wx'yz' + wx'yz + wxy'z + wxyz'
r0= (~w&~x&~y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&z)|(w&x&y&~z);

//f1 = wx + xz' + yz
r1= (w&x)|(x&(~z))|(y&z);

//f2 = yz + w'y'z' + w'xy' + xy'z'+ wx'z + wx'y 
r2= (y&z)|(~w&~y&~z)|(~w&x&~y)|(x&~y&~z)|(w&~x&z)|(w&~x&y); 

//f3 = w'xy'z' + x'z + w'x'y + wy'z + wx'y'
r3= (~w&x&~y&~z)|(~x&z)|(~w&~x&y)|(w&~y&z)|(w&~x&~y);

//f4 = w'y + xy'z + w'x'z' + wxy' 
r4= ((~w)&y)|(x&(~y)&z)|((~w)&(~x)&(~z))|(w&x&(~y));

//f5 = w'x + xz' + xy + w'yz + wy'z'
r5= ((~w)&x)|(x&(~z))|(x&y)|((~w)&y&z)|(w&(~y)&(~z));


//F6 = W'X'Y'Z + W'XY'Z' + WX'Y'Z' + WX'YZ' + WXY'Z' + WXY'Z + WXYZ' + WXYZ
r6 = ((~w)&(~x)&(~y)&z)|((~w)&x&(~y)&(~z))|(w&(~x)&(~y)&(~z))|(w&(~x)&y&(z))|(w&x&(~y)&(~z))|(w&x&(~y)&z)|(w&x&y&(~z))|(w&x&y&z);


//F7 = W'X'Y'Z' + W'X'YZ + W'XY'Z' + W'XY'Z' + W'XYZ + WX'Y'Z' + WX'Y'Z + WX'YZ' WXYZ'
r7 = ((~w)&(~x)&(~y)&(~z))|((~w)&(~x)&(y)&z)|((~w)&(x)&(~y)&(~z))|((~w)&(x)&(~y)&(~z))|((~w)&(x)&(y)&(z))|((w)&(~x)&(~y)&(z)) |((w)&(~x)&(y)&(z))| ((w)&(x)&(y)&(~z))| (w&~x&~y&~z);


//f8 = w'z' + w'y + xy' + wy'z
r8= ((~w)&(~z))|((~w)&y)|(x&(~y))|(w&(~y)&z);

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
  $display ("|==+=+=+=+=+==+==+==+==+==+==+==+==+==+==|");

	for (i = 0; i < 16; i = i + 1) 
	begin
		a=(i/8)%2;
		b=(i/4)%2;
		c=(i/2)%2;
		d=(i/1)%2;
		 
	    #60;
		 	
		$display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",i,a,b,c,d,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9);
		if(i%4==3)
		 $write ("|--+-+-+-+-+--+--+--+--+--+--+--+--+--+--|\n");

	end
 
	#10;
	$finish;
  end
  
endmodule

