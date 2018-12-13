`timescale 1ns / 1ps

module PCSrc3(
    output [31:0] PCSrc3,
    input[25:0] addr,
    input[31:0] PCOut
    );
    assign PCSrc3={PCOut[31:28],addr,2'b00};
endmodule
