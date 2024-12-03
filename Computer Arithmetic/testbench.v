`timescale 1ns/1ns

module testbench ();
	reg [9:0] a_in = 10'b0011001000, b_in = 10'b0001010000;
	reg clk = 1'b0, sclr = 1'b0, start = 1'b0;
	wire [9:0] q_out;
	wire dvz, ovf, busy, valid;

	divider divide (a_in, b_in, clk, sclr, start, q_out, dvz, ovf, busy, valid);

	always #100 clk = ~clk;

	initial begin
		#220 start = 1'b1;
		#210 start = 1'b0;
	end
endmodule