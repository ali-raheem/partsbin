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

module LFSR (
	input clk, 
	input rst, 
	output q);
   // x^16 + x^14 + x^13 + x^11 + 1
	
   reg [15:0] sr;
   
   always @ (posedge clk) begin
      if (rst)
	 sr <= 1;
      else begin
	 sr[0] <= sr[15] ^ sr[13] ^ sr[12] ^ sr[10];
	 sr[15:1] <= sr[14:0];
      end
   end
   
   assign q = sr[15];
  
endmodule // LFSR
