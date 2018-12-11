`timescale 1ns / 1ps

module WriteRegSelector(
    input [1:0]RegDst,
    output reg[4:0]WriteReg,
    input [4:0]rt,
    input [4:0]rd
    );
    always@(RegDst)
    begin
    
        if(RegDst==2'b00)
        begin
            WriteReg=5'b11111;
        end
        
        else if(RegDst==2'b01)
        begin
            WriteReg=rt;    
        end
        
        else if(RegDst==2'b10)
        begin
            WriteReg=rd;
        end
    end
endmodule
