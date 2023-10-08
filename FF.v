module FF(slowclock,D,debounced_clk);
  input slowclock,D;
  output reg debounced_clk;
  always @(posedge slowclock)
    debounced_clk <=D;
endmodule
