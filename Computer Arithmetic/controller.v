module controller (input [3:0] num_cnt, input clk, sclr, start, dvz, GTE, can_ov, co_cnt, output reg ov, busy, valid, ldA, ldB, ldQ, set0Q, shQ,
		   selectQ, ldACC, set0ACC, shACC, ldQnxt, shQnxt, selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt);
	parameter [3:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7,
			s8 = 8, s9 = 9, s10 = 10, s11 = 11, s12 = 12, s13 = 13, s14 = 14, s15 = 15;
	reg [3:0] ps, ns;

	always @(posedge clk) begin
		if (sclr)
			ps <= s0;
		else
			ps <= ns;
	end

	always @(ps, start, dvz, GTE, can_ov, num_cnt, co_cnt) begin
		case (ps)
			s0: ns = start ? s1 : s0;
			s1: ns = s2;
			s2: ns = dvz ? s0 : s3;
			s3: ns = s4;
			s4: ns = s5;
			s5: ns = GTE ? s6 : s9;
			s6: ns = s7;
			s7: ns = s8;
			s8: ns = s11;
			s9: ns = s10;
			s10: ns = s11;
			s11: ns = (can_ov == 1'b1 & num_cnt == 4'b1010) ? s14 : s12;
			s12: ns = s13;
			s13: ns = co_cnt ? s14 : s5;
			s14: ns = s0;
			s15: ns = s0;
			default: ns = s0;
		endcase
	end

	always @(ps) begin
		{ov, busy, valid, ldA, ldB, ldQ, set0Q, shQ, selectQ, ldACC, set0ACC, shACC, ldQnxt, shQnxt,
		 selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt} = 20'b0;
		case (ps)
			s0:;
			s1: {ldA, ldB, set0Q, set0ACC, set1_cnt, busy} = 6'b111111;
			s2: {ldQ, selectQ, busy} = 3'b111;
			s3: {shQ, busy} = 2'b11;
			s4: {shACC, busy} = 2'b11;
			s5: busy = 1'b1;
			s6: {ldACCnxt, selectACCnxt, busy} = 3'b101;
			s7: {ldQnxt, busy} = 2'b11;
			s8: {shQnxt, selectQnxt, busy} = 3'b111;
			s9: {ldQnxt, ldACCnxt, selectACCnxt, busy} = 4'b1111;
			s10: {shQnxt, selectQnxt, busy} = 3'b101;
			s11: {shACCnxt, busy} = 2'b11;
			s12: {en_cnt, busy} = 2'b11;
			s13: {ldQ, ldACC, selectQ, busy} = 4'b1101;
			s14: valid = 1'b1;
			s15: ov = 1'b1;
			default:;
		endcase
	end
endmodule