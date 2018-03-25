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

module comp_tb ();
   localparam WIDTH = 4;
   reg [WIDTH-1:0] a;
   reg [WIDTH-1:0] b;
   wire 	   gt;
   wire 	   eq;
   wire 	   lt;

   comp #(.WIDTH(WIDTH)) DUT (
			      .a(a),
			      .b(b),
			      .gt(gt),
			      .eq(eq),
			      .lt(lt)
			      );

   initial begin
      $dumpfile("comp.vcd");
      $dumpvars(0, DUT);
      a = 4'b1010;
      b = 4'b1111;
      #1
	b = a;
      #1
	b = 4'b0000;
      #1
	$finish;
   end // initial begin
   
endmodule // comp_tb

