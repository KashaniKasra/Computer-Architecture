module toplevel (input clk, rst);

    wire RegWriteD, MemWriteD, ALUSrcD, StallF, StallD, FlushD, FlushE, ZeroE, SignE, RegWriteM, RegWriteW, JalrD, JumpD, BranchD,
         JalrE, JumpE, BranchE;
    wire [1:0] PCSrcE, ResultSrcD, ForwardAE, ForwardBE, ResultSrcE, ResultSrcM, ResultSrcW;
    wire [2:0] ImmSrcD, ALUControlD, f3D, f3E;
    wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    wire [6:0] opc, f7;

    datapath DP (clk, rst, RegWriteD, MemWriteD, ALUSrcD, StallF, StallD, FlushD, FlushE, JalrD, JumpD, BranchD, PCSrcE, ResultSrcD, ForwardAE,
                 ForwardBE, ImmSrcD, ALUControlD, ZeroE, SignE, RegWriteM, RegWriteW, JalrE, JumpE, BranchE, ResultSrcE, ResultSrcM, ResultSrcW,
                 f3D, f3E, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, opc, f7);

    controller CU (f3D, f7, opc, RegWriteD, MemWriteD, ALUSrcD, JalrD, JumpD, BranchD, ResultSrcD, ALUControlD, ImmSrcD);

    PCselect PCS (JalrE, JumpE, BranchE, ZeroE, SignE, f3E, PCSrcE);

    hazards HU (RegWriteM, RegWriteW, PCSrcE, ResultSrcE, ResultSrcM, ResultSrcW, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
                StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

endmodule