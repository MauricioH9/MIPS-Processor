`timescale 1ns / 1ps

module PIPELINE_tb;

    reg clk;
    reg reset;

    // IF
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;

    // ID
    wire [3:0] id_ex_control_ex;
    wire [2:0] id_ex_control_mem;
    wire [1:0] id_ex_control_wb;
    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_reg_rs;
    wire [31:0] id_ex_reg_rt;
    wire [31:0] id_ex_sign_ext;
    wire [4:0] id_ex_instr_rt;
    wire [4:0] id_ex_instr_rd;

    // EX
    wire [1:0] ex_mem_control_wb;
    wire [2:0] ex_mem_control_mem;
    wire [31:0] ex_mem_alu_result;
    wire [31:0] ex_mem_reg_rt;
    wire ex_mem_alu_zero;
    wire [4:0] ex_mem_write_reg;

    // MEM
    wire [1:0] mem_wb_control_wb;
    wire [31:0] mem_wb_read_data;
    wire [31:0] mem_wb_alu_result;
    wire [4:0] mem_wb_write_reg;

    // WB
    wire [31:0] wb_write_data;
    wire wb_reg_write;

    // Branch
    wire branch_taken;
    wire [31:0] ex_mem_branch_target;

    // Instantiate PIPELINE module
    PIPELINE PIPELINE_uut (
        .clk(clk),
        .reset(reset),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .id_ex_control_ex(id_ex_control_ex),
        .id_ex_control_mem(id_ex_control_mem),
        .id_ex_control_wb(id_ex_control_wb),
        .id_ex_npc(id_ex_npc),
        .id_ex_reg_rs(id_ex_reg_rs),
        .id_ex_reg_rt(id_ex_reg_rt),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_rt(id_ex_instr_rt),
        .id_ex_instr_rd(id_ex_instr_rd),
        .ex_mem_control_wb(ex_mem_control_wb),
        .ex_mem_control_mem(ex_mem_control_mem),
        .ex_mem_alu_result(ex_mem_alu_result),
        .ex_mem_reg_rt(ex_mem_reg_rt),
        .ex_mem_alu_zero(ex_mem_alu_zero),
        .ex_mem_write_reg(ex_mem_write_reg),
        .mem_wb_control_wb(mem_wb_control_wb),
        .mem_wb_read_data(mem_wb_read_data),
        .mem_wb_alu_result(mem_wb_alu_result),
        .mem_wb_write_reg(mem_wb_write_reg),
        .wb_write_data(wb_write_data),
        .wb_reg_write(wb_reg_write),
        .branch_taken(branch_taken),
        .ex_mem_branch_target(ex_mem_branch_target)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test cases
    initial begin
        $monitor("Time=%0t | Reset=%b | IF/ID_instr=%h | ID/EX_NPC=%h | EX/MEM_ALUResult=%h | MEM/WB_WriteData=%h | BranchTaken=%b",
                 $time, reset, if_id_instr, id_ex_npc, ex_mem_alu_result, wb_write_data, branch_taken);

        // Initialize signals
        reset = 1;
        #10 reset = 0;  // Release reset

        // Test case 1: Normal pipeline operation
        #100;

        // Test case 2: Simulate branch operation
        #100;

        // Test case 3: Memory write and read operations
        #100;

        $stop;
    end

endmodule
