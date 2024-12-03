module datapath (input clk, rst, RegWriteD, MemWriteD, ALUSrcD, StallF, StallD, FlushD, FlushE, JalrD, JumpD, BranchD,
                 input [1:0] PCSrcE, ResultSrcD, ForwardAE, ForwardBE, input [2:0] ImmSrcD,
                 ALUControlD, output ZeroE, SignE, RegWriteM, RegWriteW, JalrE, JumpE, BranchE, output [1:0] ResultSrcE,
                 ResultSrcM, ResultSrcW, output [2:0] f3D, f3E, output [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
                 RdE, RdM, RdW, output [6:0] opc, f7);

    wire RegWriteE, MemWriteE, ALUSrcE, MemWriteM;
    wire [2:0] ALUControlE;
    wire [4:0] RdD; 
    wire [31:0] PCinF, PCF, InstF, PC4F, InstD, PCD, PC4D, ExtImmD, PCE, ExtImmE, PC4E, ALUResultE, WriteDataE,
                ALUResultM, WriteDataM, ExtImmM, PC4M, ReadDataM, ALUResultW, ReadDataW, ExtImmW, PC4W, SrcBE,
                PCTargetE, SrcAE, ResultW, RD1D, RD2D, RD1E, RD2E;

    Register #(32) PC (clk, rst, StallF, 1'b0, PCinF, PCF);
    IF_ID_regs IF_ID (clk, rst, StallD, FlushD, InstF, PCF, PC4F, InstD, PCD, PC4D);
    ID_EX_regs ID_EX(clk, rst, FlushE, RegWriteD, MemWriteD, ALUSrcD, JalrD, JumpD, BranchD, ResultSrcD, ALUControlD, f3D, Rs1D, Rs2D,
                     RdD, RD1D, RD2D, PCD, ExtImmD, PC4D, RegWriteE, MemWriteE, ALUSrcE, JalrE, JumpE, BranchE, ResultSrcE,
                     ALUControlE, f3E, Rs1E, Rs2E, RdE, RD1E, RD2E, PCE, ExtImmE, PC4E);    
    EX_MEM_regs EX_MEM(clk, rst, RegWriteE, MemWriteE, ResultSrcE, RdE, ALUResultE, WriteDataE, ExtImmE, PC4E,
                       RegWriteM, MemWriteM, ResultSrcM, RdM, ALUResultM, WriteDataM, ExtImmM, PC4M);
    MEM_WB_regs MEM_WB(clk, rst, RegWriteM, ResultSrcM, RdM, ALUResultM, ReadDataM, ExtImmM, PC4M, RegWriteW,
                       ResultSrcW, RdW, ALUResultW, ReadDataW, ExtImmW, PC4W);
    MUX2to1 mux2 (ALUSrcE, WriteDataE, ExtImmE, SrcBE);
    MUX3to1 mux3 (PCSrcE, PC4F, PCTargetE, ALUResultE, PCinF);
    MUX4to1 mux4_1 (ForwardAE, RD1E, ResultW, ALUResultM, ExtImmM, SrcAE);
    MUX4to1 mux4_2 (ForwardBE, RD2E, ResultW, ALUResultM, ExtImmM, WriteDataE);
    MUX4to1 mux4_3 (ResultSrcW, ALUResultW, ReadDataW, PC4W, ExtImmW, ResultW);
    Adder adder1 (PCF, 32'd4, PC4F);
    Adder adder2 (PCE, ExtImmE, PCTargetE);
    Instruction_Memory IM (PCF, InstF);
    Data_Memory DM (clk, MemWriteM, ALUResultM, WriteDataM, ReadDataM);
    Register_File RF (clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
    ALU alu (ALUControlE, SrcAE, SrcBE, ZeroE, SignE, ALUResultE);
    Immediate_Extend IE (ImmSrcD, InstD[31:7], ExtImmD);

    assign Rs1D = InstD[19:15];
    assign Rs2D = InstD[24:20];
    assign RdD = InstD[11:7];
    assign f3D = InstD[14:12];
    assign f7 = InstD[31:25];
    assign opc = InstD[6:0];

endmodule