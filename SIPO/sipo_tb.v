module sipo_tb ();
   reg clk;
   reg d;
   wire [15:0] out;
   reg rst;
   reg oe;
   reg ie;
   
   sipo #(.WIDTH(8)) DUT (
			  .clk(clk),
			  .d(d),
			  .q(out[7:0]),
			  .rst(rst),
			  .oe(oe),
			  .ie(ie)
			  );
   sipo #(.WIDTH(8)) DUT1 (
			   .clk(clk),
			   .d(out[7]),
			   .q(out[15:8]),
			   .rst(rst),
			   .oe(oe),
			   .ie(ie)
			   );
   always #5 clk = ~clk;

   initial begin
      $dumpfile("sipo_test.vcd");
      $dumpvars(0, sipo_tb);
      ie = 1;
      oe = 0;
      rst = 0;
      d = 0;
      clk = 0;
      #5
	rst = 1;
      #5
	rst = 0;
      #5
	oe = 1;
      #5
      d = 1;
      #25
	d = 0;
      #15
	d = 1;
      #50
	oe = 0;
      #10
	ie = 0;
      #5
	rst =1;
      #5
	rst = 0;
      #5
	oe = 1;
      #5
	ie = 1;
      #5
	rst = 1;
      #15
      $finish;
   end // initial begin

   always #5
     clk = ~ clk;
endmodule // sipo_tb
