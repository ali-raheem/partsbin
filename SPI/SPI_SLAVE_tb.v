module SPI_SLAVE_tb();
	localparam DATA = 8'hC5;
	localparam BITS = 8;

	reg rst;
	reg sclk;
	reg ss_n;
	reg mosi;
	wire miso;
	reg latch;

	reg [BITS - 1:0] mdata;
	reg [BITS - 1:0] sdata;
	reg [BITS - 1:0] readData;

	wire miso_oe;

	SPI_SLAVE #(.BITS(BITS)) DUT (
		.rst(rst),
		.sclk(sclk),
		.ss_n(ss_n),
		.mosi(mosi),
		.miso(miso),
		.miso_oe(miso_oe),
		.latch(latch),
		.inData(sdata),
		.outData()
	);

	initial begin
		$dumpfile("SPI/SPI_SLAVE.vcd");
		$dumpvars(0, DUT);

		rst = 1;
		sclk = 0;
		ss_n = 1;
		mosi = 0;
		latch = 0;
		readData = {BITS{1'b0}};

		sdata = 8'h65;
		mdata = DATA;

		#2
		rst = 0;

		// Load slave transmit shift register.
		#1
		latch = 1;
		#1
		latch = 0;

		// Start a transfer.
		#1
		ss_n = 0;

		// Run for BITS cycles (2 edges per bit).
		#40
		ss_n = 1;

		#20
		$finish;
	end

	always #1 sclk = ~sclk;

	// Mode 0 master behavior: change MOSI on falling, sample MISO on rising.
	always @ (negedge sclk) begin
		if (!ss_n) begin
			mosi <= mdata[BITS - 1];
			mdata[BITS - 1:1] <= mdata[BITS - 2:0];
		end
	end

	always @ (posedge sclk) begin
		if (!ss_n) begin
			readData[BITS - 1:1] <= readData[BITS - 2:0];
			readData[0] <= miso;
		end
	end

endmodule // SPI_SLAVE_tb

