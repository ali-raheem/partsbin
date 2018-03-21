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

module ln4017 (cp0, cp1, mr, out_q, q59_n);
   input cp0;
   input cp1;
   input mr;
   output [9:0] out_q;
   reg [9:0] 	    out_d;
   output 	    q59_n;
   
   always @ (posedge mr)
     out_d <= 10'b1;

   always @ (posedge cp0) begin
     if (~cp1) begin
	out_d[9:1] <= out_d[8:0];
	out_d[0] <= out_d[9];
     end
   end

   always@(negedge cp0) begin
      if (cp1) begin
	out_d[9:1] <= out_d[8:0];
	out_d[0] <= out_d[9];
     end
   end	 

   assign q59_n = ~|out_d[9:5];
   assign out_q = out_d;
endmodule // 4017
