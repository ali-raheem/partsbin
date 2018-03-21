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

module piso (clk, shld, q_n, q, ser, parin);
   parameter WIDTH = 8;
   input clk;
   input shld;
   input ser;
   input [WIDTH-1:0] parin;
   output q_n;
   output q;

   reg [WIDTH-1:0] data;
   
   always @ (posedge clk)
      if (shld) begin
	 data[WIDTH-2:0] <= data[WIDTH-1:1];
	 data[WIDTH-1] <= ser;
      end

   always @ (negedge shld) data <= parin;

   assign q = data[0];
   assign q_n = ~data[0];
endmodule // piso
