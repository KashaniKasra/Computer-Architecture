module Register #(parameter N) (input clk, rst, en, clr, input [N-1:0] in, output reg [N-1:0] out);

    always @ (posedge clk, posedge rst) begin 
        if (rst)
            out <= {N{1'b0}};
        else if (clr)
            out <= {N{1'b0}};
        else if (~en)
            out <= in;
    end

endmodule

module DFF (input clk, rst, clr, input in, output reg out);

    always @ (posedge clk, posedge rst) begin 
        if (rst)
            out <= 1'b0;
        else if (clr)
            out <= 1'b0;
        else
            out <= in;
    end

endmodule

module Instruction_Memory (input [31:0] A, output [31:0] RD);

    reg [7:0] Imemory [0:63];

    initial $readmemh ("InstMem.mem", Imemory);

    assign RD = {Imemory[A + 3], Imemory[A + 2], Imemory[A + 1], Imemory[A]};

endmodule

module Data_Memory (input clk, we, input [31:0] A, WD, output [31:0] RD);

    reg [7:0] Dmemory [0:127];

    initial $readmemb ("DataMem.mem", Dmemory);

    assign RD = {Dmemory[A + 3], Dmemory[A + 2], Dmemory[A + 1], Dmemory[A]};

    always @(posedge clk) begin
        if (we)
           {Dmemory[A + 3], Dmemory[A + 2], Dmemory[A + 1], Dmemory[A]} <= WD;
        else
            Dmemory[A] <= Dmemory[A];
    end

endmodule

module Register_File (input clk, we, input [4:0] A1, A2, A3, input [31:0] WD3, output [31:0] RD1, RD2);
    
    reg [31:0] Rmemory [0:31];

    initial Rmemory[0] = 32'b0;

    assign RD1 = Rmemory[A1];
    assign RD2 = Rmemory[A2];

    always @(negedge clk) begin
        if ((we == 1) & (A3 != 5'b0))
            Rmemory[A3] <= WD3; 
        else
            Rmemory[A3] <= Rmemory[A3]; 
    end

endmodule

module ALU (input [2:0] ALUControl, input signed [31:0] A, B, output zero, sign, output reg signed [31:0] y);

    always @(ALUControl, A, B) begin
        case (ALUControl)
            3'b000: y = A + B;
            3'b001: y = A - B;
            3'b010: y = A & B;
            3'b011: y = A | B;
            3'b100: y = A ^ B;
            3'b101: y = (A < B) ? 32'd1 : 32'b0;
            3'b110: y = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'b0;
            default: y = 32'b0;
        endcase
    end

    assign zero = (y == 32'b0) ? 1'b1 : 1'b0;
    assign sign = y[31];

endmodule

module Adder (input signed [31:0] A, B, output signed [31:0] Y);

    assign Y = A + B;

endmodule

module MUX2to1 (input MUXcontrol, input [31:0] A, B, output [31:0] Y);

    assign Y = MUXcontrol ? B : A;

endmodule

module MUX3to1 (input [1:0] MUXcontrol, input [31:0] A, B, C, output reg [31:0] Y);
    
    always @(MUXcontrol, A, B, C) begin
        case (MUXcontrol)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            default: Y = 32'b0;
        endcase
    end

endmodule

module MUX4to1 (input [1:0] MUXcontrol, input [31:0] A, B, C, D, output reg [31:0] Y);
    
    always @(MUXcontrol, A, B, C, D) begin
        case (MUXcontrol)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = D;
            default: Y = 32'b0;
        endcase
    end

endmodule

module Immediate_Extend (input [2:0] IMMslc, input [31:7] imm, output reg [31:0] ext);

    always @(IMMslc, imm) begin
        case (IMMslc)
            3'b000: ext = {{20{imm[31]}}, imm[31:20]};   // I_T
            3'b001: ext = {{20{imm[31]}}, imm[31:25], imm[11:7]};   // S_T
            3'b010: ext = {{20{imm[31]}}, imm[7], imm[30:25], imm[11:8], 1'b0};   // B_T
            3'b011: ext = {{12{imm[31]}}, imm[19:12], imm[20], imm[30:21], 1'b0};   // J_T
            3'b100: ext = {imm[31:12], 12'b0};   // U_T
            default: ext = 32'b0;
        endcase
    end

endmodule