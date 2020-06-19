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

module UART_RX (clk, rst, rx, data, data_ready);
   parameter BITS = 8;
   parameter STOPBITS = 1;
   parameter PARITY = 0;
   
   localparam BITLEN = 16;
   localparam NUM_STATES = 5; 
   localparam STATE_WAIT = 1;
   localparam STATE_START = 2;
   localparam STATE_READING = 4;
   localparam STATE_PARITY = 8;
   localparam STATE_STOP = 16;
			  
   input clk;
   input rx;
   input rst;
   
   output [BITS - 1:0] data;
   output reg 	       data_ready;
   
   reg [$clog2(BITS + 1) - 1:0] bitsread;
   reg [BITS - 1:0] 		outputbuffer;    
   reg [BITS - 1:0] 		readbuffer;
   reg [$clog2(BITLEN * STOPBITS + 1) - 1:0] counter;
   
   reg [NUM_STATES - 1:0] STATE;
   
   always @ (posedge clk) begin
      if (rst) begin
	 STATE <= STATE_WAIT;
	 counter <= 0;
	 outputbuffer <= 0;
	 bitsread <= 0;
	 readbuffer <= 0;
      end
      else begin
	 case (STATE)
	   STATE_WAIT: begin
	      if (!rx) begin
		 STATE <= STATE_START;
		 counter <= 0;
	      end
	   end
	   
	   STATE_START: begin
	      data_ready <= 0;
	      counter <= counter + 1;
	      if (counter == BITLEN/2 - 2) begin
		 STATE <= STATE_READING;
		 counter <= 0;
	      end
	      else if (rx) // Spurious pulse
		STATE <= STATE_WAIT;
	   end
	   
	   STATE_READING: begin
	      counter <= counter + 1;
	      if (counter == BITLEN - 1) begin
		 readbuffer[BITS - 2:0]  <= readbuffer[BITS - 1:1];
		 readbuffer[BITS - 1] <= rx;
		 counter <= 0;
		 bitsread <= bitsread + 1;
		 if (bitsread == BITS - 1) begin
		    STATE <= (PARITY == 0)? STATE_STOP : STATE_PARITY;
		    counter <= 0;
		 end
	      end
	   end // case: STATE_READING
	   STATE_PARITY: begin
	      counter <= counter + 1;
	      if (counter == BITLEN - 1) begin
		 if (rx == ((PARITY == 1)? ~^readbuffer : ^readbuffer)) begin
		    STATE <= STATE_STOP;
		    counter <= 0;
		 end
		 else // Parity Fail
		   STATE <= STATE_WAIT;
	      end
	   end
	   STATE_STOP: begin
	      counter <= counter + 1;
	      if (counter == (BITLEN - 1) * STOPBITS) begin
		 STATE <= STATE_WAIT;
		 counter <= 0;
		 bitsread <= 0;
		 readbuffer <= 0;
		 if (rx) begin // STOPBIT pass
		    outputbuffer <= readbuffer;
		    data_ready <= 1;
		 end
	      end
	   end
	 endcase // case (STATE)
      end // else: !if(rst)
   end // always @ (posedge clk)
   
   assign data = outputbuffer;
endmodule // UART_RX

   
