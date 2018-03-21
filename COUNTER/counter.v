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

module counter (clk, rst, updown, out);
   parameter WIDTH = 8;
   input clk;
   input rst;
   input updown;
   output reg [WIDTH-1:0] out;

   always@(posedge clk) begin
      if (rst)
	out <= 0;
      else begin
	 if (updown)
	   out <= out + 1;
	 else
	   out <= out - 1;
      end
   end

endmodule // counter

   
   
