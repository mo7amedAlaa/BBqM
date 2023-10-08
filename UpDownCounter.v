           /*      Code Of UP Down Counter       */
module bcd_counter(clk,reset,count,led,updown);
input clk,reset,updown;
output reg [2:0] count;
output reg led = 0 ;
  
always @(posedge clk or posedge reset)
begin
	     if (reset)
	             	begin
			              count <= 0;
			              led=0;
		            end
     	 else
		            begin
			              if(updown)
				                begin
				                   if(count == 7)
						                 led=1;
					                 else
						                   begin
							                  count <= count + 1;
							                  led=0;
						                   end
				                end
		                else
				                begin
				                   if(count != 0)
						                   begin
							                   count <= count - 1;
							                   led=0;
						                   end
						                   
					                  else if(count==0)
					                     begin
					                        led=1;
					                     end
		 		                end
		            end
end
endmodule
                 /*       Code OF Seven Segments       */
module sevenSegments (bcd,dec); 
input [2:0]bcd;
output reg [6:0] dec; 
always@(bcd)
begin
	case(bcd)
	3'b000 : dec = ~7'b1111110; // 0
	3'b001 : dec = ~7'b0110000; // 1
	3'b010 : dec = ~7'b1101101; // 2
	3'b011 : dec = ~7'b1111001; // 3
	3'b100 : dec = ~7'b0110011; // 4
	3'b101 : dec = ~7'b1011011; // 5
	3'b110 : dec = ~7'b1011111; // 6
	3'b111 : dec = ~7'b1110000; // 7

	default : dec = ~7'b1111110; //0 default 
	endcase
end
endmodule

           /*        Code Of Clock Divider         */
module Clock_Divider(clk,reset,slow_clk);
  input clk,reset;
  output reg slow_clk;
  
  reg[24:0]count;
  
  always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        count <= 0;
        slow_clk <= 0;
      end
    else
      begin
         if(count < 1_000_000)
             count <= count + 1;
         else
           begin
             slow_clk <= ~slow_clk;
             count <=0;
           end
      end
         
  end
  
endmodule
              /*               Code Of Flip Flop       */
module Flip_Flop(clk,d,q);
  input clk , d;
  output reg q;

  always@(posedge clk)
  q <= d;
endmodule
