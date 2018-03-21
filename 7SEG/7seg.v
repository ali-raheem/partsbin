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
