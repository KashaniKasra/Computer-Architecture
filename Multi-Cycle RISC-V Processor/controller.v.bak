module controller(input clk, rst, zero, sign, input [2:0] f3, input [6:0] f7, opc, output reg PCwrite, oldPCwrite, IRwrite,
                  memwrite, regwrite, adrsrc, output reg [2:0] IMMsrc, ALUcontrol, output reg [1:0] ALUsrcA, ALUsrcB, resultsrc);

    reg [4:0] ps, ns;
    parameter [4:0] q0 = 0, q1 = 1, q2 = 2, q3 = 3, q4 = 4, q5 = 5, q6 = 6, q7 = 7, q8 = 8, q9 = 9, q10 = 10, q11 = 11,
                    q12 = 12, q13 = 13, q14 = 14, q15 = 15, q16 = 16;

    always @(posedge clk, posedge rst) begin
		if (rst)
			ps <= q0;
		else
			ps <= ns;
	end

	always @(ps, opc) begin
		ns = q0;
		case (ps)
			q0: ns = q1;
			q1: ns = (opc == 7'd51) ? q2 :   // R-T
                     (opc == 7'd19) ? q4 :   // I-T
                     (opc == 7'd99) ? q6 :   // B-T
                     (opc == 7'd55) ? q13 :   // U-T
                     (opc == 7'd35) ? q8 :   // S-T
                     (opc == 7'd3) ? q10 :   // lw
                     (opc == 7'd111) ? q14 :   // jal
                     (opc == 7'd103) ? q16 : q0;  // jalr
			q2: ns = q3;
			q3: ns = q0;
			q4: ns = q5;
			q5: ns = q0;
            q6: ns = q7;
            q7: ns = q0;
            q8: ns = q9;
            q9: ns = q0;
            q10: ns = q11;
            q11: ns = q12;
            q12: ns = q0;
            q13: ns = q0;
            q14: ns = q15;
            q15: ns = q0;
            q16: ns = q15;
			default: ns = q0;
		endcase
	end

    always @(ps, zero, sign, f3, f7) begin
        {PCwrite, oldPCwrite, IRwrite, memwrite, regwrite, adrsrc, IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB, resultsrc} = 18'b0;
        case (ps)
            q0: {PCwrite, oldPCwrite, IRwrite, adrsrc, ALUcontrol, ALUsrcA, ALUsrcB, resultsrc} = 13'b1_1_1_0_000_00_10_01;
			q1: {ALUcontrol, ALUsrcA, ALUsrcB} = 7'b000_01_10;
			q2: begin {ALUsrcA, ALUsrcB} = 7'b10_00;
                    case ({f3, f7})
                        {3'd0, 7'd0}: ALUcontrol = 3'b000;
                        {3'd0, 7'd32}: ALUcontrol = 3'b001;
                        {3'd7, 7'd0}: ALUcontrol = 3'b010;
                        {3'd6, 7'd0}: ALUcontrol = 3'b011;
                        {3'd2, 7'd0}: ALUcontrol = 3'b101;
                        {3'd3, 7'd0}: ALUcontrol = 3'b110;
                    endcase
                end
			q3: {regwrite, resultsrc} = 3'b1_00;
			q4: begin {ALUsrcA, ALUsrcB} = 7'b10_01;
                    case (f3)
                        3'd0: ALUcontrol = 3'b000;
                        3'd4: ALUcontrol = 3'b100;
                        3'd6: ALUcontrol = 3'b011;
                        3'd2: ALUcontrol = 3'b101;
                        3'd3: ALUcontrol = 3'b110;
                    endcase
                end
			q5: {regwrite, resultsrc} = 3'b100;
            q6: {IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB} = 'b010_000_01_01;
            q7: begin {ALUcontrol, ALUsrcA, ALUsrcB, resultsrc} = 9'b001_10_00_00;
                    case (f3) 
                        3'd0: PCwrite = zero;
                        3'd1: PCwrite = ~zero;
                        3'd4: PCwrite = sign;
                        3'd5: PCwrite = zero | ~sign;
                    endcase
                end
            q8: {IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB} = 10'b001_000_10_01;
            q9: {memwrite, adrsrc, resultsrc} = 4'b1_1_00;
            q10: {IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB} = 10'b000_000_10_01;
            q11: {adrsrc, resultsrc} = 3'b1_00;
            q12: {regwrite, resultsrc} = 3'b1_10;
            q13: {regwrite, IMMsrc, resultsrc} = 6'b1_100_11;
            q14: {regwrite, IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB, resultsrc} = 13'b1_011_000_01_01_00;
            q15: {PCwrite, resultsrc} = 3'b1_00;
            q16: {regwrite, IMMsrc, ALUcontrol, ALUsrcA, ALUsrcB, resultsrc} = 13'b1_011_000_10_01_00;
			default:;
        endcase
    end

	
endmodule