module sseg_tb ();
   reg [3:0] in;
   wire [6:0] out;
   reg 	      oe;

   sseg DUT(
	    .in(in),
	    .out_q(out),
	    .oe(oe)
	    );
   initial begin
      $dumpfile("sseg.vcd");
      $dumpvars(0, sseg_tb);
      in = 0;
      oe = 1;
      #100
	$finish;
   end
   always #5 in = in + 1;
endmodule // sseg_tb

   
   
