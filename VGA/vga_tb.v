module vga_tb ();
   reg clk;
   reg rst;
   wire draw;
   wire hs;
   wire vs;
   wire [9:0] x;
   wire [8:0] y;

   vga DUT (
	    .clk(clk),
	    .rst(rst),
	    .draw(draw),
	    .hs(hs),
	    .vs(vs),
	    .x(x),
	    .y(y)
	    );

   initial begin
      $dumpfile("vga.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      rst = 1;
      #2
	rst = 0;
      #2000000
	$finish;
   end
   always #1
     clk = ~clk;

endmodule // vga_tb
