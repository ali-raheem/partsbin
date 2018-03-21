module sipo (clk, d, q, rst, oe, ie);
   parameter WIDTH = 8;
   input clk;
   input d;
   input rst;
   input oe;
   input ie;
   output [WIDTH-1:0] q;
   reg [WIDTH-1:0]   out;

   always @ (posedge clk) begin
      if(ie) begin
	 if(rst)
	   out <= 0;
	 else begin
	    out[WIDTH-1:0] <= {out[WIDTH-2:0], d};	    
	 end
      end
   end

   assign q = oe ? out: {{WIDTH}{1'bz}};

endmodule // sipo
