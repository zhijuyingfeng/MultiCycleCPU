`timescale 1ns / 1ps

module BDR(
    input[31:0] ReadData2,
    input CLK,
    output reg[31:0]BDROut
    );
    
    reg [31:0]BDR;
    initial
    begin
        BDR=32'b0;
    end
    
    always@(negedge CLK)
    begin
        BDROut<=BDR;
    end
    
    always@(ReadData2)
    begin
        BDR=ReadData2;
    end
endmodule
