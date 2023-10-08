module TCount(T,tcount);
  input [1:0] T;
  output reg [6:0] tcount;
  always @(T)
    begin
        case(T)
          2'b00: tcount= ~7'b1111110; //0
          2'b01: tcount= ~7'b0110000; //1
          2'b10: tcount= ~7'b1101101; //2
          2'b11: tcount= ~7'b1111001; //3
        
        endcase
    end
endmodule
