`timescale 1ns / 1ps

module DBDR(
    input CLK,
    input [31:0]DB,
    output reg[31:0]DBDROut
    );
    
    reg [31:0]DBDR;
    
    initial
    begin
        DBDR=32'b0;
    end
    
    always@(negedge CLK)
    begin
        DBDROut<=DBDR;
    end
    
    always@(DB)
    begin
        DBDR=DB;
    end
    
endmodule
