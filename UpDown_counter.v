module UpDown_counter(clk,D,reset,leds);
	input clk,D,reset;
	output [6:0] leds;
	
	wire [3:0] count;
	wire slowclock ,debounced_clk;
	
	clock_divider div(clk,reset,slowclock);
	FF ff(slowclock,D,debounced_clk);
	
	COUNTER_FSM cnt(debounced_clk,reset,count);
	
	decoder_7seg seg (count[3],count[2],count[1],count[0],leds[6],leds[5],leds[4],leds[3],leds[2],leds[1],leds[0]);
endmodule