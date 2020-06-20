module SPI_MASTER(
		  input 	     clk, 
		  output reg 	     sclk,
		  output reg 	     mosi,
		  output 	     ss_n,
		  input 	     miso,
		  output reg 	     data_sent, 
		  input 	     data_ready,
		  inout [BITS - 1:0] data);
   
   parameter BITS = 8;
   
   reg [$clog2(16 + 1) - 1: 0] 	     counter;
   reg 				     inBit;
   reg [BITS - 1:0] 		     buffer;
   reg [NUM_STATES - 1:0] 	     STATE;
   localparam NUM_STATES = 3;
   localparam STATE_WAIT = 1;
   localparam STATE_SEND = 2;
   localparam STATE_DONE = 4;
   
   always @ (posedge clk) begin
      case (STATE)
	STATE_WAIT:
	  if (data_ready) begin
	     data_sent <= 0;
	     buffer <= data;
	     STATE <= STATE_SEND;
	     counter <= 0;
	  end
	STATE_SEND: begin
	   counter <= counter + 1;
	   sclk <= !sclk;
	   if (sclk) begin //negedge
	      mosi <= buffer[BITS - 1];
	      buffer[BITS - 1:1] <= buffer[BITS - 2:0];
	      buffer[0] <= inBit;
	   end else inBit <= miso; //posedge
	   if (counter == 16) begin
	      STATE <= STATE_DONE;
	      counter <= 0;
	   end
	end // case: STATE_SEND
	STATE_DONE: begin
	   data_sent <= 1;
	   STATE <= STATE_DONE;
	end
      endcase // case (STATE)	     
   end // always @ (posedge clk)
   
   assign data = (data_ready)? buffer : {BITS{1'bZ}};

endmodule // SPI_MASTER
