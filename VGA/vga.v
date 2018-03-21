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
   input clk;
   input rst;
   output vs;
   output hs;
   output wire draw;
   output reg [9:0] x;
   output reg [8:0] y;

   always @ (posedge clk) begin
      if (rst) begin
	 x <= 0;
	 y <= 0;
      end
      else begin
	 if (x == 799) begin
	    x <= 0;
	    if (y == 524)
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
   assign vs = ~((y >= 490) && (y < 492)); 
endmodule // vgs

 
