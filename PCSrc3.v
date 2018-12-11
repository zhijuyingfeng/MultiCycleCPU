`timescale 1ns / 1ps

module PCSrc3(
    output [31:0] PCSrc3,
    input[25:0] addr,
    input[31:0] PCOut
    );
    assign PCSrc3={PCOut[3:0],addr[25:0],{0,0}};
endmodule
