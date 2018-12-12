`timescale 1ns / 1ps

module ControlUnit(
    input CLK,
    input RST,
    input zero,
    input[5:0] Op,
    output reg PCWre,
    output reg Extsel,
    output reg InsMemRW,
    output reg IRWre,
    output reg WrRegDSrc,
    output reg[1:0] RegDst,
    output reg RegWre,
    output reg[2:0]ALUOp,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg[1:0]PCSrc,
    output reg RD,
    output reg WR,
    output reg DBDataSrc
    );
    
    reg [2:0]StatusCode;
    initial
    begin
        StatusCode=3'b000;
    end
    
    always@(posedge CLK)
    begin
        case(StatusCode)
        3'b000:
        begin
            PCWre<=1;
            InsMemRW<=1;
            IRWre<=1;
            StatusCode<=3'b001;
            Extsel<=1'bz;
            WrRegDSrc<=1'bz;
            RegWre<=1'bz;
            RegDst<=2'bzz;
            ALUOp<=3'bzzz;
            ALUSrcA<=1'bz;
            ALUSrcB<=1'bz;
            PCSrc<=2'bzz;
            RD<=1'bz;
            WR<=1'bz;
            DBDataSrc<=1'bz;
        end

        3'b001:
        begin
            IRWre<=1'b0;
            PCWre<=1'b0;
          case(Op)
            6'b111010://jal
            begin
                RegWre<=1;
                WrRegDSrc<=0;
                RegDst<=0;
                PCSrc<=2'b11;
                StatusCode<=3'b000;
            end

            6'b111111://halt
            begin
              PCSrc<=2'bzz;
              InsMemRW<=1'bz;
              IRWre<=1'bz;
              StatusCode<=3'b000;
            end

            6'b111000://j
            begin
              PCSrc<=2'b11;
              StatusCode<=3'b000;
            end

            6'b111001://jr
            begin
              PCSrc<=2'b10;
              StatusCode<=3'b000;
            end
                
            6'b110000,6'b110001://sw,lw
            begin
                Extsel<=1;
                PCSrc<=2'b00;
                StatusCode<=3'b010;
            end

            6'b110100,6'b110101://beq,bne
            begin
              Extsel<=1'b1;
              StatusCode<=3'b101;
            end

            6'b010010,6'b011000://ori,sll
            begin
              PCSrc<=2'b00;
              Extsel<=1'b0;
              StatusCode<=3'b110;
            end

            6'b000010://addi
            begin
              Extsel<=1'b1;
              PCSrc<=2'b00;
              StatusCode<=3'b110;
            end

            //add,sub,or,and,slt,sltu
            6'b000000,6'b000001,6'b010000,6'b010001,6'b100110,6'b100111:
            begin
              PCSrc<=2'b00;
              StatusCode<=3'b110;
            end
          endcase
        
        end

        3'b010://lw.sw EXE
        begin
            PCWre<=1'b0;
            ALUSrcA<=1'b0;
            ALUSrcB<=1'b1;
            ALUOp<=3'b000;
            StatusCode<=3'b011;
        end

        3'b011://sw,lw MEM
        begin
        PCWre<=1'b0;
          case(Op)
            6'b110000://sw
            begin
                WR<=1'b0;  
                StatusCode<=3'b000;
            end

            6'b110001://lw
            begin
              RD<=1'b0;
              StatusCode<=3'b100;
            end    
          endcase
        end

        3'b100://lw WB
        begin
          PCWre<=1'b0;
          DBDataSrc<=1'b1;
          RegDst<=2'b01;
          WrRegDSrc<=1'b1;
          RegWre<=1'b1;
          StatusCode<=3'b000;
        end

        3'b101://bne beq EXE
        begin
            PCWre<=1'b0;
            ALUSrcA<=1'b0;
            ALUSrcB<=1'b0;
            ALUOp<=3'b001;
        //   case(Op)
        //     6'b110100://beq
        //     begin
        //       if(zero==1'b1)
        //       begin
        //         PCSrc<=2'b01;
        //       end
        //       else if(zero==1'b0)
        //       begin
        //         PCSrc<=2'b00;
        //       end
        //     end

        //     6'b110101://bne
        //     begin
        //       if(zero==0)
        //       begin
        //         PCSrc<=2'b01;
        //       end
        //       else if(zero==1)
        //         begin
        //           PCSrc<=2'b00;
        //         end
        //     end
        //   endcase
          StatusCode<=3'b000;
        end

        3'b110:
        begin
            PCWre<=1'b0;
            StatusCode<=3'b111;
          case(Op)
            6'b000000://add
            begin
              ALUOp<=3'b000;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end

            6'b000001://sub
            begin
              ALUOp<=3'b001;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end

            6'b000010://addi
            begin
              ALUOp<=3'b000;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b1;
            end

            6'b010000://or
            begin
              ALUOp<=3'b101;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end

            6'b010001://and
            begin
              ALUOp<=3'b110;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end

            6'b010010://ori
            begin
              ALUOp<=3'b101;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b1;
            end

            6'b011000://sll
            begin
              ALUOp<=3'b100;
              ALUSrcA<=1'b1;
              ALUSrcB<=1'b0;
            end

            6'b100110://slt
            begin
              ALUOp<=3'b011;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end

            6'b100111://sltu
            begin
              ALUOp<=3'b010;
              ALUSrcA<=1'b0;
              ALUSrcB<=1'b0;
            end
          endcase
          end

          3'b111://WB
          begin
            PCWre<=1'b0;
            WrRegDSrc<=1'b1;
            RegWre<=1'b1;
            DBDataSrc<=1'b0;
            StatusCode<=3'b000;
            case(Op)
                6'b000000,6'b000001,6'b010000,6'b010001,6'b011000,
                6'b011000,6'b100110,6'b100111:
                begin
                  RegDst<=2'b10;
                end

                6'b000010,6'b010010:
                begin
                    RegDst<=2'b01;
                end
            endcase
          end        
        endcase
        
    end

    always@(negedge CLK)
    begin
        if(StatusCode==3'b001)
            begin
                PCWre<=1'b0;
            end
            
      case(Op)
        6'b110100://beq
        begin
            if(zero==1)
            begin
              PCSrc<=2'b01;
            end
            else if(zero==0)
            begin
                PCSrc<=2'b00;
            end
        end
        6'b110101://bne
        begin
          if(zero==0)
          begin
            PCSrc<=2'b01;
          end
          else if(zero==1)
          begin
            PCSrc<=2'b00;
          end
        end
      endcase
    end   
endmodule
