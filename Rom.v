module Rom(index_rom, Wtime);
  
  input  [4:0]index_rom;
  output reg [4:0]Wtime;
   
  always @(index_rom)
  begin
    case(index_rom)
      // Pcount = 1
      5'b01001: Wtime = 5'b00011; // index = 9  , value = 3
      5'b10001: Wtime = 5'b00011; // index = 17 , value = 3
      5'b11001: Wtime = 5'b00011; // index = 25 , value = 3
      // Pcount = 2
      5'b01010: Wtime = 5'b00110; // index = 10 , value = 6
      5'b10010: Wtime = 5'b00100; // index = 18 , value = 4
      5'b11010: Wtime = 5'b00100; // index = 26 , value = 4
      // Pcount = 3
      5'b01011: Wtime = 5'b01001; // index = 11 , value = 9
      5'b10011: Wtime = 5'b00110; // index = 19 , value = 6
      5'b11011: Wtime = 5'b00101; // index = 27 , value = 5
      // Pcount = 4
      5'b01100: Wtime = 5'b01100; // index = 12 , value = 12
      5'b10100: Wtime = 5'b00111; // index = 20 , value = 7
      5'b11100: Wtime = 5'b00110; // index = 28 , value = 6
      // Pcount = 5
      5'b01101: Wtime = 5'b01111; // index = 13 , value = 15
      5'b10101: Wtime = 5'b01001; // index = 21 , value = 9
      5'b11101: Wtime = 5'b00111; // index = 29 , value = 7
      // Pcount = 6
      5'b01110: Wtime = 5'b10010; // index = 14 , value = 18
      5'b10110: Wtime = 5'b01010; // index = 22 , value = 10
      5'b11110: Wtime = 5'b01000; // index = 30 , value = 8
      // Pcount = 7
      5'b01111: Wtime = 5'b10101; // index = 15 , value = 21
      5'b10111: Wtime = 5'b01100; // index = 23 , value = 12
      5'b11111: Wtime = 5'b01001; // index = 31 , value = 9
      
      default: Wtime = 5'b000000; // index = don't care, value = 0
    endcase
  end
  
endmodule

