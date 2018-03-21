module piso_tb ();
   localparam WIDTH = 16;
   reg clk;
   reg shld;
   reg ser;
   reg [WIDTH-1:0] parin;
   wire 		   q_n;
   wire 		   q;

   piso #(.WIDTH(WIDTH)) DUT (
			  .clk(clk),
			  .shld(shld),
			  .ser(q),
			  .parin(parin),
			  .q(q),
			  .q_n(q_n)
			  );
   initial begin
      $dumpfile("piso.vcd");
      $dumpvars(0, piso_tb);
      clk = 0;
      shld = 1;
      ser = 0;
      parin = 16'h15AF;
      #1
	shld = 0;
      #5
	shld = 1;
      #1000
	$finish;
   end // initial begin

   always #5 clk = ~clk;
   
endmodule // piso_tb

   
