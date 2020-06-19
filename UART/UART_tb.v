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

module UART_tb();
   // 8E1
   localparam BITS = 8; // 8 bits
   localparam STOPBITS = 1; // One Stop bit
   localparam PARITY = 2; // Even parity
   localparam DUMMYDATA_A = 8'b01010101;
   localparam DUMMYDATA_B = 8'b11001100;
   
   reg clk;
   reg rst;
   reg data_ready;

   
   wire rxtx;
   wire data_sent;
   wire rx_data_ready;
   
   reg [BITS - 1:0] txdata;
   wire [BITS - 1:0] rxdata;
   
   UART_TX #(.BITS(BITS),
	     .STOPBITS(STOPBITS),
	     .PARITY(PARITY))
   TX(
      .clk(clk),
      .rst(rst),
      .tx(rxtx),
      .data_ready(data_ready),
      .data(txdata),
      .data_sent(data_sent)
      );

   UART_RX #(.BITS(BITS),
	     .STOPBITS(STOPBITS),
	     .PARITY(PARITY))
   RX(
      .clk(clk),
      .rst(rst),
      .rx(rxtx),
      .data(rxdata),
      .data_ready(rx_data_ready)
      );

   always #1 clk = !clk;
   
   initial begin
      $dumpfile("UART.vcd");
      $dumpvars(0, TX);
      $dumpvars(0, RX);
      clk = 0;
      rst = 1;
      txdata = DUMMYDATA_A;
      #2
	rst = 0;
      #8
	data_ready = 1;
      #16
	data_ready = 0;
      #400
	txdata = DUMMYDATA_B;
        data_ready = 1;
      #16
	data_ready = 0;
      #400
      $finish;   
   end // initial begin   

endmodule // UART_tb




