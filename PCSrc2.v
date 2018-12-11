`timescale 1ns / 1ps

module PCSrc2(
    input[31:0] ReadData1,
    output[31:0] PCSrc2
    );
    assign PCSrc2=ReadData1;
endmodule
