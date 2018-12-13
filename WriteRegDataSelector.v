`timescale 1ns / 1ps

module WriteRegDataSelector(
    input WrRegDSrc,
    input[31:0]PC4,
    input[31:0]DB,
    output reg[31:0]WriteData
    );
    
    always@(WrRegDSrc or DB)
    begin
        if(WrRegDSrc==0)
            begin
                WriteData=PC4;
            end
            
        else
        begin
            WriteData=DB;
        end
    end
    
endmodule
