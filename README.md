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