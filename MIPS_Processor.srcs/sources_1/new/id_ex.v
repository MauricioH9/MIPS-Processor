`timescale 1ns / 1ps

module id_ex(
    input wire clk,                
    input wire reset,              

    // Inputs from CONTROL
    input wire [3:0] controlEX,    // [RegDst, ALUOp (2 bits), ALUSrc]
    input wire [2:0] controlMEM,   // [Branch, MemRead, MemWrite]
    input wire [1:0] controlWB,    // [RegWrite, MemToReg]

    // Inputs from IF/ID pipeline register
    input wire [31:0] if_id_npc,   // NPC (Next Program Counter)
    input wire [31:0] reg_rs,      // Data from register rs
    input wire [31:0] reg_rt,      // Data from register rt
    input wire [31:0] sign_ext,    // Sign-extended immediate value
    input wire [4:0] instr_rt,     // Instr[20-16]
    input wire [4:0] instr_rd,     // Instr[15-11]

    // Outputs to EX stage
    output reg [3:0] ex_control,   // [RegDst, ALUOp (2 bits), ALUSrc]
    output reg [2:0] mem_control,  // [Branch, MemRead, MemWrite]
    output reg [1:0] wb_control,   // [RegWrite, MemToReg]
    output reg [31:0] ex_npc,      // NPC for the next stage
    output reg [31:0] ex_reg_rs,   // Data from register rs
    output reg [31:0] ex_reg_rt,   // Data from register rt
    output reg [31:0] ex_sign_ext, // Sign-extended immediate value
    output reg [4:0] ex_instr_rt,  // Instr[20-16]
    output reg [4:0] ex_instr_rd   // Instr[15-11]
);

    initial begin
        ex_control = 4'b0;
        mem_control = 3'b0;
        wb_control = 2'b0;
        ex_npc = 32'b0;
        ex_reg_rs = 32'b0;
        ex_reg_rt = 32'b0;
        ex_sign_ext = 32'b0;
        ex_instr_rt = 5'b0;
        ex_instr_rd = 5'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Clear all outputs 
            ex_control <= 4'b0;
            mem_control <= 3'b0;
            wb_control <= 2'b0;
            ex_npc <= 32'b0;
            ex_reg_rs <= 32'b0;
            ex_reg_rt <= 32'b0;
            ex_sign_ext <= 32'b0;
            ex_instr_rt <= 5'b0;
            ex_instr_rd <= 5'b0;
        end else begin
            // Transfer inputs to outputs
            ex_control <= controlEX;
            mem_control <= controlMEM;
            wb_control <= controlWB;
            ex_npc <= if_id_npc;
            ex_reg_rs <= reg_rs;
            ex_reg_rt <= reg_rt;
            ex_sign_ext <= sign_ext;
            ex_instr_rt <= instr_rt;
            ex_instr_rd <= instr_rd;
        end
    end

endmodule
