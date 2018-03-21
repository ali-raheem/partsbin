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

module ln4017_tb ();
   reg cp0;
   reg cp1;
   reg mr;
   wire [9:0] out;
   wire	     q59_b;

   ln4017 DUT(
	      .cp0(cp0),
	      .cp1(cp1),
	      .mr(mr),
	      .out_q(out),
	      .q59_b(q59_b)
	      );

   initial begin
      $dumpfile("4017_test.vcd");
      $dumpvars(0, ln4017_tb);
      mr = 1;
      cp0 = 0;
      cp1 = 0;
      #10
	mr = 0;
      #1000
	cp1 = 1;
      #1000
	$finish;
   end // initial begin

   always #5 cp0 = ~cp0;

endmodule // ln4017_tb
