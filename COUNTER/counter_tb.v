/*
   Copyright 2018 Ali Raheem <ali.raheem@gmail.com>
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module counter_tb ();
   localparam WIDTH = 8;
   reg clk;
   reg updown;
   reg rst;
   wire [WIDTH-1:0] out;

   counter #(.WIDTH(WIDTH)) DUT(
	       .clk(clk),
	       .updown(updown),
	       .rst(rst),
	       .out(out)
	       );

   initial begin
      $dumpfile("counter.vcd");
      $dumpvars(0, counter_tb);
      clk = 0;
      updown = 1;
      rst = 0;
      #1
	rst = 1;
      #1
	clk = 1;
      #1
	rst = 0;
      clk = 0;
      #100
	updown = 0;
      #150
	$finish;
   end // initial begin

   always #1 clk = ~clk;
endmodule // counter_tb
