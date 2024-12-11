`timescale 1ns / 1ps

module EXECUTE(
    input wire clk,
    input wire reset,

    // Inputs from ID/EX stage
    input wire [1:0] wb_control_in,         // WB control from ID/EX
    input wire [2:0] mem_control_in,        // MEM control from ID/EX
    input wire [3:0] ex_control_in,         // EX control from ID/EX
    input wire [31:0] npc_in,               // Next PC from ID/EX
    input wire [31:0] reg_rs_in,            // Data from register RS
    input wire [31:0] reg_rt_in,            // Data from register RT
    input wire [31:0] sign_extended_in,     // Sign-extended immediate value
    input wire [4:0] instr_rt_in,           // Register RT field
    input wire [4:0] instr_rd_in,           // Register RD field
    input wire [5:0] instr_function_in,     // Function field for R-type
    // Outputs to EX/MEM stage
    output wire [1:0] wb_control_out,       // WB control to EX/MEM
    output wire [2:0] mem_control_out,      // MEM control to EX/MEM
    output wire [31:0] alu_result_out,      // ALU result
    output wire alu_zero_out,               // Zero flag from ALU
    output wire [31:0] reg_rt_out,          // Data to be written to memory
    output wire [4:0] write_reg_out         // Destination register
);

    // Internal wires
    wire [31:0] alu_operand2;               // Operand 2 for the ALU
    wire [2:0] alu_control;                 // ALU control signals
    wire [4:0] write_register;              // Write-back destination register
    wire [31:0] branch_target;              // Branch target address
    wire [31:0] alu_result_in;

    // Component 1: Adder 
    adder branch_adder_EX (
        .A(npc_in), 
        .B(sign_extended_in), 
        .Sum(branch_target)
    );

    // Component 2: 32-bit mux (from IF Stage) for ALUSrc
    mux_32bit ALUSrc_mux_32bit_EX (
        .a(reg_rt_in),             // Register RT
        .b(sign_extended_in),      // Sign-extended immediate
        .sel(ex_control_in[0]),    // ALUSrc
        .y(alu_operand2)           // Operand for ALU
    );

    // Component 3: ALU
    alu alu_EX (
        .A(reg_rs_in),             // Register RS
        .B(alu_operand2),          // Operand 2 (from mux)
        .ALUControl(alu_control),  // ALU control signals
        .Result(alu_result_in),   // ALU computation result
        .Zero(alu_zero_out)        // Zero flag
    );

    // Component 4: ALU Control
    alu_control alu_control_EX (
        .ALUOp(ex_control_in[2:1]),    // ALUOp from EX control signals
        .Function(instr_function_in), // Function field from instruction
        .ALUControl(alu_control)      // ALU control signals
    );

    // Component 5: 5-bit mux for RegDst
    mux_5bit RegDst_mux_EX (
        .a(instr_rt_in),           // RT field
        .b(instr_rd_in),           // RD field
        .sel(ex_control_in[3]),    // RegDst
        .y(write_register)         // Destination register
    );

    // Component 6: EX/MEM Register
    ex_mem ex_mem_EX (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),     // WB control from ID/EX
        .mem_control_in(mem_control_in),   // MEM control from ID/EX
        .alu_result_in(alu_result_in),    // ALU computation result
        .reg_rt_in(reg_rt_in),             // Register RT value
        .write_reg_in(write_register),     // Write-back register
        .wb_control_out(wb_control_out),   // WB control to EX/MEM
        .mem_control_out(mem_control_out), // MEM control to EX/MEM
        .alu_result_out(alu_result_out),   // ALU computation result
        .reg_rt_out(reg_rt_out),           // Data to memory
        .write_reg_out(write_reg_out)      // Write-back register
    );

endmodule
