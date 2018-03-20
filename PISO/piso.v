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
      if(rst)
	data <= 1'b0;
      else begin
	 dout <= data[0];
	 data[WIDTH-2:0] <= data[WIDTH-1:1];
	 data[0] <= ser;
      end
   end
endmodule // piso
