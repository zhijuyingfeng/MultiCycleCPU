`timescale 1ns / 1ps

module ALUSrcASelector(
    input ALUSrcA,
    input[4:0] sa,
    input [31:0]ReadData1,
    output reg[31:0]A
    );
    always@(ALUSrcA)
    begin
        if(ALUSrcA==0)
        begin
            A=ReadData1;
         end
         
         else if(ALUSrcA==1)
         begin
            A={{27{0}},sa};
         end
    end
endmodule
