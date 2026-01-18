module SPI_LOOPBACK_TOP #(
	parameter BITS = 8
) (
	input clk,
	input rst,

	input start,
	input slave_latch,

	input [BITS - 1:0] master_data_in,
	input [BITS - 1:0] slave_data_in,

	output [BITS - 1:0] master_data_out,
	output [BITS - 1:0] slave_data_out,
	output done,

	output sclk,
	output mosi,
	output ss_n,
	output miso
);

	SPI_MASTER #(.BITS(BITS)) master (
		.clk(clk),
		.rst(rst),
		.sclk(sclk),
		.mosi(mosi),
		.ss_n(ss_n),
		.miso(miso),
		.data_sent(done),
		.data_ready(start),
		.data_in(master_data_in),
		.data_out(master_data_out)
	);

	wire miso_oe;

	SPI_SLAVE #(.BITS(BITS)) slave (
		.rst(rst),
		.ss_n(ss_n),
		.sclk(sclk),
		.mosi(mosi),
		.miso(miso),
		.miso_oe(miso_oe),
		.inData(slave_data_in),
		.latch(slave_latch),
		.outData(slave_data_out)
	);

endmodule // SPI_LOOPBACK_TOP
