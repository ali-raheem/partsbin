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

module mux_tb ();
   localparam BUS_WIDTH = 4;
   reg [BUS_WIDTH - 1:0] a;
   reg [BUS_WIDTH - 1:0] b;
   reg 	     switch;
   wire [BUS_WIDTH - 1:0] q;

   mux #(.BUS_WIDTH(BUS_WIDTH)) DUT(
	      .a(a),
	      .b(b),
	      .q(q),
	      .switch(switch)
	      );

   initial begin
      $dumpfile("MUX.vcd");
      $dumpvars(0, DUT);
      a = 1;
      b = 7;
      switch = 0;
      #15
	b = 3;
      #30
	a = 3;
      b = 5;
      #45
	a = 0;
      b = 1;
      $finish;
   end // initial begin

   always #5 switch = ~switch;

endmodule // mux_tb
