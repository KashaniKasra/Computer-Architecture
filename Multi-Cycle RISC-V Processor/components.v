module register32 (input clk, rst, load, input [31:0] in, output reg [31:0] out);

    always @(posedge clk, posedge rst) begin 
    if (rst)
        out <= 32'b0;
    else if (load)
        out <= in;
    end

endmodule

module memory (input clk, we, input [31:0] Adr, WD, output [31:0] RD);

    reg [7:0] memory [0:127];

    initial $readmemb ("memory.mem", memory);

    assign RD = {memory[Adr + 3], memory[Adr + 2], memory[Adr + 1], memory[Adr]};

    always @(posedge clk) begin
        if (we)
            {memory[Adr + 3], memory[Adr + 2], memory[Adr + 1], memory[Adr]} <= WD;
    end

endmodule

module register_file (input clk, we, input [4:0] A1, A2, A3, input [31:0] WD, output [31:0] RD1, RD2);
    
    reg [31:0] Rmemory [0:31];

    initial Rmemory[0] = 32'b0;

    assign RD1 = Rmemory[A1];
    assign RD2 = Rmemory[A2];

    always @(posedge clk) begin
        if (we)
            if (A3 != 5'b0)
                Rmemory[A3] <= WD; 
    end

endmodule

module ALU (input [2:0] ALUcontrol, input signed [31:0] A, B, output zero, sign, output reg signed [31:0] y);

    always @(ALUcontrol, A, B) begin
        case (ALUcontrol)
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

module immediate_extend (input [2:0] IMMslc, input [31:7] imm, output reg [31:0] ext);

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