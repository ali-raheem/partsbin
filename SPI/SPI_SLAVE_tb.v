module SPI_SLAVE_tb();
   localparam data = 8'b10101100;
   localparam BITS = 8;
   
   reg sclk;
   reg ss_n;
   reg mosi;
   wire miso;

   reg [BITS - 1: 0] mdata;
   
   SPI_SLAVE #(.BITS(BITS))
   DUT (
	.sclk(sclk),
	.ss_n(ss_n),
	.mosi(mosi),
	.miso(miso)
	);
   
   initial begin
      $dumpfile("SPI_SLAVE.vcd");
      $dumpvars(0, DUT);
      sclk = 0;
      ss_n = 0;
      mdata = data;
      #16
	mdata = data;
      
      #80
	$finish;      
   end

   always #1 sclk = !sclk;
   always #1 begin
	mosi <= mdata[BITS - 1];
	mdata[BITS - 1:1] <= mdata[BITS - 2:0];
   end
   always #3
      mdata[0] <= miso;
endmodule // SPI_SLAVE_tb

