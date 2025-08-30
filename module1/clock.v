module led_blink(
    input wire clk,       // 125 MHz clock from Zybo
    output reg led        // LED0 output
);

    reg [26:0] counter = 0;  // 27-bit counter

    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 125_000_000) begin
            counter <= 0;
            led <= ~led;   // toggle LED every second
        end
    end

endmodule
