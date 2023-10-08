module BBqM(sw,clk,D,reset,updown,segmentleds,sev2,sev3,led_Flag,led1,led2);
  input [2:0] sw; 
  input  clk,D,reset,updown;
  output [6:0]segmentleds,sev2,sev3;
  output led_Flag;
   output [6:0] led1 , led2 ;
  
  wire [2:0] count;
  wire slow_clk,debounced_clock;
  
   wire [1:0]t; 
   wire [4:0]w; 
  wire [3:0] digit1 =w%10; 
  wire [3:0] digit2 =w/10; 

     
	 t_count opj1 (sw,t); 
  rom opj3 (count,t,w);
  Clock_Divider clk_divider(clk,reset,slow_clk);
  Flip_Flop filp_flop(slow_clk,D,debounced_clock);
  bcd_counter cnt(debounced_clock,reset,count,led,updown);
  sevenSegments seg(count,segmentleds);
   decoder_7seg seg1( digit1[3] , digit1[2] , digit1[1] , digit1[0] ,
   led1[6] , led1[5] , led1[4] , led1[3] , led1[2] , led1[1] , led1[0] );
   
  decoder_7seg seg2( digit2[3] , digit2[2] , digit2[1] , digit2[0] , 
   led2[6] , led2[5] , led2[4] , led2[3] , led2[2] , led2[1] , led2[0] ); 
  
  assign led_Flag = led;
  
endmodule


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

module rom (pcount,tcount,wtime); 
  input [3:0]pcount ; 
  input [1:0] tcount; 
  output reg[4:0]wtime; 
  always@(*) 
  begin 
 if(tcount==2'b01) 
  begin 
    case(pcount) 
    4'b0000 : wtime <= 5'b00000; 
    4'b0001 : wtime <= 5'b00011; 
    4'b0010 : wtime <= 5'b00110; 
    4'b0011 : wtime <= 5'b01001; 
    4'b0100 : wtime <= 5'b01100; 
    4'b0101 : wtime <= 5'b01111; 
    4'b0110 : wtime <= 5'b10010; 
    4'b0111 : wtime <= 5'b10101;     
  endcase 
  end 
else if(tcount==2'b10) 
  begin 
    case(pcount) 
    4'b0000 : wtime <= 5'b00000; 
    4'b0001 : wtime <= 5'b00011; 
    4'b0010 : wtime <= 5'b00100; 
    4'b0011 : wtime <= 5'b00110; 
    4'b0100 : wtime <= 5'b00111; 
    4'b0101 : wtime <= 5'b01001; 
    4'b0110 : wtime <= 5'b01010; 
    4'b0111 : wtime <= 5'b01100;     
  endcase 
  end 
  if(tcount==2'b11) 
  begin 
    case(pcount) 
    4'b0000 : wtime <= 5'b00000; 
    4'b0001 : wtime <= 5'b00011; 
    4'b0010 : wtime <= 5'b00100; 
    4'b0011 : wtime <= 5'b00101; 
    4'b0100 : wtime <= 5'b00110; 
    4'b0101 : wtime <= 5'b00111; 
    4'b0110 : wtime <= 5'b01000; 
    4'b0111 : wtime <= 5'b01001;     
  endcase 
  end 
end 
endmodule
module t_count(s,tcount); 
  input [2:0] s; 
  output [1:0]tcount; 
  assign tcount=s[0]+s[1]+s[2]; 
endmodule
module decoder_7seg (A, B, C, D, led_a, led_b, led_c, led_d, led_e, led_f, led_g);
 
 input A, B, C, D; 
 output led_a, led_b, led_c, led_d, led_e, led_f, led_g;

  assign led_a = ~(A | C | B&D | ~B&~D); 
  assign led_b = ~(~B | ~C&~D | C&D);
  assign led_c = ~(B | ~C | D); 
  assign led_d = ~(~B&~D | C&~D | B&~C&D | ~B&C |A); 
  assign led_e = ~(~B&~D | C&~D);
  assign led_f = ~(A | ~C&~D | B&~C | B&~D); 
  assign led_g = ~(A | B&~C | ~B&C | C&~D); 
 
endmodule

