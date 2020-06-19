module SPI_MASTER(
		  input 	     clk, 
		  output 	     sclk,
		  output 	     mosi,
		  output 	     ss_n,
		  input 	     miso,
		  input 	     latch,
		  inout [BITS - 1:0] data);

   parameter BITS = 8;

   reg 				     inBit;
   reg [BITS - 1:0] 		     buffer;
   
   always @ (posedge latch)
     buffer <= data;

   always @ (posedge clk) begin
      sclk = ~sclk;
      if (sclk) begin //negedge sclk
	 mosi <= buffer[0];
	 buffer[BITS - 2:0] <= buffer[BITS - 1:1];
	 buffer[0] <= inBit;
      end
      else begin //posedge clk
	 inBit <= miso;
      end
      
   end
     
endmodule // SPI_MASTER
