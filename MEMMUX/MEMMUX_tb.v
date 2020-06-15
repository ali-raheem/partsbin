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

module memmux_tb();
   localparam ADDR_WIDTH = 8;
   localparam DATA_WIDTH = 8;
   reg switch;
   reg [ADDR_WIDTH - 1:0] mADDR_M;
   reg [DATA_WIDTH - 1:0] mDATA_M;
   reg [ADDR_WIDTH - 1:0] mADDR_V;
   wire [DATA_WIDTH - 1:0] mDATA_V;

   wire [ADDR_WIDTH - 1:0] sADDR_A;
   wire [ADDR_WIDTH - 1:0] sADDR_B;
   
   wire [DATA_WIDTH - 1:0]  sDATA_A;
   wire [DATA_WIDTH - 1:0]  sDATA_B;

   reg 	[DATA_WIDTH - 1:0]  oDATA_A;
   reg 	[DATA_WIDTH - 1:0]  oDATA_B;
   
   memmux #(.ADDR_WIDTH(ADDR_WIDTH),
	    .DATA_WIDTH(DATA_WIDTH))
   DUT(
       .switch(switch),
       .mADDR_M(mADDR_M),
       .mDATA_M(mDATA_M),
       .mADDR_V(mADDR_V),
       .mDATA_V(mDATA_V),
       .sADDR_A(sADDR_A),
       .sDATA_A(sDATA_A),
       .sADDR_B(sADDR_B),
       .sDATA_B(sDATA_B)
       );
   
   initial begin
      $dumpfile("MEMMUX.vcd");
      $dumpvars(0, DUT);
      switch = 0;
      mADDR_M = 0;
      mDATA_M = 0;
      mADDR_V = 0;
      oDATA_A = 0;
      oDATA_B = 0;
      #1
      mADDR_M = {ADDR_WIDTH{1'b1}};
      mDATA_M = {DATA_WIDTH/4{4'b1010}};
      mADDR_V = {ADDR_WIDTH/2{2'b10}};
      oDATA_A = {DATA_WIDTH/2{2'b10}};
      oDATA_B = {DATA_WIDTH/2{2'b01}};
      #10
        switch = 1;
        oDATA_B = {DATA_WIDTH/2{2'b10}};
        oDATA_A = {DATA_WIDTH/2{2'b01}};
      #10
	mADDR_M = 0;
      mADDR_V = 0;
      #10
	switch = 0;
      #10
      $finish;   
   end // initial begin   

   assign sDATA_A = switch ? oDATA_A : {DATA_WIDTH{1'bZ}};
   assign sDATA_B = !switch ? oDATA_B : {DATA_WIDTH{1'bZ}};

   always #1 mADDR_M = mADDR_M + 1;
   always #1 mADDR_V = mADDR_V + 1;
   always #2 switch = !switch;

endmodule // memmux_tb
