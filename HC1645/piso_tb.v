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

/// THIS IS OLD

module piso_tb ();
   localparam WIDTH = 16;
   reg clk;
   reg shld;
   reg ser;
   reg [WIDTH-1:0] parin;
   wire 		   q_n;
   wire 		   q;

   piso #(.WIDTH(WIDTH)) DUT (
			  .clk(clk),
			  .shld(shld),
			  .ser(q),
			  .parin(parin),
			  .q(q),
			  .q_n(q_n)
			  );
   initial begin
      $dumpfile("piso.vcd");
      $dumpvars(0, piso_tb);
      clk = 0;
      shld = 1;
      ser = 0;
      parin = 16'h15AF;
      #1
	shld = 0;
      #5
	shld = 1;
      #1000
	$finish;
   end // initial begin

   always #5 clk = ~clk;
   
endmodule // piso_tb

   
