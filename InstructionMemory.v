`timescale 1ns / 1ps

module InstructionMemory(
    input [31:0] IAddr,
    input InsMemRW,
    output reg[31:0] DataOut,
    input [31:0] DataIn
    );
    
    reg [7:0]member [0:255];
    initial
    begin
        $readmemh("E:/projects/MultiCycleCPU/MultiCycleCPU.srcs/sources_1/new/ListRepo.txt",member);
    end
    
    always@(IAddr)
    begin
        if(InsMemRW==1)
        begin
            DataOut={member[IAddr],member[IAddr+1],member[IAddr+2],member[IAddr+3]};
        end
        
        else
        begin
            member[IAddr]=DataIn[31:24];
            member[IAddr+1]=DataIn[23:16];
            member[IAddr+2]=DataIn[15:8];
            member[IAddr+3]=DataIn[7:0];
        end
    end
    
endmodule
