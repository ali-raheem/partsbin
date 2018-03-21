module piso_tb();
   reg clk;
   reg latch;
   reg rst;
   reg [7:0] din;
   reg 	     ser;
   wire 	   dout;

   piso #(.WIDTH(8)) DUT(
			 .clk(clk),
			 .latch(latch),
			 .rst(rst),
			 .din(din),
			 .ser(ser),
			 .dout(dout)
			 );
   initial begin
      $dumpfile("piso_test.vcd");
      $dumpvars(0, piso_tb);
      $dumpfile("piso.vcd");
      $dumpvars(0, DUT);
      rst = 1;
      ser = 0;
      latch = 0;
      clk = 0;
      din = 8'b0;
      #10
	rst = 0;
      #5
	din = 8'h55;
      latch = 1;
      #15
	latch = 0;
      din = 0;
      #100
	din = 8'hAA;
      latch = 1;
      #7
	latch = 0;
      din = 0;
      #100
	din = 8'h0f;
      latch = 1;
      #10
	latch = 0;
      din = 0;
      #100
	din = 8'hcd;
      latch = 1;
      #7
	latch = 0;
      din = 0;
      #100
      #100
	din = 8'b10000000;
      latch = 1;
      #5
	latch = 0;
      din = 0;
      #100
	din = 8'hf0;
      latch = 1;
      #5
	latch = 0;
      din = 0;
      #100
	
	$finish;
   end // initial begin

   always #5
     clk = ~clk;
endmodule // piso_tb

   
