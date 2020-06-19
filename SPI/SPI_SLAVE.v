module SPI_SLAVE(
		 input 	ss_n,
		 input 	sclk,
		 input 	mosi,
		 output miso
		 );
   
   parameter BITS = 8;


   reg [BITS - 1:0] 	data;
   reg 			outBit;
   reg 			inBit;

   always @ (posedge sclk)
     if (!ss_n)
       inBit <= mosi;
   
   always @ (negedge sclk)
      if (!ss_n) begin
	 data[0] <= inBit;
	 outBit <= data[BITS - 1];
	 data[BITS - 1: 1] <= data[BITS - 2: 0];
      end
   
   assign miso = ss_n ? 1'bZ : outBit;
endmodule // SPI_slave
