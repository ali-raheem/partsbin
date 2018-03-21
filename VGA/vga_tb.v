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

module vga_tb ();
   reg clk;
   reg rst;
   wire draw;
   wire hs;
   wire vs;
   wire [9:0] x;
   wire [8:0] y;

   vga DUT (
	    .clk(clk),
	    .rst(rst),
	    .draw(draw),
	    .hs(hs),
	    .vs(vs),
	    .x(x),
	    .y(y)
	    );

   initial begin
      $dumpfile("vga.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      rst = 1;
      #2
	rst = 0;
      #2000000
	$finish;
   end
   always #1
     clk = ~clk;

endmodule // vga_tb
