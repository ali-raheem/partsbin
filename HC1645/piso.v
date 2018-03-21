module piso (clk, shld, q_n, q, ser, parin);
   parameter WIDTH = 8;
   input clk;
   input shld;
   input ser;
   input [WIDTH-1:0] parin;
   output q_n;
   output q;

   reg [WIDTH-1:0] data;
   
   always @ (posedge clk)
      if (shld) begin
	 data[WIDTH-2:0] <= data[WIDTH-1:1];
	 data[WIDTH-1] <= ser;
      end

   always @ (negedge shld) data <= parin;

   assign q = data[0];
   assign q_n = ~data[0];
endmodule // piso
