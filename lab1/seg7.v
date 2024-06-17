module seg7(a,led7s);
input[3:0]a;
output reg[3:0] led7s;

always @(a)
    case(a)
       4'b0000:led7s=4'b0000;
   4'b0001:led7s=4'b0001;
   4'b0010:led7s=4'b0010;
   4'b0100:led7s=4'b0100;
   4'b0101:led7s=4'b0101;
   4'b0110:led7s=4'b0110;
   4'b0111:led7s=4'b0111;
   4'b1000:led7s=4'b1000;
   4'b1001:led7s=4'b1001;
   4'b1010:led7s=4'b1010;
   4'b1011:led7s=4'b1011;
   4'b1100:led7s=4'b1100;
   4'b1101:led7s=4'b1101;
   4'b1110:led7s=4'b1110;
   4'b1111:led7s=4'b1111;
  endcase
endmodule