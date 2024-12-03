module datapath (input [9:0] a_in, b_in, input clk, sclr, ldA, ldB, ldQ, set0Q, shQ, serinQ, selectQ, ldACC, set0ACC, shACC,
		 ldQnxt, shQnxt, serin0Qnxt, serin1Qnxt, selectQnxt, ldACCnxt, shACCnxt, selectACCnxt, set1_cnt, en_cnt,
		 output [9:0] q_out, output dvz, GTE, can_ov, co_cnt, output [3:0] num_cnt);
	wire [9:0] outA, outB, outQ, outQnxt, outQmux;
	wire [10:0] outACC, sub, outACCnxt, outACCnxtmux;
	wire [3:0] num_cnt_temp;
	wire dvz_temp, can_ov_temp, GTE_temp, co_cnt_temp, seroutQ, seroutACC, seroutQnxt, seroutACCnxt, outQnxtmux;

	register A_reg (a_in, clk, sclr, ldA, outA);
	register B_reg (b_in, clk, sclr, ldB, outB);

	mux1bit_2to1 Qnxt_mux (serin1Qnxt, serin0Qnxt, selectQnxt, outQnxtmux);
	mux10bit_2to1 Q_mux (outA, outQnxt, selectQ, outQmux);
	mux11bit_2to1 ACCnxt_mux (outACC, sub, selectACCnxt, outACCnxtmux);

	shiftL_register #(10) Q_shreg (outQmux, clk, sclr, ldQ, shQ, set0Q, serinQ, outQ, seroutQ);
	shiftL_register #(11) ACC_shreg (outACCnxt, clk, sclr, ldACC, shACC, set0ACC, seroutQ, outACC, seroutACC);
	shiftL_register #(10) Qnxt_shreg (outQ, clk, sclr, ldQnxt, shQnxt, 1'b0, outQnxtmux, outQnxt, seroutQnxt);
	shiftL_register #(11) ACCnxt_shreg (outACCnxtmux, clk, sclr, ldACCnxt, shACCnxt, 1'b0, seroutQnxt, outACCnxt, seroutACCnxt);

	subtractor subtract (outACC, {1'b0, outB}, sub);

	comparator compare (outACC, {1'b0, outB}, GTE_temp);

	oring #(10) oringB (outB, dvz_temp);
	oring #(6) oringQnxt (outQnxt[9:4], can_ov_temp);

	counter_14modulo counter (clk, sclr, set1_cnt, en_cnt, num_cnt_temp, co_cnt_temp);

	assign dvz = ~dvz_temp;
	assign can_ov = can_ov_temp;
	assign GTE = GTE_temp;
	assign co_cnt = co_cnt_temp;
	assign num_cnt = num_cnt_temp;
	assign q_out = outQ;
endmodule