module SPI_SLAVE_tb();
   localparam data = 8'hC5;
   localparam BITS = 8;
   
   reg sclk;
   reg ss_n;
   reg mosi;
   wire miso;
   reg 	latch;
   
   reg [BITS - 1:0] mdata;
   reg [BITS - 1:0] sdata;

   reg [BITS - 1:0] readData;
   
   SPI_SLAVE #(.BITS(BITS))
   DUT (
	.sclk(sclk),
	.ss_n(ss_n),
	.mosi(mosi),
	.miso(miso),
	.latch(latch),
	.inData(sdata)
	);
   
   initial begin
      $dumpfile("SPI_SLAVE.vcd");
      $dumpvars(0, DUT);
      readData = 8'bX;
      sdata = 8'h65;
      mdata = data;
      latch = 1;
      #1
	latch = 0;
      #1
      sdata = 0;
      sclk = 0;
      ss_n = 0;
      #19
      mdata = readData;
      ss_n = 1;
      #2
	ss_n = 0;
      #17
	ss_n = 1;
      
      
      #80
	$finish;      
   end

   always #1 sclk = !sclk;
   always #2 begin
      mosi <= mdata[BITS - 1];
      mdata[BITS - 1:1] <= mdata[BITS - 2:0];
      readData[BITS - 1:1] <= readData[BITS - 2:0];
      readData[0] <= miso;
   end
   always #3
      mdata[0] <= miso;
endmodule // SPI_SLAVE_tb

