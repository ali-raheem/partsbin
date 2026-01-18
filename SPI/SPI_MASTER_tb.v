module SPI_MASTER_tb();
	reg clk;
	reg rst;
	wire sclk;
	wire mosi;
	wire ss_n;
	reg miso;
	wire data_sent;
	reg data_ready;
	reg [7:0] data_in;
	wire [7:0] data_out;

	SPI_MASTER #(.BITS(8)) DUT (
		.clk(clk),
		.rst(rst),
		.sclk(sclk),
		.mosi(mosi),
		.ss_n(ss_n),
		.miso(miso),
		.data_sent(data_sent),
		.data_ready(data_ready),
		.data_in(data_in),
		.data_out(data_out)
	);

	initial begin
		$dumpfile("SPI/SPI_MASTER.vcd");
		$dumpvars(0, DUT);

		clk = 0;
		rst = 1;
		miso = 1'b0;
		data_ready = 0;
		data_in = 8'b00110101;

		#4
		rst = 0;

		#2
		data_ready = 1;
		#2
		data_ready = 0;

		#80
		$finish;
	end

	always #1 clk = ~clk;

endmodule // SPI_MASTER_tb
