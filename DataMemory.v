`timescale 1ns / 1ps

module DataMemory(
    input RD,
    input WR,
    input [31:0]DAddr,
    output reg[31:0] DataOut,
    input [31:0]DataIn,
    input CLK
    );
    
    reg[7:0] DataMem[0:255];
    
    integer i;
    initial
    begin
        for(i=0;i<255;i=i+1)
        begin
            DataMem[i]=0;
        end
    end
    
    always@(negedge CLK)
    begin
        if(RD==1)
        begin
            DataOut=32'bz;
        end
        
        else if(RD==0)
        begin
            DataOut={DataMem[DAddr],DataMem[DAddr+1],DataMem[DAddr+2],DataMem[DAddr+3]};
        end
        
        if(WR==0)
        begin
            DataMem[DAddr]=DataIn[31:24];
            DataMem[DAddr+1]=DataIn[23:16];
            DataMem[DAddr+2]=DataIn[15:8];
            DataMem[DAddr+3]=DataIn[7:0];
        end
    end
    
endmodule
