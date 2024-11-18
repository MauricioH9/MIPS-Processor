`timescale 1ns / 1ps

module I_DECODE_tb;

    reg clk;
    reg reset;
    reg [31:0] if_id_instr_tb;
    reg [31:0] if_id_npc_tb;
    reg [4:0] mem_wb_writereg_tb;
    reg [31:0] mem_wb_writedata_tb;
    reg mem_wb_regwrite_tb;

    wire [3:0] ex_control_tb;
    wire [2:0] mem_control_tb;
    wire [1:0] wb_control_tb;
    wire [31:0] ex_npc_tb;
    wire [31:0] ex_reg_rs_tb;
    wire [31:0] ex_reg_rt_tb;
    wire [31:0] ex_sign_ext_tb;
    wire [4:0] ex_instr_rt_tb;
    wire [4:0] ex_instr_rd_tb;

    // Instantiate I_DECODE module
    I_DECODE I_DECODE_uut (
        .clk(clk),
        .reset(reset),
        .if_id_instr(if_id_instr_tb),
        .if_id_npc(if_id_npc_tb),
        .mem_wb_writereg(mem_wb_writereg_tb),
        .mem_wb_writedata(mem_wb_writedata_tb),
        .mem_wb_regwrite(mem_wb_regwrite_tb),
        .ex_control(ex_control_tb),
        .mem_control(mem_control_tb),
        .wb_control(wb_control_tb),
        .ex_npc(ex_npc_tb),
        .ex_reg_rs(ex_reg_rs_tb),
        .ex_reg_rt(ex_reg_rt_tb),
        .ex_sign_ext(ex_sign_ext_tb),
        .ex_instr_rt(ex_instr_rt_tb),
        .ex_instr_rd(ex_instr_rd_tb)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize all signals
        reset = 1;
        if_id_instr_tb = 32'b0;
        if_id_npc_tb = 32'b0;
        mem_wb_writereg_tb = 5'b0;
        mem_wb_writedata_tb = 32'b0;
        mem_wb_regwrite_tb = 0;

        // Reset the module
        #10 reset = 0;

        // Test Case 1: Load R-type instruction
        if_id_instr_tb = 32'b000000_00001_00010_00011_00000_100000; // add $3, $1, $2
        if_id_npc_tb = 32'h4;
        #10;
        $display("TC1: R-type Instruction | ex_control=%b | mem_control=%b | wb_control=%b | ex_npc=%0d | ex_reg_rs=%0d | ex_reg_rt=%0d | ex_sign_ext=%0d | ex_instr_rt=%b | ex_instr_rd=%b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        // Test Case 2: Load lw instruction
        if_id_instr_tb = 32'b100011_00001_00010_0000000000000100; // lw $2, 4($1)
        if_id_npc_tb = 32'h8;
        #10;
        $display("TC2: lw Instruction | ex_control=%b | mem_control=%b | wb_control=%b | ex_npc=%0d | ex_reg_rs=%0d | ex_reg_rt=%0d | ex_sign_ext=%0d | ex_instr_rt=%b | ex_instr_rd=%b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        // Test Case 3: Load sw instruction
        if_id_instr_tb = 32'b101011_00001_00010_0000000000001000; // sw $2, 8($1)
        if_id_npc_tb = 32'hC;
        #10;
        $display("TC3: sw Instruction | ex_control=%b | mem_control=%b | wb_control=%b | ex_npc=%0d | ex_reg_rs=%0d | ex_reg_rt=%0d | ex_sign_ext=%0d | ex_instr_rt=%b | ex_instr_rd=%b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        // Test Case 4: Write-back to register file
        mem_wb_regwrite_tb = 1;
        mem_wb_writereg_tb = 5'b00010; // Write to $2
        mem_wb_writedata_tb = 32'd123;
        #10;
        if_id_instr_tb = 32'b100011_00001_00010_0000000000000100; // lw $2, 4($1)
        if_id_npc_tb = 32'h10;
        $display("TC4: Write-back Test | ex_control=%b | mem_control=%b | wb_control=%b | ex_npc=%0d | ex_reg_rs=%0d | ex_reg_rt=%0d | ex_sign_ext=%0d | ex_instr_rt=%b | ex_instr_rd=%b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        // End simulation
        $stop;
    end
endmodule
