module counter (clk, rst, updown, out);
   parameter WIDTH = 8;
   input clk;
   input rst;
   input updown;
   output reg [WIDTH-1:0] out;

   always@(posedge clk) begin
      if (rst)
	out <= 0;
      else begin
	 if (updown)
	   out <= out + 1;
	 else
	   out <= out - 1;
      end
   end

endmodule // counter

   
   
