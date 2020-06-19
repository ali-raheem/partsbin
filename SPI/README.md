# Serial Peripheral Interface - Untested

Untested SPI, uses double edge clocking. Very much a work in progress to simplify requirements.

## Master

### Pins

- MISO	input	Master in Slave out
- MOSI	output	Master out Slave in
- SS	output	slave select
- SCLK	output	slave clock

## Slave

### Pins

- SS	input	slave select
- SCLK	input	slave clock
- MOSI	input	Master out Slave in
- MISO	output	Master in Slave out