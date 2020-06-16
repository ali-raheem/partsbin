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

module UART_TX_tb();
   localparam BITS = 8;

   reg clk;
   reg rst;
   reg data_ready;
   
   wire rx;
   wire data_sent;
   
   reg [BITS - 1:0] data = 8'b01011100;
   
   UART_TX #(.BITS(BITS))
   DUT(
       .clk(clk),
       .rst(rst),
       .tx(rx),
       .data_ready(data_ready),
       .data(data),
       .data_sent(data_sent)
       );

   always #1 clk = !clk;
   
   initial begin
      $dumpfile("UART_TX.vcd");
      $dumpvars(0, DUT);
      clk = 0;
      rst = 1;
      #2
	rst = 0;
      #1
	data_ready = 1;
      #2000
      $finish;   
   end // initial begin   

   
endmodule // UART_TX_tb


