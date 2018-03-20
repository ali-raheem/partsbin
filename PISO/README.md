# Parallel-In Shift Out Register

Classic PISO.

* clk - The shift out clocking
* latch - LOAD_SHIFT when in posedge will load parallel data into register, inhibits shifting when high.
* rst - reset asynchronous
* ser - Serial in, replaces high bit as shifted.
* din - Parallel in
* dout - Serial out
