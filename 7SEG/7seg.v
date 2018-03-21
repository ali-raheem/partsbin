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

module sseg (in, out_q, oe);
   input [3:0] in;
   input       oe;
   output wire [6:0] out_q;
   reg [6:0] 	     out_d;
   
   //  --a--
   // |     |
   // f     b
   // |--g--|
   // e     c
   // |     |
   //  --d--
   // g = bit 6, a = bit 0;

   always @ (in) begin
     case (in)
       0: out_d = 7'b0111111;
       1: out_d = 7'b0000110;
       2: out_d = 7'b1011011;
       3: out_d = 7'b1001111;
       4: out_d = 7'b1100110;
       5: out_d = 7'b1101101;
       6: out_d = 7'b1111101;
       7: out_d = 7'b0000111;
       8: out_d = 7'b1111111;
       9: out_d = 7'b1101111;
       10: out_d = 7'b1110111;
       11: out_d = 7'b1111100;
       12: out_d = 7'b0111001;
       13: out_d = 7'b1011110;
       14: out_d = 7'b1111011;
       15: out_d = 7'b1110001;
     endcase // case (sel)
   end // always @ (in)

   assign out_q = oe? out_d : 7'bZZZZZZZ;
endmodule // sseg
