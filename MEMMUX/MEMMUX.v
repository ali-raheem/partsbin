/*
   Copyright 2020, 2025 Ali Raheem <github@shoryuken.me>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module memmux(switch, mADDR_M, mDATA_M, mADDR_V, mDATA_V, sADDR_A, sDATA_A, sADDR_B, sDATA_B);
   parameter ADDR_WIDTH = 8;
   parameter DATA_WIDTH = 8;

   // Master port
   input switch;
   input [ADDR_WIDTH - 1:0]  mADDR_M;
   input [DATA_WIDTH - 1:0]  mDATA_M;
   input [ADDR_WIDTH - 1:0]  mADDR_V;
   output [DATA_WIDTH - 1:0] mDATA_V;

   // Slave port
   output [ADDR_WIDTH - 1:0] sADDR_A;
   inout [DATA_WIDTH - 1:0]  sDATA_A;
   output [ADDR_WIDTH - 1:0] sADDR_B;
   inout [DATA_WIDTH - 1:0]  sDATA_B;
   
   assign mDATA_V = switch ? sDATA_B : sDATA_A;

   assign sDATA_A = switch ? {DATA_WIDTH{1'bZ}} : mDATA_M;
   assign sDATA_B = switch ? mDATA_M : {DATA_WIDTH{1'bZ}};
   assign sADDR_A = switch ? mADDR_V : mADDR_M;
   assign sADDR_B = switch ? mADDR_M : mADDR_V;


endmodule // memmux
