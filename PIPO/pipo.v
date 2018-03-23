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

module pipo (oe_n, le, in, out);
   parameter WIDTH = 8;
   input oe_n;
   input le;
   input [WIDTH-1:0] in;
   output [WIDTH-1:0] out;

   reg [WIDTH-1:0]    data;
   wire [WIDTH-1:0]   mux;
   
   assign mux = (le)? in : data;
   assign out = (~oe_n)? mux : {WIDTH {{1'bZ}}};
   
   always@(negedge le)
     data <= in;

endmodule // pipo
