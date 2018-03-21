module counter_tb ();
   localparam WIDTH = 8;
   reg clk;
   reg updown;
   reg rst;
   wire [WIDTH-1:0] out;

   counter #(.WIDTH(WIDTH)) DUT(
	       .clk(clk),
	       .updown(updown),
	       .rst(rst),
	       .out(out)
	       );

   initial begin
      $dumpfile("counter.vcd");
      $dumpvars(0, counter_tb);
      clk = 0;
      updown = 1;
      rst = 0;
      #1
	rst = 1;
      #1
	clk = 1;
      #1
	rst = 0;
      clk = 0;
      #100
	updown = 0;
      #150
	$finish;
   end // initial begin

   always #1 clk = ~clk;
endmodule // counter_tb
