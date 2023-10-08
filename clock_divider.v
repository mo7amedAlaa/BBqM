module clock_divider(clk,reset,slowclk);
	input clk,reset;
	output reg slowclk;
	reg [24:0] count;
	always @(posedge clk,posedge reset) 
	begin
		if(reset)
			begin 
				count<=0;
				slowclk<=0;
			end
		else
			begin 
			if(count< 1_000_000)
				count <= count+1;
			else
				begin
				count<=0;
				slowclk<= ~slowclk;
				end
			end
	end
endmodule