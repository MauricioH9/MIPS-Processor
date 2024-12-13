`timescale 1ns / 1ps

module EXECUTE_tb;

    // Inputs
    reg clk, rst;
    reg [1:0] wb_ctl;
    reg [2:0] m_ctl;
    reg [3:0] ex_ctl;
    reg [4:0] instr_2016, instr_1511;
    reg [31:0] npc_out, rdat1, rdat2, sign_ext;

    // Outputs
    wire alu_zero;
    wire [1:0] mem_wb;
    wire [2:0] mem_m;
    wire [4:0] mux5_out;
    wire [31:0] adder_out, alu_result, dat2_mem;

    // Instantiate the EXECUTE module
    EXECUTE EXECUTE_uut (
        .clk(clk),
        .rst(rst),
        .wb_ctl(wb_ctl),
        .m_ctl(m_ctl),
        .ex_ctl(ex_ctl),
        .instr_2016(instr_2016),
        .instr_1511(instr_1511),
        .npc_out(npc_out),
        .rdat1(rdat1),
        .rdat2(rdat2),
        .sign_ext(sign_ext),
        .alu_zero(alu_zero),
        .mem_wb(mem_wb),
        .mem_m(mem_m),
        .mux5_out(mux5_out),
        .adder_out(adder_out),
        .alu_result(alu_result),
        .dat2_mem(dat2_mem)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
        rst = 1;
        wb_ctl = 2'b00;
        m_ctl = 3'b000;
        ex_ctl = 4'b0000;
        instr_2016 = 5'b00000;
        instr_1511 = 5'b00000;
        npc_out = 32'h00000000;
        rdat1 = 32'h00000000;
        rdat2 = 32'h00000000;
        sign_ext = 32'h00000000;

        // Reset
        #10 rst = 0;

        // Test Case 1: ADD operation
        wb_ctl = 2'b10;
        m_ctl = 3'b010;
        ex_ctl = 4'b0010; // ALUOp = 10 (R-type), ALUSrc = 0
        npc_out = 32'h4;
        rdat1 = 32'h00000005;
        rdat2 = 32'h00000003;
        sign_ext = 32'h00000000;
        instr_2016 = 5'b00010;
        instr_1511 = 5'b00011;
        #10;

        // Test Case 2: SUB operation
        ex_ctl = 4'b0110; // ALUOp = 01 (SUB)
        rdat1 = 32'h0000000A;
        rdat2 = 32'h00000005;
        sign_ext = 32'h00000000;
        #10;

        // Test Case 3: Immediate ADD
        ex_ctl = 4'b0011; // ALUOp = 00 (ADD immediate)
        rdat1 = 32'h0000000F;
        sign_ext = 32'h00000002;
        #10;

        $stop;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | ALUZero=%b | MemWB=%b | MemM=%b | Mux5Out=%b | AdderOut=%h | ALUResult=%h | Dat2Mem=%h", 
                 $time, alu_zero, mem_wb, mem_m, mux5_out, adder_out, alu_result, dat2_mem);
    end

endmodule
