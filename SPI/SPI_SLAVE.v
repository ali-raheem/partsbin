module SPI_SLAVE(
		 input 			 ss_n,
		 input 			 sclk,
		 input 			 mosi,
		 output 		 miso,
		 input [BITS - 1:0] 	 inData,
		 input 			 latch,
 		 output reg [BITS - 1:0] outData
		 );
   
   parameter BITS = 8;


   reg 			outBit;
   reg 			inBit;

   always @ (latch)
      outData <= inData;
      
   always @ (posedge sclk)
     if (!ss_n)
       inBit <= mosi;
   
   always @ (negedge sclk)
      if (!ss_n) begin
	 outBit <= outData[BITS - 1];
	 outData[BITS - 1: 1] <= outData[BITS - 2: 0];
	 outData[0] <= inBit;
      end
   
   assign miso = ss_n ? 1'bZ : outBit;
endmodule // SPI_slave
