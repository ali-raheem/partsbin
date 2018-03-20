module ln4017_tb ();
   reg cp0;
   reg cp1;
   reg mr;
   wire [9:0] out;
   wire	     q59_b;

   ln4017 DUT(
	      .cp0(cp0),
	      .cp1(cp1),
	      .mr(mr),
	      .out_q(out),
	      .q59_b(q59_b)
	      );

   initial begin
      $dumpfile("4017_test.vcd");
      $dumpvars(0, ln4017_tb);
      mr = 1;
      cp0 = 0;
      cp1 = 0;
      #10
	mr = 0;
      #1000
	cp1 = 1;
      #1000
	$finish;
   end // initial begin

   always #5 cp0 = ~cp0;

endmodule // ln4017_tb
