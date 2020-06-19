/*
   Copyright 2020 Ali Raheem <ali.raheem@gmail.com>
 
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module UART_TX(clk, rst, data, data_ready, data_sent, tx);
   parameter BITS = 8;
   parameter STOPBITS = 1;
   parameter PARITY = 0;
   
   localparam BITLEN = 16;

   localparam STATE_WAIT = 1;
   localparam STATE_START = 2;
   localparam STATE_SEND = 4;
   localparam STATE_PARITY = 8;
   localparam STATE_STOP = 16;
   localparam NUM_STATES = 5;

   input 	      clk;
   input [BITS - 1:0] data;
   input 	      data_ready;
   input 	      rst;
   output reg 	      data_sent; 	      
   output reg	      tx;

   reg [BITS - 1:0]   send_data;
   reg [NUM_STATES - 1:0] STATE;
   reg [$clog2(BITS + 1) - 1:0]        bits_sent;   
   reg [$clog2(BITLEN * STOPBITS + 1) - 1:0] 	  counter;
   
   always @ (posedge clk) begin
      if (rst) begin
	 STATE <= STATE_WAIT;
	 bits_sent <= 0;
	 send_data <= 0;
	 counter <= 0;
	 data_sent <= 0;
      end
      else begin
	 case (STATE)
	   STATE_WAIT: begin
	     if (data_ready) begin
		STATE <= STATE_START;
		data_sent <= 0;
		send_data <= data;
		counter <= 0;
	     end
	   end
	   STATE_START: begin
	      tx <= 0;
	      counter <= counter + 1;
	      if (counter == BITLEN - 1) begin
		 counter <= 0;
		 STATE <= STATE_SEND;
		 bits_sent <= 0;
	      end
	   end
	   STATE_SEND: begin
	      counter <= counter + 1;
	      tx <= send_data[bits_sent];
	      if (counter == BITLEN - 1) begin
		 counter <= 0;
		 bits_sent <= bits_sent + 1;
		 if (bits_sent == BITS - 1) begin
		    bits_sent <= 0;
		    STATE <= (PARITY == 0) ? STATE_STOP : STATE_PARITY;
		 end
//		 else
//		   send_data[BITS - 2:0] <= send_data[BITS - 1: 1];
	      end
	   end // case: STATE_SEND
	   STATE_PARITY: begin
	      counter <= counter + 1;
	      tx <= (PARITY == 1)? ~^send_data : ^send_data;
	      if (counter == BITLEN - 1) begin
		 counter <= 0;
		 STATE <= STATE_STOP;
	      end
	   end
	   STATE_STOP: begin
	      counter <= counter + 1;
	      tx <= 1;
	      if (counter == (BITLEN - 1) * STOPBITS) begin
		 STATE <= STATE_WAIT;
		 tx <= 1'bZ;
		 data_sent <= 1;
	      end
	   end
	 endcase // case (STATE)
      end // else: !if(rst)
   end // always @ (posedge clk)

endmodule // UART_TX

