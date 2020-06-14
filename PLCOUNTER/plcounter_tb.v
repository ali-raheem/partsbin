/*
   Copyright 2020 Ali Raheem <ali.raheem@gmail.com>
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module plcounter_tb ();
   localparam WIDTH = 8;
   reg clk;
   reg updown;
   reg rst;
   reg [WIDTH-1:0] in;
   wire [WIDTH-1:0] out;

   plcounter #(.WIDTH(WIDTH)) DUT(
	       .clk(clk),
	       .updown(updown),
	       .in(in),
	       .rst(rst),
	       .out(out)
	       );

   initial begin
      $dumpfile("plcounter.vcd");
      $dumpvars(0, plcounter_tb);
      clk = 0;
      in = 0;
      updown = 0;
      rst = 0;
      #1
	rst = 1;
      #3
	rst = 0;
      #100
	in = 127;
      clk = 0;
      updown = 1;
      #3
	rst = 1;
      #3
	rst = 0;
      #100
	$finish;
   end // initial begin

   always #1 clk = ~clk;
   always #5 in = in + 3;
endmodule // counter_tb
