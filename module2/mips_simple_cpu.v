module mips_simple_cpu (
    input  wire clk,
    input  wire reset,
    output reg [31:0] out
);
    reg [31:0] pc;
    reg [31:0] regs[0:31];

    // Instruction memory (hardcoded program)
    reg [31:0] instr_mem [0:15];

    initial begin
        // Demo program:
        // addi $1, $0, 5
        // addi $2, $0, 10
        // add  $3, $1, $2
        // add  $4, $3, $0
        // sw   $4, 0($0) -> output = 15
        instr_mem[0] = 32'h20010005;
        instr_mem[1] = 32'h2002000A;
        instr_mem[2] = 32'h00221820;
        instr_mem[3] = 32'h00602020;
        instr_mem[4] = 32'hAC040000;
    end

    // Simple data memory (just one location mapped to out)
    reg [31:0] mem [0:0];

    always @(posedge clk) begin
        if (reset) begin
            pc  <= 0;
            out <= 0;
        end else begin
            case (instr_mem[pc][31:26])
                6'b001000: begin // addi
                    regs[instr_mem[pc][20:16]] 
                        <= regs[instr_mem[pc][25:21]] 
                           + {{16{instr_mem[pc][15]}}, instr_mem[pc][15:0]};
                end
                6'b000000: begin // R-type
                    if (instr_mem[pc][5:0] == 6'b100000) // add
                        regs[instr_mem[pc][15:11]] 
                            <= regs[instr_mem[pc][25:21]] + regs[instr_mem[pc][20:16]];
                end
                6'b101011: begin // sw
                    mem[0] <= regs[instr_mem[pc][20:16]];
                    out    <= regs[instr_mem[pc][20:16]];
                end
            endcase
            pc <= pc + 1;
        end
    end
endmodule
