module datapath (input clk, rst, PCwrite, oldPCwrite, IRwrite, memwrite, regwrite, adrsrc, input [2:0] IMMsrc, ALUcontrol,
                 input [1:0] ALUsrcA, ALUsrcB, resultsrc, output zero, sign, output [2:0] f3, output [6:0] f7, opc);

    wire [31:0] PCout, oldPCout, memoryout, inst, data, reg1, reg2, Aout, Bout, ALUout, toResult, result, toMemory,
                toALU1, toALU2, IMMout;

    register32 PC (clk, rst, PCwrite, result, PCout);
    register32 oldPC (clk, rst, oldPCwrite, PCout, oldPCout);
    register32 IR (clk, rst, IRwrite, memoryout, inst);
    register32 MDR (clk, rst, 1'b1, memoryout, data);
    register32 Areg (clk, rst, 1'b1, reg1, Aout);
    register32 Breg (clk, rst, 1'b1, reg2, Bout);
    register32 ALUreg (clk, rst, 1'b1, ALUout, toResult);

    memory Mem (clk, memwrite, toMemory, Bout, memoryout);

    register_file RF (clk, regwrite, inst[19:15], inst[24:20], inst[11:7], result, reg1, reg2);

    ALU alu (ALUcontrol, toALU1, toALU2, zero, sign, ALUout);

    immediate_extend IE (IMMsrc, inst[31:7], IMMout);

    MUX2to1 mux2 (adrsrc, PCout, result, toMemory);
    MUX3to1 mux3A (ALUsrcA, PCout, oldPCout, Aout, toALU1);
    MUX3to1 mux3B (ALUsrcB, Bout, IMMout, 32'd4, toALU2);
    MUX4to1 mux4 (resultsrc, toResult, ALUout, data, IMMout, result);

    assign f3 = inst[14:12];
    assign f7 = inst[31:25];
    assign opc = inst[6:0];

endmodule