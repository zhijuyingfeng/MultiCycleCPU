`timescale 1ns / 1ps

module ADR(
    input[31:0] ReadData1,
    input CLK,
    output reg[31:0]ADROut
    );
    
    reg [31:0]ADR;
    initial
    begin
        ADR=32'b0;
    end
    
    always@(negedge CLK)
    begin
        ADROut<=ADR;
    end
    
    always@(ReadData1)
    begin
        ADR=ReadData1;
    end
endmodule
