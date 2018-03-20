module piso (clk, latch, din, ser, dout, rst);
   parameter WIDTH = 8;
   input clk;
   input latch;
   input rst;
   input ser;
   input [WIDTH-1:0] din;
   output reg 	     dout;

   reg [WIDTH-1:0]   data;
   
   always @ (posedge latch) begin
      data <= din;
   end
   always @ (posedge clk) begin
      if(~latch) begin
	dout <= data[0];
	 data[WIDTH-2:0] <= data[WIDTH-1:1];
	 data[WIDTH-1] <= ser;
      end
   end
   always @ (posedge rst) data <= 0;

endmodule // piso
