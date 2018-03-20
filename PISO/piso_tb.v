module piso_tb();
   reg clk;
   reg latch;
   reg rst;
   reg [7:0] din;
   wire 	   dout;

   piso #(.WIDTH(8)) DUT(
			 .clk(clk),
			 .latch(latch),
			 .rst(rst),
			 .din(din),
			 .ser(0),
			 .dout(dout)
			 );
   initial begin
      $dumpfile("piso_test.vcd");
      $dumpvars(0, piso_tb);
      rst = 1;
      latch = 0;
      clk = 0;
      din = 8'b0;
      #15
	rst = 0;
      #5
	din = 8'b10101010;
      latch = 1;
      #5
	latch = 0;
      #50
	$finish;
   end // initial begin

   always #5
     clk = ~clk;
endmodule // piso_tb

   
