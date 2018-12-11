`timescale 1ns / 1ps

module ALU(
    input [31:0] A,
    input[31:0] B,
    input[2:0]ALUOp,
    output reg zero,
    output reg[31:0] ALUResult 
    );
    
    always@(ALUOp or A or B)
    begin
        case(ALUOp)
        3'b000://add
        begin
            ALUResult=A+B;
        end
        
        3'b001://sub
        begin
            ALUResult=A-B;
        end
        
        3'b010://�Ƚ�A��B��������
        begin
            ALUResult=(A<B?1:0);
        end
        
        3'b011://�Ƚ�A��B������
        begin
            if((A<B)&&(A[31]^B[31]==0))
            begin
                ALUResult=1;
            end
//            else if(A[31]==0&&B[31]==1)
//                ALUResult=0;
            else if(A[31]==1&&B[31]==0)
            begin
                ALUResult=1;
            end
            
            else
            begin
                ALUResult=0;
            end 
        end
        
        3'b100://B����Aλ
        begin
            ALUResult=B<<A;  
        end
        
        3'b101://��
        begin
            ALUResult=A|B;
        end
        
        3'b110://��
        begin
            ALUResult=A&B;  
        end
        
        3'b111://���
        begin
            ALUResult=A^B;
        end
        endcase
        
        if(ALUResult==0)
        begin
            zero=1;
        end
        
        else
        begin
            zero=0;
        end
    end
endmodule
