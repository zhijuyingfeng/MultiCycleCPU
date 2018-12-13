`timescale 1ns / 1ps

module Test();
    
    //信号
    reg CLK;
    reg RST;
    wire PCWre;
    wire Extsel;
    wire InsMemRW;
    wire IRWre;
    wire WRRegDSrc;
    wire [1:0]RegDst;
    wire RegWre;
    wire [2:0]ALUOp;
    wire ALUSrcA;
    wire ALUSrcB;
    wire [1:0]PCSrc;
    wire RD;
    wire WR;
    wire DBDataSrc;
    wire zero;

    //中间变量
    wire [31:0] _PCIn;
    wire [31:0] _PCOut;
    wire [31:0] _Instruction;
    wire [31:0] _DataIn;//输入指令存储器的内容
    wire [4:0] _ReadReg1;
    wire [4:0] _ReadReg2;
    wire [4:0] _WriteReg;
    wire [31:0] _ReadData1;
    wire [31:0] _ReadData2;
    wire [31:0] _WriteData;
    wire [31:0] _ExtendOut;
    wire [31:0] _ALUResult;
    wire [31:0] _DMDataOut;//DataMemory读出的内�?
    wire [31:0] _A;//ALU A口数�??
    wire [31:0] _B;//ALU B口数�??
    wire [31:0] _DB;
    wire [31:0] _PCSrc0;
    wire [31:0] _PCSrc1;
    wire [31:0] _PCSrc2;
    wire [31:0] _PCSrc3;
    wire [31:0] _InsDataOut;
//    wire [31:0] _IRReg;

    PC pc
    (
        .PCIn(_PCIn),
        .PCOut(_PCOut),
        .CLK(CLK),
        .RST(RST),
        .PCWre(PCWre)
    );

    InstructionMemory instruction_memory
    (
        .IAddr(_PCOut),
        .InsMemRW(InsMemRW),
        .DataOut(_InsDataOut),
        .DataIn(_DataIn)
    );

    RegisterFile register_file
    (
        .ReadReg1(_Instruction[25:21]),
        .ReadReg2(_Instruction[20:16]),
        .CLK(CLK),
        .RegWre(RegWre),
        .ReadData1(_ReadData1),
        .ReadData2(_ReadData2),
        .WriteData(_WriteData),
        .WriteReg(_WriteReg)
    );

    SignZeroExtend sign_zero_extend
    (
        .Extsel(Extsel),
        .Imme(_Instruction[15:0]),
        .ExtendOut(_ExtendOut)
    );

    DataMemory data_memory
    (
        .RD(RD),
        .WR(WR),
        .DAddr(_ALUResult),
        .DataOut(_DMDataOut),
        .DataIn(_ReadData2),
        .CLK(CLK)
    );

    ALU alu
    (
        .A(_A),
        .B(_B),
        .ALUOp(ALUOp),
        .zero(zero),
        .ALUResult(_ALUResult) 
    );

    ControlUnit control_unit
    (
        .CLK(CLK),
        .RST(RST),
        .zero(zero),
        .Op(_Instruction[31:26]),
        .PCWre(PCWre),
        .Extsel(Extsel),
        .InsMemRW(InsMemRW),
        .IRWre(IRWre),
        .WrRegDSrc(WRRegDSrc),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .ALUOp(ALUOp),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .PCSrc(PCSrc),
        .RD(RD),
        .WR(WR),
        .DBDataSrc(DBDataSrc)
    );

    DBDataSelector DB_data_selector
    (
        .DBDataSrc(DBDataSrc),
        .ALUResult(_ALUResult),
        .DMDataOut(_DMDataOut),
        .DB(_DB)
    );

    WriteRegDataSelector write_reg_data_selector
    (
        .WrRegDSrc(WRRegDSrc),
        .PC4(_PCSrc0),
        .DB(_DB),
        .WriteData(_WriteData)
    );

    PCSrc0 pc_src0
    (
        .PC(_PCOut),
        .PC4(_PCSrc0)
    );

    PCSrc1 pc_src1
    (
        .PC(_PCSrc0),
        .ExtendOut(_ExtendOut),
        .PCJump(_PCSrc1)
    );

    PCSrc2 pc_src2
    (
        .ReadData1(_ReadData1),
        .PCSrc2(_PCSrc2)
    );

    PCSrc3 pc_src3
    (
        .PCSrc3(_PCSrc3),
        .addr(_Instruction[25:0]),
        .PCOut(_PCSrc0)
    );

    ALUSrcASelector alu_src_a_selector
    (
        .ALUSrcA(ALUSrcA),
        .sa(_Instruction[10:6]),
        .ReadData1(_ReadData1),
        .A(_A)
    );

    ALUSrcBSelector alu_src_b_selector
    (
        .ALUSrcB(ALUSrcB),
        .ReadData2(_ReadData2),
        .ExtendOut(_ExtendOut),
        .B(_B)
    );

    PCSrcSelector pc_src_selector
    (
        .PCSrc(PCSrc),
        .PCOut(_PCIn),
        .PCSrc0(_PCSrc0),
        .PCSrc1(_PCSrc1),
        .PCSrc2(_PCSrc2),
        .PCSrc3(_PCSrc3)
    );

    WriteRegSelector write_reg_selector
    (
        .RegDst(RegDst),
        .WriteReg(_WriteReg),
        .rt(_Instruction[20:16]),
        .rd(_Instruction[15:11])
    );
    
    IR ir
    (
        .IRWre(IRWre),
        .InstructionIn(_InsDataOut),
//        .InstructionOut(_Instruction)
        .IRReg(_Instruction),
        .CLK(CLK)
    );

//    integer i;
    initial
    begin
      CLK=0;
      RST=0;
//      i=0;
      #5;
        CLK=!CLK;
        
        forever #5
        begin
            RST=1;
            CLK=!CLK;
//            if(i>0)
//            begin
//                RST=1;
//            end
//            i=i+1;
        end
        #1000 $stop;
    end
endmodule
