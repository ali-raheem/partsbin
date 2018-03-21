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

`timescale 1ns / 1ps
module pwm_tb();
   localparam WIDTH = 8;
   reg clk;
   reg rst;
   reg [WIDTH-1:0] in;
   wire      out;

   pwm #(.WIDTH(WIDTH)) DUT(
			.clk(clk),
			.rst(rst),
			.in(in),
			.out(out)
			);
   initial begin
      $dumpfile("pwm_test.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      in = 0;
      rst = 1;
      #10
	rst = 0;
      #50000
	$finish;
      
   end

   always #1 clk = ~clk;
   always #1000 in = in + 1;
endmodule // pwm_tb
