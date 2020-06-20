module SPI_MASTER_tb();
   reg clk;
   wire sclk;
   wire mosi;
   wire ss_n;
   reg 	miso;
   wire data_sent;
   reg 	data_ready;
   reg 	data;
   
   SPI_MASTER #(.BITS(8))
   DUT(
       .clk(clk),
       .sclk(sclk),
       .mosi(mosi),
       .miso(miso),
       .ss_n(ss_n),
       .data_sent(data_sent),
       .data_ready(data_ready),
       .data(data));
   
   initial begin
      $dumpfie("SPI_MASTER.vcd");
      $dumpvars(0, DUT);
      miso <= 1'b0;
      data = 8'b00110101;
      #1
	data_ready = 1;
      #2
	data_ready = 0;
      #32
      $finish;
   end
   
   always #1 clk = ~clk;
   
endmodule // SPI_MASTER_tb
