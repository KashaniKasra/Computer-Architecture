module register (input [9:0] in, input clock, reset, load, output reg [9:0] out);
	always @(posedge clock) begin
		if (reset)
			out <= 10'b0;
		else if (load)
			out <= in;
	end
endmodule

module shiftL_register #(parameter n) (input [n - 1:0] in, input clock, reset, load, shift, clear, serin, output reg [n - 1:0] out, output reg serout);
	always @(posedge clock) begin
		if (reset)
			out <= {n * 1'b0};
		else if (clear)
			out <= {n * 1'b0};
		else if (load)
			out <= in;
		else if (shift)
			{serout, out} <= {out, serin};
	end
endmodule

module counter_14modulo (input clock, reset, clear1, count, output reg [3:0] num, output co);
	always @(posedge clock) begin
		if (reset)
			num <= 4'b0;
		else if (clear1)
			num <= 4'b0001;
		else if (count)
			num <= num + 1;
	end
	assign co = &num;
endmodule

module oring #(parameter n) (input [n - 1:0] A, output reg W);
	always @(A) begin
		W = |A;
	end
endmodule

module comparator (input [10:0] A, B, output reg GTE);
	always @(A, B) begin
		if (A < B)
			GTE <= 1'b0;
		else
			GTE <= 1'b1;
	end
endmodule

module subtractor (input [10:0] A, B, output reg [10:0] W);
	always @(A, B) begin
		W <= A - B;
	end
endmodule

module mux1bit_2to1 (input A, B, select, output reg W);
	always @(A, B, select) begin
		if (select)
			W <= A;
		else
			W <= B;
	end
endmodule

module mux10bit_2to1 (input [9:0] A, B, input select, output reg [9:0] W);
	always @(A, B, select) begin
		if (select)
			W <= A;
		else
			W <= B;
	end
endmodule

module mux11bit_2to1 (input [10:0] A, B, input select, output reg [10:0] W);
	always @(A, B, select) begin
		if (select)
			W <= A;
		else
			W <= B;
	end
endmodule