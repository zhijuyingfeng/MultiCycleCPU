`timescale 1ns / 1ps

module PCSrcSelector(
    input[1:0] PCSrc,
    output reg[31:0] PCOut,
    input [31:0]PCSrc0,
    input [31:0]PCSrc1,
    input [31:0]PCSrc2,
    input [31:0]PCSrc3
    );
    
    always@(PCSrc)
    begin
        if(PCSrc==2'b00)
        begin
            PCOut=PCSrc0;
        end
        
        else if(PCSrc==2'b01)
        begin
            PCOut=PCSrc1;
        end
        
        else if(PCSrc==2'b10)
        begin
            PCOut=PCSrc2;
        end
        
        else if(PCSrc==2'b11)
        begin
            PCOut=PCSrc3;
        end
    end
endmodule
