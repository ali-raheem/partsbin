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
module EM4100_tb();
   reg clk;
   reg tx;
   reg [39:0] data;
   wire       q;

   EM4100 DUT(
	      .clk(clk),
	      .tx(tx),
	      .data(data),
	      .q(q));

   initial begin
      $dumpfile("EM4100.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      tx = 0;
      data = {{20{1'b1}}, {20{1'b0}}};
      #4
      tx = 1;
      #1000
      $finish;
   end // initial begin

   always #1 clk = !clk;
endmodule // EM4100_tb
