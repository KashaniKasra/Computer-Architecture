module divider (input [9:0] a_in, b_in, input clk, sclr, start, output [9:0] q_out, output dvz, ovf, busy, valid);
	wire ldA, ldB, ldQ, set0Q, shQ, selectQ, ldACC, set0ACC, shACC, ldQnxt, shQnxt,
	     selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt, GTE, can_ov, co_cnt;
	wire [3:0] num_cnt;

	datapath DP (a_in, b_in, clk, sclr, ldA, ldB, ldQ, set0Q, shQ, 1'b0, selectQ, ldACC, set0ACC, shACC, ldQnxt, shQnxt,
		     1'b0, 1'b1, selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt, q_out, dvz, GTE, can_ov, co_cnt, num_cnt);

	controller CL (num_cnt, clk, sclr, start, dvz, GTE, can_ov, co_cnt, ovf, busy, valid, ldA, ldB, ldQ, set0Q, shQ, selectQ,
		       ldACC, set0ACC, shACC, ldQnxt, shQnxt, selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt);
endmodule