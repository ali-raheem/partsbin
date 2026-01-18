module SPI_MASTER #(
	parameter BITS = 8
) (
	input clk,
	input rst,
	output reg sclk,
	output reg mosi,
	output reg ss_n,
	input miso,
	output reg data_sent,
	input data_ready,
	input [BITS - 1:0] data_in,
	output reg [BITS - 1:0] data_out
);

	// SPI mode 0: CPOL=0, CPHA=0, MSB-first.
	// `clk` is treated as a half-SCLK tick: SCLK toggles every posedge clk.
	localparam NUM_STATES = 3;
	localparam STATE_WAIT = 1;
	localparam STATE_XFER = 2;
	localparam STATE_DONE = 4;

	reg [NUM_STATES - 1:0] STATE;
	reg [$clog2(BITS + 1) - 1:0] bits_done;
	reg [BITS - 1:0] tx_shift;
	reg [BITS - 1:0] rx_shift;

	always @ (posedge clk) begin
		if (rst) begin
			STATE <= STATE_WAIT;
			sclk <= 0;
			mosi <= 0;
			ss_n <= 1;
			data_sent <= 0;
			bits_done <= 0;
			tx_shift <= 0;
			rx_shift <= 0;
			data_out <= 0;
		end
		else begin
			case (STATE)
				STATE_WAIT: begin
					sclk <= 0;
					ss_n <= 1;
					mosi <= 0;
					data_sent <= 0;
					bits_done <= 0;
					if (data_ready) begin
						ss_n <= 0;
						tx_shift <= data_in;
						rx_shift <= 0;
						mosi <= data_in[BITS - 1];
						STATE <= STATE_XFER;
					end
				end

				STATE_XFER: begin
					sclk <= ~sclk;
					if (!sclk) begin
						// Rising edge: sample MISO.
						rx_shift <= {rx_shift[BITS - 2:0], miso};
						if (bits_done == BITS - 1) begin
							STATE <= STATE_DONE;
							data_out <= {rx_shift[BITS - 2:0], miso};
						end
						bits_done <= bits_done + 1;
					end
					else begin
						// Falling edge: change MOSI.
						tx_shift <= {tx_shift[BITS - 2:0], 1'b0};
						mosi <= (BITS > 1) ? tx_shift[BITS - 2] : 1'b0;
					end
				end

				STATE_DONE: begin
					sclk <= 0;
					ss_n <= 1;
					mosi <= 0;
					data_sent <= 1;
					if (!data_ready)
						STATE <= STATE_WAIT;
				end
			endcase
		end
	end

endmodule // SPI_MASTER

