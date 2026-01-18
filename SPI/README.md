# Serial Peripheral Interface (SPI)

This is a small, minimal SPI implementation.

- SPI mode: 0 (CPOL=0, CPHA=0)
- Bit order: MSB-first
- Master clocking: `clk` is treated as a half-SCLK tick (SCLK toggles every posedge `clk`)

## Master (`SPI/SPI_MASTER.v`)

### Pins

- `clk` input Half-SCLK tick
- `rst` input Synchronous reset
- `sclk` output SPI clock
- `mosi` output Master out, slave in
- `miso` input Master in, slave out
- `ss_n` output Active-low slave select
- `data_in` input `[BITS-1:0]` byte/word to transmit
- `data_out` output `[BITS-1:0]` captured MISO data
- `data_ready` input Assert to start a transfer
- `data_sent` output Goes high once a transfer completes

## Slave (`SPI/SPI_SLAVE.v`)

### Pins

- `rst` input Reset
- `ss_n` input Active-low select
- `sclk` input SPI clock
- `mosi` input Master out, slave in
- `miso` output Master in, slave out (always driven)
- `miso_oe` output Output-enable for `miso` (use at top-level IO)
- `inData` input `[BITS-1:0]` data to transmit
- `latch` input Latch `inData` into the transmit shift register
- `outData` output `[BITS-1:0]` received MOSI data (latched when `ss_n` deasserts)

## Loopback

- `SPI/SPI_LOOPBACK_TOP.v` wires `SPI_MASTER` <-> `SPI_SLAVE`
- `SPI/SPI_LOOPBACK_tb.v` simulates a single transfer and writes `SPI/SPI_LOOPBACK.vcd`

### Simulation

Run from repo root:

```sh
iverilog -g2012 -Wall -o /tmp/spi_loopback.out \
  SPI/SPI_MASTER.v SPI/SPI_SLAVE.v SPI/SPI_LOOPBACK_TOP.v SPI/SPI_LOOPBACK_tb.v
vvp /tmp/spi_loopback.out

gtkwave SPI/SPI_LOOPBACK.vcd
```
