module piso (clk, latch, din, ser, dout, rst);
   parameter WIDTH = 8;
   input clk;
   input latch;
   input rst;
   input ser;
   input [WIDTH-1:0] din;
   output reg 	     dout;

   reg [WIDTH-1:0]   data;
   
   always @ (posedge clk) begin
      if (rst) begin
	 data <= 0;
	 dout <= 0;
      end
      else if (latch)
	data <= din;
      else begin
	 dout <= data[0];
	 data[WIDTH-2:0] <= data[WIDTH-1:1];
	 data[WIDTH-1] <= ser;
      end
   end

endmodule // piso
