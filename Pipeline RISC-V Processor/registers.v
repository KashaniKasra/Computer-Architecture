module IF_ID_regs (input clk, rst, StallD, FlushD, input [31:0] InstF, PCF, PC4F, output [31:0] InstD, PCD, PC4D);

    Register #(32) InstFreg (clk, rst, StallD, FlushD, InstF, InstD);
    Register #(32) PCFreg (clk, rst, StallD, FlushD, PCF, PCD);
    Register #(32) PC4Freg (clk, rst, StallD, FlushD, PC4F, PC4D);

endmodule

module ID_EX_regs (input clk, rst, FlushE, RegWriteD, MemWriteD, ALUSrcD, JalrD, JumpD, BranchD, input [1:0] ResultSrcD,
                   input[2:0] ALUControlD, f3D, input [4:0] Rs1D, Rs2D, RdD, input [31:0] RD1D, RD2D, PCD, ExtImmD, PC4D, 
                   output RegWriteE, MemWriteE, ALUSrcE, JalrE, JumpE, BranchE, output [1:0] ResultSrcE, output [2:0] ALUControlE,
                   f3E, output [4:0] Rs1E, Rs2E, RdE, output [31:0] RD1E, RD2E, PCE, ExtImmE, PC4E);

    DFF RegWriteDdff (clk, rst, FlushE, RegWriteD, RegWriteE);
    DFF MemWriteDdff (clk, rst, FlushE, MemWriteD, MemWriteE);
    DFF ALUSrcDdff (clk, rst, FlushE, ALUSrcD, ALUSrcE);
    DFF JalrDdff (clk, rst, FlushE, JalrD, JalrE);
    DFF JumpDdff (clk, rst, FlushE, JumpD, JumpE);
    DFF BranchDdff (clk, rst, FlushE, BranchD, BranchE);

    Register #(2) ResultSrcDreg (clk, rst, 1'b0, FlushE, ResultSrcD, ResultSrcE);
    Register #(3) ALUControlDreg (clk, rst, 1'b0, FlushE, ALUControlD, ALUControlE);
    Register #(32) RD1Dreg (clk, rst, 1'b0, FlushE, RD1D, RD1E);
    Register #(32) RD2Dreg (clk, rst, 1'b0, FlushE, RD2D, RD2E);
    Register #(32) PCDreg (clk, rst, 1'b0, FlushE, PCD, PCE);
    Register #(5) Rs1Dreg (clk, rst, 1'b0, FlushE, Rs1D, Rs1E);
    Register #(5) Rs2Dreg (clk, rst, 1'b0, FlushE, Rs2D, Rs2E);
    Register #(5) RdDreg (clk, rst, 1'b0, FlushE, RdD, RdE);
    Register #(32) ExtImmDreg (clk, rst, 1'b0, FlushE, ExtImmD, ExtImmE);
    Register #(32) PC4Dreg (clk, rst, 1'b0, FlushE, PC4D, PC4E);
    Register #(3) f3Dreg (clk, rst, 1'b0, FlushE, f3D, f3E);


endmodule

module EX_MEM_regs (input clk, rst, RegWriteE, MemWriteE, input [1:0] ResultSrcE, input [4:0] RdE,
                   input [31:0] ALUResultE, WriteDataE, ExtImmE, PC4E, output RegWriteM, MemWriteM,
                   output [1:0] ResultSrcM, output [4:0] RdM, output [31:0] ALUResultM, WriteDataM, ExtImmM, PC4M);

    DFF RegWriteEdff (clk, rst, 1'b0, RegWriteE, RegWriteM);
    DFF MemWriteEdff (clk, rst, 1'b0, MemWriteE, MemWriteM);

    Register #(2) ResultSrcEreg (clk, rst, 1'b0, 1'b0, ResultSrcE, ResultSrcM);
    Register #(32) ALUResultEreg (clk, rst, 1'b0, 1'b0, ALUResultE, ALUResultM);
    Register #(32) WriteDataEreg (clk, rst, 1'b0, 1'b0, WriteDataE, WriteDataM);
    Register #(5) RdEreg (clk, rst, 1'b0, 1'b0, RdE, RdM);
    Register #(32) ExtImmEreg (clk, rst, 1'b0, 1'b0, ExtImmE, ExtImmM);
    Register #(32) PC4Ereg (clk, rst, 1'b0, 1'b0, PC4E, PC4M);


endmodule

module MEM_WB_regs (input clk, rst, RegWriteM, input [1:0] ResultSrcM, input [4:0] RdM, input [31:0] ALUResultM,
                    ReadDataM, ExtImmM, PC4M, output RegWriteW, output [1:0] ResultSrcW, output [4:0] RdW,
                    output [31:0] ALUResultW, ReadDataW, ExtImmW, PC4W);

    DFF RegWriteMdff (clk, rst, 1'b0, RegWriteM, RegWriteW);

    Register #(2) ResultSrcMreg (clk, rst, 1'b0, 1'b0, ResultSrcM, ResultSrcW);
    Register #(32) ALUResultMreg (clk, rst, 1'b0, 1'b0, ALUResultM, ALUResultW);
    Register #(32) ReadDataMreg (clk, rst, 1'b0, 1'b0, ReadDataM, ReadDataW);
    Register #(5) RdMreg (clk, rst, 1'b0, 1'b0, RdM, RdW);
    Register #(32) ExtImmMreg (clk, rst, 1'b0, 1'b0, ExtImmM, ExtImmW);
    Register #(32) PC4Mreg (clk, rst, 1'b0, 1'b0, PC4M, PC4W);


endmodule