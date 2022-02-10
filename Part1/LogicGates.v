
module Breadboard	(w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9);
input w,x,y,z;
output r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;  
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
wire w,x,y,z;

always @ (w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9) begin

// f0 = w'x'y'z + w'xy'z + w'xyz' + wx'y'z' + wx'y'z + wx'yz' + wx'yz + wxy'z + wxyz'
r0= (~w&~x&~y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&z)|(w&x&y&~z);

//f1 = w'x'yz + w'xy'z' + w'xyz' + w'xyz + wx'yz + wxy'z' + wxy'z + wxyz' + wxyz
r1= (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&~z)|(w&x&y&z);

//f2 = yz + w'y'z' + w'xy' + xy'z'+ wx'z + wx'y 
r2= (y&z)|(~w&~y&~z)|(~w&x&~y)|(x&~y&~z)|(w&~x&z)|(w&~x&y); 

//f3 = w'xy'z' + x'z + w'x'y + wy'z + wx'y'
r3= (~w&x&~y&~z)|(~x&z)|(~w&~x&y)|(w&~y&z)|(w&~x&~y);

//f4 = w'x'y'z' + w'x'yz' + w'x'yz + w'xy'z + w'xyz' + w'xyz + wxy'z' + wxy'z
r4= (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&x&~y&~z)|(w&x&~y&z);

//f5 = w'x'yz + w'xy'z' + w'xy'z + w'xyz' + w'xyz + wx'y'z' + wxy'z' + wxyz' + wxyz
r5= (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&x&~y&~z)|(w&x&y&~z)|(w&x&y&z);

//f6 = F6=W'X'Y'Z + WX + XY'Z' + WY'Z' +WYZ
r6= ((~w)&(~x)&(~y)&z)|(w&x)|(x&(~y)&(~z))|(w&(~y)&(~z)|(w&y&z));

//F7= WXYZ' + X'Y'Z' + X'YZ + W'Y'Z' + W'YZ + WX'Y'
r7= (w&x&y&(~z))|((~x)&(~y)&(~z))| ((~x)&y&z)|((~w)&(~y)&(~z))|((~w)&y&z)|(w&(~x)&(~y));

//f8 = w`x`y`z` + w`x`yz` + w`x`yz + w`xy`z`+ w`xy`z + w`xyz` + w`xyz + wx`y`z + wxy`z` + wxy`z 
r8= (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&z)|(w&x&~y&~z)|(w&x&~y&z);

//f9 = w'x'yz` + w'xy'z + w'xyz + wx'y'z + wx'yz' + wxy'z' + wxy'z + wxyz
r9= (~w&~x&y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&z);

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

