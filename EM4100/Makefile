EM4100: EM4100.v EM4100_tb.v
	iverilog -Wall -o EM4100 EM4100.v EM4100_tb.v

clean:
	rm EM4100 *~

lint:
	verilator --lint-only EM4100.v EM4100_tb.v
