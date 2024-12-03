module controller (input [2:0] f3D, input [6:0] f7, opc, output reg RegWriteD, MemWriteD,
                   ALUSrcD, JalrD, JumpD, BranchD, output reg [1:0] ResultSrcD, output reg [2:0] ALUControlD, ImmSrcD);

    always @(f3D, f7, opc) begin
        case (opc)

            7'd3: begin
                {RegWriteD, ImmSrcD, ALUSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 11'b1_000_1_0_01_0_0_0;
                if (f3D == 3'd2)   // lw
                    ALUControlD = 3'b000;
            end

            7'd35: begin
                {RegWriteD, ImmSrcD, ALUSrcD, MemWriteD, JalrD, JumpD, BranchD} = 9'b0_001_1_1_0_0_0;
                if (f3D == 3'd2) begin   // sw
                    ALUControlD = 3'b000;
                end
            end

            7'd99: begin
                {RegWriteD, ImmSrcD, ALUSrcD, MemWriteD, JalrD, JumpD, BranchD} = 9'b0_010_0_0_0_0_1;
                if (f3D == 3'd0)  // beq
                    ALUControlD = 3'b001;
                else if (f3D == 3'd1)   // bne
                    ALUControlD = 3'b001;   
                else if (f3D == 3'd4)   // blt
                    ALUControlD = 3'b001;
                else if (f3D == 3'd5)   // bge
                    ALUControlD = 3'b001;  
            end

            7'd51: begin
                {RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 8'b1_0_0_00_0_0_0;
                if ((f3D == 3'd0) & (f7 == 7'd0))  // add
                    ALUControlD = 3'b000;
                else if ((f3D == 3'd0) & (f7 == 7'd32))   // sub
                    ALUControlD = 3'b001;
                else if ((f3D == 3'd7) & (f7 == 7'd0))   // and
                    ALUControlD = 3'b010;
                else if ((f3D == 3'd6) & (f7 == 7'd0))   // or
                    ALUControlD = 3'b011;
                else if ((f3D == 3'd2) & (f7 == 7'd0))   // slt
                    ALUControlD = 3'b101;
                else if ((f3D == 3'd3) & (f7 == 7'd0))  // sltu
                    ALUControlD = 3'b110;
            end

            7'd19: begin
                {RegWriteD, ImmSrcD, ALUSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 11'b1_000_1_0_00_0_0_0;
                if (f3D == 3'd0)   // addi
                    ALUControlD = 3'b000;
                else if (f3D == 3'd4)   // xori
                    ALUControlD = 3'b100;
                else if (f3D == 3'd6)   // ori
                    ALUControlD = 3'b011;
                else if (f3D == 3'd2)   // slti
                    ALUControlD = 3'b101;
                else if (f3D == 3'd3)   // sltiu
                    ALUControlD = 3'b110;
            end

            7'd111: begin
                {RegWriteD, ImmSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 10'b1_011_0_10_0_1_0;
            end

            7'd55: begin 
                {RegWriteD, ImmSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 10'b1_100_0_11_0_0_0;
            end

            7'd103: begin
                {RegWriteD, ImmSrcD, ALUSrcD, MemWriteD, ResultSrcD, JalrD, JumpD, BranchD} = 11'b1_000_1_0_10_1_0_0;
                if (f3D == 3'd0)   // jalr
                    ALUControlD = 3'b000;
            end

        endcase
    end

endmodule