`timescale 1ns/1ns

module testbench ();

    reg clk = 1'b0, rst = 1'b0;

    toplevel TL (clk, rst);

    always #5 clk = ~clk;
    initial begin
        #11 rst = 1'b1;
        #11 rst = 1'b0;
        #5000 $stop;
    end


endmodule