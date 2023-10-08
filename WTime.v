module WTime(Pcount,Tcount,reset,Wtime);
  input [3:0] Pcount,reset ;
  input [1:0] Tcount;
  output reg [3:0] Wtime;
  always @(reset )
  begin 
  if(reset)
     Wtime <=0;
   else
     begin
       Wtime<=3*(Pcount+Tcount-1)/Tcount;
     end
  end
endmodule
