module controller (input zero, sign, input [2:0] f3, input [6:0] f7, opc,
                   output reg regwrite, memwrite, ALUsrc, output reg [1:0] resultsrc, PCsrc, output reg [2:0] ALUcontrol, IMMsrc);

    always @(f3, f7, opc) begin
        case (opc)
            7'd3: begin
                {regwrite, IMMsrc, ALUsrc, memwrite, resultsrc} = 8'b10001001;
                if (f3 == 3'd2) begin   // lw
                    ALUcontrol = 3'b000;
                    PCsrc = 2'b00;
                end
            end

            7'd35: begin
                {regwrite, IMMsrc, ALUsrc, memwrite} = 6'b000111;
                if (f3 == 3'd2) begin   // sw
                    ALUcontrol = 3'b000;
                    PCsrc = 2'b00;
                end
            end

            7'd99: begin
                {regwrite, IMMsrc, ALUsrc, memwrite} = 6'b001000;
                if (f3 == 3'd0) begin  // beq
                    ALUcontrol = 3'b001;
                    PCsrc = zero ? 2'b01 : 2'b00;
                end
                else if (f3 == 3'd1) begin   // bne
                    ALUcontrol = 3'b001;   
                    PCsrc = zero ? 2'b00 : 2'b01;
                end
                else if (f3 == 3'd4) begin   // blt
                    ALUcontrol = 3'b001;
                    PCsrc = sign ? 2'b01 : 2'b00;
                end
                else if (f3 == 3'd5) begin   // bge
                    ALUcontrol = 3'b001;  
                    PCsrc = (zero | ~sign) ? 2'b01 : 2'b00; 
                end
            end

            7'd51: begin
                {regwrite, ALUsrc, memwrite, resultsrc} = 5'b10000;
                if ((f3 == 3'd0) & (f7 == 7'd0)) begin  // add
                    ALUcontrol = 3'b000;
                    PCsrc = 2'b00;
                end
                else if ((f3 == 3'd0) & (f7 == 7'd32)) begin   // sub
                    ALUcontrol = 3'b001;
                    PCsrc = 2'b00;
                end
                else if ((f3 == 3'd7) & (f7 == 7'd0)) begin   // and
                    ALUcontrol = 3'b010;
                    PCsrc = 2'b00;
                end
                else if ((f3 == 3'd6) & (f7 == 7'd0)) begin   // or
                    ALUcontrol = 3'b011;
                    PCsrc = 2'b00;
                end
                else if ((f3 == 3'd2) & (f7 == 7'd0)) begin   // slt
                    ALUcontrol = 3'b101;
                    PCsrc = 2'b00;
                end
                else if ((f3 == 3'd3) & (f7 == 7'd0)) begin  // sltu
                    ALUcontrol = 3'b110;
                    PCsrc = 2'b00;
                end
            end

            7'd19: begin
                {regwrite, IMMsrc, ALUsrc, memwrite, resultsrc} = 8'b10001000;
                if (f3 == 3'd0) begin   // addi
                    ALUcontrol = 3'b000;
                    PCsrc = 2'b00;
                end
                else if (f3 == 3'd4) begin   // xori
                    ALUcontrol = 3'b100;
                    PCsrc = 2'b00;
                end
                else if (f3 == 3'd6) begin   // ori
                    ALUcontrol = 3'b011;
                    PCsrc = 2'b00;
                end
                else if (f3 == 3'd2) begin   // slti
                    ALUcontrol = 3'b101;
                    PCsrc = 2'b00;
                end
                else if (f3 == 3'd3) begin   // sltiu
                    ALUcontrol = 3'b110;
                    PCsrc = 2'b00;
                end
            end

            7'd111: begin
                {regwrite, IMMsrc, memwrite, resultsrc} = 7'b1011010;
                PCsrc = 2'b01;   // jal
            end

            7'd55: begin 
                {regwrite, IMMsrc, memwrite, resultsrc} = 7'b1100011;
                PCsrc = 2'b00;   // lui
            end

            7'd103: begin
                {regwrite, IMMsrc, ALUsrc, memwrite, resultsrc} = 8'b10001010;
                if (f3 == 3'd0) begin   // jalr
                    ALUcontrol = 3'b000;
                    PCsrc = 2'b10;
                end
            end

        endcase
    end

endmodule