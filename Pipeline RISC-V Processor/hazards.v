module hazards (input RegWriteM, RegWriteW, input [1:0] PCSrcE, ResultSrcE, ResultSrcM, ResultSrcW,
                input [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, output StallF, StallD, FlushD,
                FlushE, output [1:0] ForwardAE, ForwardBE);

    wire LwStall;

    assign ForwardAE = ((Rs1E == RdM) & (RegWriteM == 1) & (Rs1E != 5'b0)) ? 2'b10 :
                        (((Rs1E == RdW) & (RegWriteW == 1)) | ((Rs1E == RdW) & (ResultSrcW == 2'b11))) & (Rs1E != 5'b0) ? 2'b01 :
                        (Rs1E == RdM) & (ResultSrcM == 2'b11) & (Rs1E != 5'b0) ? 2'b11 : 2'b00;

    assign ForwardBE = ((Rs2E == RdM) & (RegWriteM == 1) & (Rs2E != 5'b0)) ? 2'b10 :
                        (((Rs2E == RdW) & (RegWriteW == 1)) | ((Rs2E == RdW) & (ResultSrcW == 2'b11))) & (Rs2E != 5'b0) ? 2'b01 :
                        (Rs2E == RdM) & (ResultSrcM == 2'b11) & (Rs2E != 5'b0) ? 2'b11 : 2'b00;

    assign LwStall = ((Rs1D == RdE) | (Rs2D == RdE)) & (Rs1D != 5'b0) & (Rs2D != 5'b0) & (ResultSrcE == 2'b01);
    assign StallF = LwStall;
    assign StallD = LwStall;
    assign FlushD = (PCSrcE == 2'b01);
    assign FlushE = (LwStall) | (PCSrcE == 2'b01) | (PCSrcE == 2'b10);

endmodule