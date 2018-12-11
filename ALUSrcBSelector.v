`timescale 1ns / 1ps

module ALUSrcBSelector(
    input ALUSrcB,
    input [31:0]ReadData2,
    input [31:0]ExtendOut,
    output reg[31:0]B
    );
    
    always@(ALUSrcB)
    begin
        if(ALUSrcB==0)
        begin
            B=ReadData2;
        end
        
        else if(ALUSrcB==1)
        begin
            B=ExtendOut;
        end
    end
endmodule
