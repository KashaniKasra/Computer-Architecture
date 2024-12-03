module PCselect (input JalrE, JumpE, BranchE, ZeroE, SignE, input [2:0] f3E, output [1:0] PCSrcE);

    assign PCSrcE = (JalrE) ? 2'b10 :   // jalr
                    JumpE |   // jal
                    (BranchE & (f3E == 3'd0) & ZeroE) |   // beq
                    (BranchE & (f3E == 3'd1) & ~ZeroE) |   // bne
                    (BranchE & (f3E == 3'd4) & SignE) |   // blt
                    (BranchE & (f3E == 3'd5) & (ZeroE | ~SignE)) ? 2'b01 :   // bge
                    2'b00;

endmodule