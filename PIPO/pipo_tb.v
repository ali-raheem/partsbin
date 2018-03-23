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

module pipo_tb ();
   localparam WIDTH = 8;
   reg oe_n;
   reg le;
   reg [WIDTH-1:0] data;
   wire [WIDTH-1:0] out;

   pipo #(.WIDTH(WIDTH)) DUT(
				.oe_n(oe_n),
				.le(le),
				.in(data),
				.out(out)
				);
   
   initial begin
      $dumpfile("pipo.vcd");
      $dumpvars(0, DUT);
      oe_n = 1;
      data = 0;
      le = 0;
      #1
	le = 1;
      #1
	le = 0;
      #1
	data = 8'h55;
      le = 1;
      oe_n = 0;
      #1
	le = 0;
      #1
	data = 0;
      #10
	data = 8'hAA;
      le = 0;
      #2
	le = 1;
      #5
	oe_n = 1;
      #100
	$finish;
   end // initial begin

endmodule // pipo_tb

   
