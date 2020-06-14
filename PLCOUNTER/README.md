# Parallel Load Binary Counter

Binary counter that can be loaded

* clk - Input clk
* rst - Synchronous Reset
* updown - Active High Count Up signal
* in - Binary input
* out - Binary output

### Waveform

Notice each out pin will be at half the frequency of the previous pin halving the clock speed with a 50% duty cycle.

![Counting up and then down](waveform.png)