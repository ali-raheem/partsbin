module pwm_tb();
   reg clk;
   reg rst;
   reg [3:0] in;
   wire      out;

   pwm #(.WIDTH(4)) DUT(
			.clk(clk),
			.rst(rst),
			.in(in),
			.out(out)
			);
   initial begin
      $dumpfile("pwm_test.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      in = 0;
      rst = 1;
      #10
	rst = 0;
      #5
	in = 4'b1111;
      #50000
	$finish;
      
   end

   always #5 clk = ~clk;
   always #100 in = in + 1;
endmodule // pwm_tb
