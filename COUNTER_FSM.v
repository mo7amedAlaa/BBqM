module COUNTER_FSM(clk, reset, count);
  input clk,reset;
  output reg [3:0]count;
  
  parameter S0= 2'b00,
            S1= 2'b01,
            S2= 2'b10;
  reg [1:0] State;
  always @(posedge clk, posedge reset)
  begin
    if(reset)
      begin
          State = S0;
          count <= 0;
      end
    else
      begin
        case(State)
          S0: State <= S1; 
          S1: if(count < 7) 
          count <= count + 1; 
              else
                State <= S2; 
          S2: if(count > 0)
                count <= count - 1; 
              else
                State <= S1; 
        endcase
      end

  end
endmodule




