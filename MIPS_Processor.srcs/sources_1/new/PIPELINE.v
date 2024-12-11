`timescale 1ns / 1ps

module PIPELINE(
    input wire clk,
    input wire reset,
    // IF to ID
    
    output wire [31:0] if_id_instr,
    output wire [31:0] if_id_npc,
    
    // ID to EX
    output wire [3:0] id_ex_control_ex,
    output wire [2:0] id_ex_control_mem,
    output wire [1:0] id_ex_control_wb,
    output wire [31:0] id_ex_npc,
    output wire [31:0] id_ex_reg_rs,
    output wire [31:0] id_ex_reg_rt,
    output wire [31:0] id_ex_sign_ext,
    output wire [4:0] id_ex_instr_rt,
    output wire [4:0] id_ex_instr_rd,
    
    //EX to MEM
    output wire [1:0] ex_mem_control_wb,
    output wire [2:0] ex_mem_control_mem,
    output wire [31:0] ex_mem_alu_result,
    output wire [31:0] ex_mem_reg_rt,
    output wire ex_mem_alu_zero,
    output wire [4:0] ex_mem_write_reg,
    
    // MEM to WB
    output wire [1:0] mem_wb_control_wb,
    output wire [31:0] mem_wb_read_data,
    output wire [31:0] mem_wb_alu_result,
    output wire [4:0] mem_wb_write_reg,
    
    // WB to ID
    output wire [31:0] wb_write_data,
    output wire wb_reg_write,
    
    // Branch handling
    output wire branch_taken,
    output wire [31:0] ex_mem_branch_target
);

    // Instruction Fetch (IF) Stage
    I_FETCH I_FETCH (
        .clk(clk),
        .reset(reset),
        .IF_ID_instr(if_id_instr),
        .IF_ID_npc(if_id_npc),
        .EX_MEM_PCSrc(branch_taken),
        .EX_MEM_NPC(ex_mem_branch_target)
    );

    // Instruction Decode (ID) Stage
    I_DECODE I_DECODE (
        .clk(clk),
        .reset(reset),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .mem_wb_writereg(mem_wb_write_reg),
        .mem_wb_writedata(wb_write_data),
        .mem_wb_regwrite(wb_reg_write),
        .ex_control(id_ex_control_ex),
        .mem_control(id_ex_control_mem),
        .wb_control(id_ex_control_wb),
        .ex_npc(id_ex_npc),
        .ex_reg_rs(id_ex_reg_rs),
        .ex_reg_rt(id_ex_reg_rt),
        .ex_sign_ext(id_ex_sign_ext),
        .ex_instr_rt(id_ex_instr_rt),
        .ex_instr_rd(id_ex_instr_rd)
    );

    // Execution (EX) Stage
    EXECUTE EXECUTE (
        .clk(clk),
        .reset(reset),
        .wb_control_in(id_ex_control_wb),
        .mem_control_in(id_ex_control_mem),
        .ex_control_in(id_ex_control_ex),
        .npc_in(id_ex_npc),
        .reg_rs_in(id_ex_reg_rs),
        .reg_rt_in(id_ex_reg_rt),
        .sign_extended_in(id_ex_sign_ext),
        .instr_rt_in(id_ex_instr_rt),
        .instr_rd_in(id_ex_instr_rd),
        .instr_function_in(id_ex_control_ex[3:0]),
        .wb_control_out(ex_mem_control_wb),
        .mem_control_out(ex_mem_control_mem),
        .alu_result_out(ex_mem_alu_result),
        .alu_zero_out(ex_mem_alu_zero),
        .reg_rt_out(ex_mem_reg_rt),
        .write_reg_out(ex_mem_write_reg)
    );

    // Memory (MEM) Stage
    MEMORY MEMORY (
        .clk(clk),
        .reset(reset),
        .wb_control_in(ex_mem_control_wb),
        .mem_control_in(ex_mem_control_mem),
        .alu_result_in(ex_mem_alu_result),
        .reg_rt_in(ex_mem_reg_rt),
        .alu_zero_in(ex_mem_alu_zero),
        .write_reg_in(ex_mem_write_reg),
        .wb_control_out(mem_wb_control_wb),
        .read_data_out(mem_wb_read_data),
        .alu_result_out(mem_wb_alu_result),
        .write_reg_out(mem_wb_write_reg),
        .branch_taken(branch_taken)
    );

    // Write-Back (WB) Stage
    WRITE_BACK WRITE_BACK (
        .ReadData(mem_wb_read_data),
        .ALUResult(mem_wb_alu_result),
        .MemToReg(mem_wb_control_wb[0]),
        .WriteData(wb_write_data)
    );

    // Forward control signal for WB register write
    assign wb_reg_write = mem_wb_control_wb[1];

endmodule
