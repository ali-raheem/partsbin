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

module vga (clk, rst, hs, vs, draw, x, y);
   localparam width = 800;
   localparam height = 525;
   
   input clk;
   input rst;
   output vs;
   output hs;
   output wire draw;
   output reg [$clog2(width + 1) - 1:0] x;
   output reg [$clog2(height + 1) - 1:0] y;

   always @ (posedge clk, posedge rst) begin
      if (rst) begin
	 x <= 0;
	 y <= 0;
      end
      else begin
	 if (x == width - 1) begin
	    x <= 0;
	    if (y == height - 1)
	      y <= 0;
	    else
	      y <= y + 1;
	 end
	 else
	   x <= x + 1;
      end
   end

   assign draw = (x < 640) && (y < 480);
   assign hs = ~((x >= 656) && (x < 752));
   assign vs = ~((y == 490) || (y == 491)); 
endmodule // vgs

 
