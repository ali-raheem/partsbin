module EM4100_tb();
   reg clk;
   reg tx;
   reg [39:0] data;
   wire       q;

   EM4100 DUT(
	      .clk(clk),
	      .tx(tx),
	      .data(data),
	      .q(q));

   initial begin
      $dumpfile("EM4100.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      tx = 0;
      data = {{20{1'b1}}, {20{1'b0}}};
      #4
      tx = 1;
      #1000
      $finish;
   end // initial begin

   always #1 clk = !clk;
endmodule // EM4100_tb
