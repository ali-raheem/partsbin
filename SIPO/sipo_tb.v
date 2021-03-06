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

module sipo_tb ();
   reg clk;
   reg d;
   wire [15:0] out;
   reg rst;
   reg oe;
   reg ie;
   
   sipo #(.WIDTH(8)) DUT (
			  .clk(clk),
			  .d(d),
			  .q(out[7:0]),
			  .rst(rst),
			  .oe(oe),
			  .ie(ie)
			  );
   sipo #(.WIDTH(8)) DUT1 (
			   .clk(clk),
			   .d(out[7]),
			   .q(out[15:8]),
			   .rst(rst),
			   .oe(oe),
			   .ie(ie)
			   );
   always #5 clk = ~clk;

   initial begin
      $dumpfile("sipo_test.vcd");
      $dumpvars(0, sipo_tb);
      ie = 1;
      oe = 1;
      rst = 0;
      d = 0;
      clk = 0;
      #5
	rst = 1;
      #5
	rst = 0;
      #5
	oe = 1;
      #5
      d = 1;
      #25
	d = 0;
      #15
	d = 1;
      #50
	oe = 0;
      #10
	ie = 0;
      #5
	rst =1;
      #5
	rst = 0;
      #5
	oe = 1;
      #5
	ie = 1;
      #5
	rst = 1;
      #15
      $finish;
   end // initial begin

   always #5 clk = ~clk;
endmodule // sipo_tb
