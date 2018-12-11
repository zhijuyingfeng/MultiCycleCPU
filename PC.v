`timescale 1ns / 1ps


module PC(

    input [31:0] PCIn,
    output reg[31:0] PCOut,
    input CLK,
    input RST,
    input PCWre
    );
        
    always@(posedge CLK or posedge PCWre)
    begin
        if(PCWre==1'b1)
        begin
            if(RST==1'b0)
            begin
                PCOut<=32'b0000_0000_0000_0000_0000_0000_0000_0000;
            end
        
            else if(RST==1'b1)
            begin
                PCOut<=PCIn;
            end
        end
        
    end
    
endmodule
