module SPI_LOOPBACK_tb();
	localparam BITS = 8;

	reg clk;
	reg rst;
	reg start;
	reg slave_latch;
	reg [BITS - 1:0] master_data_in;
	reg [BITS - 1:0] slave_data_in;

	wire [BITS - 1:0] master_data_out;
	wire [BITS - 1:0] slave_data_out;
	wire done;
	wire sclk;
	wire mosi;
	wire ss_n;
	wire miso;

	SPI_LOOPBACK_TOP #(.BITS(BITS)) DUT (
		.clk(clk),
		.rst(rst),
		.start(start),
		.slave_latch(slave_latch),
		.master_data_in(master_data_in),
		.slave_data_in(slave_data_in),
		.master_data_out(master_data_out),
		.slave_data_out(slave_data_out),
		.done(done),
		.sclk(sclk),
		.mosi(mosi),
		.ss_n(ss_n),
		.miso(miso)
	);

	initial begin
		$dumpfile("SPI/SPI_LOOPBACK.vcd");
		$dumpvars(0, DUT);

		clk = 0;
		rst = 1;
		start = 0;
		slave_latch = 0;
		master_data_in = 8'h3C;
		slave_data_in = 8'hA5;

		#4
		rst = 0;

		// Load the slave's outgoing data.
		#2
		slave_latch = 1;
		#2
		slave_latch = 0;

		// Start transfer.
		#2
		start = 1;
		#2
		start = 0;

		#200
		$finish;
	end

	always #1 clk = ~clk;

endmodule // SPI_LOOPBACK_tb
