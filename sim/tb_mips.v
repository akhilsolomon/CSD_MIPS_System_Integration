`timescale 1ns/1ps
module tb_mips;

    reg clk = 0;
    reg reset = 0;
    wire [31:0] out;

    // Generate clock
    always #5 clk = ~clk;

    // Instantiate CPU
    mips_simple_cpu uut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    initial begin
        $display("Starting simulation...");
        reset = 1; #20;
        reset = 0;
        #200;
        $display("Output: %d", out);
        $stop;
    end
endmodule
