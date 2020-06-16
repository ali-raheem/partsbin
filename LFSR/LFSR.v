module LFSR (clk, rst, q);
   // x^16 + x^14 + x^13 + x^11 + 1
   input clk;
   input rst;
   output q;

   reg [15:0] sr;
   
   always @ (posedge clk) begin
      if (rst)
	 sr <= 1;
      else begin
	 sr[0] <= sr[15] ^ sr[13] ^ sr[12] ^ sr[10];
	 sr[15:1] <= sr[14:0];
      end
   end
   
   assign q = sr[15];
  
endmodule // LFSR
