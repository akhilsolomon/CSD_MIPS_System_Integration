module top_mips_zybo (
    input  wire clk,          // Zybo Z7 board clock (125 MHz)
    input  wire [3:0] sw,     // switches
    output wire [3:0] led     // LEDs
);

    // Clock divider for visible activity
    reg [25:0] clk_div = 0;
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    wire slow_clk = clk_div[25];  // ~1 Hz clock

    // Instantiate minimal MIPS CPU
    wire [31:0] mips_out;
    mips_simple_cpu cpu (
        .clk   (slow_clk),
        .reset (sw[0]),        // SW0 is reset
        .out   (mips_out)
    );

    // Drive LEDs with lowest 4 bits of MIPS output
    assign led = mips_out[3:0];

endmodule
