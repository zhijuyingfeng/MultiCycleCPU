`timescale 1ns / 1ps

module DBDataSelector(
    input DBDataSrc,
    input[31:0] ALUResult,
    input[31:0]DMDataOut,
    output reg[31:0]DB
    );
    always@(DBDataSrc)
    begin
        if(DBDataSrc==0)
        begin
            DB=ALUResult;
        end
        
        else
        begin
            DB=DMDataOut;
        end
    end
endmodule
