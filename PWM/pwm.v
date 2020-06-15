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

module pwm (clk, rst, in, out);
   parameter WIDTH = 8;
   input clk;
   input rst;
   input [WIDTH-1:0] in;
   output 	     out;
   reg [WIDTH-1:0]   counter;
   reg [WIDTH-1:0]   in_d;
   
   always @ (posedge clk) begin
      in_d <= in;
      if (rst)
	counter <= {WIDTH{1'b0}};
      else
	 counter <= counter + 1'b1;
   end
   
   assign out = (in_d[WIDTH-1:0] > counter[WIDTH-1:0]);
   
endmodule // pwm
