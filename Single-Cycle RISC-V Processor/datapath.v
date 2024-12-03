module datapath (input clk, rst, regwrite, memwrite, ALUsrc, input [1:0] resultsrc, PCsrc, input [2:0] ALUcontrol, IMMsrc,
                 output zero, sign, output [2:0] f3, output [6:0] f7, opc);

    wire [31:0] toPC, PCout, inst, result, reg1, reg2, data, ALUout, IMMout, PCimm, PC4;
    wire signed [31:0] toALU;

    PC pc (clk, rst, toPC, PCout);
    instruction_memory IM (PCout, inst);
    register_file RF (clk, regwrite, inst[19:15], inst[24:20], inst[11:7], result, reg1, reg2);
    ALU alu (ALUcontrol, reg1, toALU, zero, sign, ALUout);
    data_memory DM (clk, memwrite, ALUout, reg2, data);
    immediate_extend IE (IMMsrc, inst[31:7], IMMout);
    adder add1 (PCout, IMMout, PCimm);
    adder add2 (PCout, 32'd4, PC4);
    MUX2to1 mux2 (ALUsrc, reg2, IMMout, toALU);
    MUX3to1 mux3 (PCsrc, PC4, PCimm, ALUout, toPC);
    MUX4to1 mux4 (resultsrc, ALUout, data, PC4, IMMout, result);

    assign f3 = inst[14:12];
    assign f7 = inst[31:25];
    assign opc = inst[6:0];

endmodule