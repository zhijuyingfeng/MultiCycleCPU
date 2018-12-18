`timescale 1ns / 1ps

module ALUOutDR(
    input CLK,
    input[31:0] ALUResult,
    output reg[31:0] DROut
    );
    
    reg[31:0] ALUOutDR;
    
    initial
    begin
        ALUOutDR=32'b0;
    end
    
    always@(negedge CLK)
    begin
        DROut<=ALUOutDR;
    end
    
    always@(ALUResult)
    begin
        ALUOutDR=ALUResult;
    end
endmodule
