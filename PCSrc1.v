`timescale 1ns / 1ps

module PCSrc1(
    input[31:0] PC,
    input[31:0]ExtendOut,
    output [31:0] PCJump
    );
    assign PCJump=PC+(ExtendOut<<2);
endmodule
