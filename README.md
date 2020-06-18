# Parts bin

Random chunks of Verilog I occasionally use. Cleaning up code and adding it as I do so.

It's all been used in projects so should work. Some of it has been simulated too. Some even has testbenches.

### Usage

I use [Icarus Verilog](http://iverilog.icarus.com/) to compile and run this code and then view them in [GTKWave](http://gtkwave.sourceforge.net/).

```
$ iverilog -Wall *.v
$ vvp a.out
$ gtkwave *.vcd
```

### License

Released under Apache 2.0, I am doing my best to add invidual notices to each file but otherwise you may assume Apache 2.0 applies to all files in this repository.

### Parts

```
partsbin
├── 4017		Onehot decade counter
├── 7SEG		7segment display driver
├── COUNTER
├── digital_comparitor
├── EM4100		RFID modulator (manchest encoding) 125Khz
├── HC1645		
├── LFSR		Linear Feedback Shift Register
├── MEMMUX		Multibus MUX (for VRAM flipping)
├── MUX			Multiplexer
├── PIPO
├── PISO
├── PLCOUNTER
├── PWM			Pulse width modulator
├── SIPO
├── UART		Universe Asynchronous Reciever/Transmitter
└── VGA			VGA graphics driver

16 directories
```