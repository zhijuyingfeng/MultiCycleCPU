`timescale 1ns / 1ps

module IR(
    input IRWre,
    input [31:0] InstructionIn,
    output reg [31:0] IRReg,
//    output reg[31:0] InstructionOut,
    input CLK
    );
    
//    reg [31:0]IR;
    
//    initial
//    begin
//        IR=0;
//    end
    
    always@(negedge CLK)
    begin
        if(IRWre==1)
        begin
              IRReg<=InstructionIn;
//            InstructionOut<=InstructionIn;
        end
        
//        else if(IRWre==0)
//        begin
//            InstructionOut<=IR;
//        end
    end
endmodule
