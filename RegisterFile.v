`timescale 1ns / 1ps

module RegisterFile(
    input[4:0] ReadReg1,
    input[4:0] ReadReg2,
    input CLK,
    input RegWre,
    output[31:0]ReadData1,
    output[31:0]ReadData2,
    input [31:0] WriteData,
    input [4:0]WriteReg
    );
    
    reg[7:0] RegMem[0:127];
    
    integer i;
    initial
    begin
        for(i=0;i<127;i=1+i)
        begin
            RegMem[i]=8'b0000_0000;
        end
    end
    
    assign ReadData1={RegMem[ReadReg1<<2],RegMem[(ReadReg1<<2)+1],RegMem[(ReadReg1<<2)+2],RegMem[(ReadReg1<<2)+3]};
    assign ReadData2={RegMem[ReadReg2<<2],RegMem[(ReadReg2<<2)+1],RegMem[(ReadReg2<<2)+2],RegMem[(ReadReg2<<2)+3]};
    
    always@(negedge CLK)
    begin
        if(RegWre==1)
        begin
            RegMem[WriteReg<<2]=WriteData[31:24];
            RegMem[(WriteReg<<2)+1]=WriteData[23:16];
            RegMem[(WriteReg<<2)+2]=WriteData[15:8];
            RegMem[(WriteReg<<2)+3]=WriteData[7:0];
        end
    end
endmodule
