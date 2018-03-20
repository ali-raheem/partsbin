module ln4017 (cp0, cp1, mr, out_q, q59_b);
   input cp0;
   input cp1;
   input mr;
   output [9:0] out_q;
   reg [9:0] 	    out_d;
   output 	    q59_b;
   
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

   assign q59_b = ~|out_d[9:5];
   assign out_q = out_d;
endmodule // 4017
