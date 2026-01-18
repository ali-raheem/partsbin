module SPI_SLAVE #(
	parameter BITS = 8
) (
	input rst,
	input ss_n,
	input sclk,
	input mosi,
	output miso,
	output miso_oe,
	input [BITS - 1:0] inData,
	input latch,
	output reg [BITS - 1:0] outData
);

	// SPI mode 0: CPOL=0, CPHA=0, MSB-first.
	// - Master changes MOSI on falling edges and samples on rising edges.
	// - Slave samples MOSI on rising edges and updates MISO on falling edges.
	//
	// Synthesizability note:
	// - No internal tri-states. Use `miso_oe` to drive an IO pad if needed.
	// - Uses multiple clock domains (`sclk`, `latch`, `ss_n`). Treat `ss_n` and
	//   `latch` as asynchronous controls relative to `sclk`.

	reg [BITS - 1:0] tx_latched;
	reg [BITS - 1:0] tx_shift;
	reg [BITS - 1:0] rx_shift;
	reg [$clog2(BITS + 1) - 1:0] bit_count;

	wire arst_n;
	assign arst_n = ss_n & ~rst;

	always @ (posedge latch or posedge rst) begin
		if (rst)
			tx_latched <= 0;
		else
			tx_latched <= inData;
	end

	// Shift out on falling edges. Transfer starts when ss_n asserts low.
	always @ (negedge sclk or negedge arst_n) begin
		if (!arst_n) begin
			bit_count <= 0;
			tx_shift <= 0;
		end
		else begin
			if (bit_count == 0) begin
				// First bit is driven from tx_latched[MSB]. Preload remaining bits.
				tx_shift <= {tx_latched[BITS - 2:0], 1'b0};
				bit_count <= 1;
			end
			else begin
				tx_shift <= {tx_shift[BITS - 2:0], 1'b0};
				if (bit_count != BITS)
					bit_count <= bit_count + 1;
			end
		end
	end

	// Shift in on rising edges. Clear when ss_n asserts low.
	always @ (posedge sclk or negedge arst_n) begin
		if (!arst_n)
			rx_shift <= 0;
		else
			rx_shift <= {rx_shift[BITS - 2:0], mosi};
	end

	// Latch received data when ss_n deasserts.
	always @ (posedge ss_n or posedge rst) begin
		if (rst)
			outData <= 0;
		else
			outData <= rx_shift;
	end

	assign miso = (bit_count == 0) ? tx_latched[BITS - 1] : tx_shift[BITS - 1];
	assign miso_oe = ~ss_n;

endmodule // SPI_SLAVE

