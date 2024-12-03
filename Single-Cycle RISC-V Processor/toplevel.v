module toplevel (input clk, rst);

    wire regwrite, memwrite, ALUsrc, zero, sign;
    wire [1:0] resultsrc, PCsrc;
    wire [2:0] ALUcontrol, IMMsrc, f3;
    wire [6:0] f7, opc;

    datapath DP (clk, rst, regwrite, memwrite, ALUsrc, resultsrc, PCsrc, ALUcontrol, IMMsrc, zero, sign, f3, f7, opc);
    controller CU (zero, sign, f3, f7, opc, regwrite, memwrite, ALUsrc, resultsrc, PCsrc, ALUcontrol, IMMsrc);

endmodule