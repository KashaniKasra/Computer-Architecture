module toplevel (input clk,  rst);

    wire PCwrite, oldPCwrite, IRwrite, memwrite, regwrite, adrsrc, zero, sign;
    wire [2:0] IMMsrc, ALUcontrol, f3;
    wire [1:0] ALUsrcA, ALUsrcB, resultsrc;
    wire [6:0] f7, opc;

    datapath DP (clk, rst, PCwrite, oldPCwrite, IRwrite, memwrite, regwrite, adrsrc, IMMsrc, ALUcontrol, ALUsrcA,
                 ALUsrcB, resultsrc, zero, sign, f3, f7, opc);

    controller CU (clk, rst, zero, sign, f3, f7, opc, PCwrite, oldPCwrite, IRwrite, memwrite, regwrite, adrsrc,
		   IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB, resultsrc);

endmodule