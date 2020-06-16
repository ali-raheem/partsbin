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

module UART_RX_tb();
   localparam BITS = 8;

   reg clk;
   reg rst;
   reg tx;
   wire [BITS-1:0] data;
   
   reg [BITS - 1:0] test_data = 8'b01011100;
   
   UART_RX #(.BITS(BITS))
   DUT(
       .clk(clk),
       .rst(rst),
       .rx(tx),
       .data(data)
       );

   always #1 clk = !clk;
   
   initial begin
      $dumpfile("UART_RX.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      rst = 1;
      tx = 1;
      #2
	rst = 0;
      #1
	tx = 0;
      #16
	tx = test_data[7]; 
      #16
	tx = test_data[6];
      #16
	tx = test_data[5];
      #16
	tx = test_data[4];
      #16
	tx = test_data[3]; 
      #16
	tx = test_data[2];
      #16
	tx = test_data[1];
      #16
	tx = test_data[0];
      #16
	tx = 1;
      #32
      $finish;   
   end // initial begin   

   
endmodule // UART_RX_tb


