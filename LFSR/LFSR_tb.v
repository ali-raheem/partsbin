`timescale 10ns/1ns

module LFSR_tb();
   reg clk;
   reg rst;
   wire q;

   LFSR DUT(
	    .clk(clk),
	    .rst(rst),
	    .q(q));

   initial begin
      $dumpfile("LFSR.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      rst = 1;
      #2
	rst = 0;
      #1000
	$finish;
   end

   always #1 clk = !clk;
endmodule // LFSR_tb

   
