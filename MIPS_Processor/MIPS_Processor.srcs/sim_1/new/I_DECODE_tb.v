`timescale 1ns / 1ps

module I_DECODE_tb;

    // Inputs
    reg clk;
    reg write_en;
    reg rst;
    reg [4:0] rd;
    reg [31:0] write_data;
    reg [31:0] instr_in;
    reg [31:0] npc_in;

    // Outputs
    wire [1:0] wb_out;
    wire [2:0] m_out;
    wire [3:0] ex_out;
    wire [4:0] instr_2016_out, instr_1511_out;
    wire [31:0] rdat1_out, rdat2_out;
    wire [31:0] npc_out;
    wire [31:0] latch_signext_out;

    // Register output signals
    wire [31:0] latch_reg0_out, latch_reg1_out, latch_reg2_out, latch_reg3_out;
    wire [31:0] latch_reg4_out, latch_reg5_out, latch_reg6_out, latch_reg7_out;
    wire [31:0] latch_reg8_out, latch_reg9_out;

    // Instantiate the Unit Under Test (UUT)
    I_DECODE I_DECODE_uut (
        .clk(clk),
        .write_en(write_en),
        .rst(rst),
        .rd(rd),
        .write_data(write_data),
        .instr_in(instr_in),
        .npc_in(npc_in),
        .wb_out(wb_out),
        .m_out(m_out),
        .ex_out(ex_out),
        .instr_2016_out(instr_2016_out),
        .instr_1511_out(instr_1511_out),
        .rdat1_out(rdat1_out),
        .rdat2_out(rdat2_out),
        .npc_out(npc_out),
        .latch_signext_out(latch_signext_out),
        .latch_reg0_out(latch_reg0_out),
        .latch_reg1_out(latch_reg1_out),
        .latch_reg2_out(latch_reg2_out),
        .latch_reg3_out(latch_reg3_out),
        .latch_reg4_out(latch_reg4_out),
        .latch_reg5_out(latch_reg5_out),
        .latch_reg6_out(latch_reg6_out),
        .latch_reg7_out(latch_reg7_out),
        .latch_reg8_out(latch_reg8_out),
        .latch_reg9_out(latch_reg9_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Monitor signals
        $monitor("Time=%0t | WB_out=%b | M_out=%b | EX_out=%b | Instr_2016=%b | Instr_1511=%b | RDat1=%h | RDat2=%h | NPC_out=%h | Latch_SignExt=%h",
                 $time, wb_out, m_out, ex_out, instr_2016_out, instr_1511_out, rdat1_out, rdat2_out, npc_out, latch_signext_out);

        // Initialize inputs
        rst = 1;
        write_en = 0;
        rd = 5'b0;
        write_data = 32'h00000000;
        instr_in = 32'h00000000;
        npc_in = 32'h00000000;

        // Reset the module
        #10 rst = 0;

        // Test Case 1: Normal operation with a valid instruction
        #10 instr_in = 32'h8C220004;  // Opcode: LW, RS: 1, RT: 2, Offset: 4
        npc_in = 32'h00000004;

        // Test Case 2: Write to a register
        #10 write_en = 1;
            rd = 5'b00010;  // RT: 2
            write_data = 32'hA5A5A5A5;

        // Test Case 3: Reset while writing
        #10 rst = 1;

        // Test Case 4: Another instruction after reset
        #10 rst = 0;
            instr_in = 32'hAC230008;  // Opcode: SW, RS: 1, RT: 3, Offset: 8
            npc_in = 32'h00000008;

        // End simulation
        #50 $stop;
    end

endmodule
