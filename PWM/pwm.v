module pwm (clk, rst, in, out);
   parameter WIDTH = 8;
   input clk;
   input rst;
   input [WIDTH-1:0] in;
   output reg 	     out;
   reg [WIDTH-1:0]   counter;

   always @ (posedge clk) begin
      if (rst)
	counter <= 1'b0;
      else begin
	 counter <= counter + 1'b1;
	 if (in[WIDTH-1:0] >= counter[WIDTH-1:0])
	   out <= 1'b1;
	 else
	   out <= 1'b0;
      end
   end
   
endmodule // pwm
