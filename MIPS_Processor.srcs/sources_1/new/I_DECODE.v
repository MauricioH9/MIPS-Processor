`timescale 1ns / 1ps

module I_DECODE(
    input wire clk,                  
    input wire reset,                
    input wire [31:0] if_id_instr,     // Instruction from IF/ID  
    input wire [31:0] if_id_npc,       // Next Program Counter from IF/ID
    input wire [4:0] mem_wb_writereg,  // Write register address from MEM/WB stage
    input wire [31:0] mem_wb_writedata,// Write data from MEM/WB stage
    input wire mem_wb_regwrite,        // Write enable signal from MEM/WB stage

    // Outputs to EX stage
    output wire [3:0] ex_control,      // EX control signals
    output wire [2:0] mem_control,     // MEM control signals
    output wire [1:0] wb_control,      // WB control signals
    output wire [31:0] ex_npc,         // Forwarded NPC
    output wire [31:0] ex_reg_rs,      // Register RS 
    output wire [31:0] ex_reg_rt,      // Register RT 
    output wire [31:0] ex_sign_ext,    // Sign-extended immediate value
    output wire [4:0] ex_instr_rt,     // Instruction [20:16]
    output wire [4:0] ex_instr_rd      // Instruction [15:11]
);

    // Internal signals
    wire [3:0] controlEX;              // Control signals for EX
    wire [2:0] controlMEM;             // Control signals for MEM
    wire [1:0] controlWB;              // Control signals for WB
    wire [31:0] reg_rs;                // Register RS 
    wire [31:0] reg_rt;                // Register RT 
    wire [31:0] sign_extended;         // Sign-extended immediate value
    wire [4:0] instr_rt;               // Instruction [20:16]
    wire [4:0] instr_rd;               // Instruction [15:11]
    wire [5:0] opcode;                 // Opcode field from instruction
    wire [4:0] rs;                     // RS field from instruction
    wire [4:0] rt;                     // RT field from instruction
    wire [4:0] rd;                     // RD field from instruction
    wire [15:0] immediate;             // Immediate field from instruction

    // Extract fields from the instruction
    assign opcode = if_id_instr[31:26];
    assign rs = if_id_instr[25:21];
    assign rt = if_id_instr[20:16];
    assign rd = if_id_instr[15:11];
    assign immediate = if_id_instr[15:0];
    assign instr_rt = rt;              // Forward instruction field [20:16]
    assign instr_rd = rd;              // Forward instruction field [15:11]

    // Instantiations 
    control control_ID (
        .opcode(opcode),
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB)
    );

    registers registers_ID (
        .clk(clk),
        .RegWrite(mem_wb_regwrite),     
        .rs(rs),                       
        .rt(rt),                        
        .rd(mem_wb_writereg),          
        .write_data(mem_wb_writedata),  
        .read_data_rs(reg_rs),          
        .read_data_rt(reg_rt)          
    );

    s_extend s_extend_ID (
        .immediate(immediate),
        .sign_extended(sign_extended)
    );

    id_ex id_ex_ID (
        .clk(clk),
        .reset(reset),
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB),
        .if_id_npc(if_id_npc),
        .reg_rs(reg_rs),
        .reg_rt(reg_rt),
        .sign_ext(sign_extended),
        .instr_rt(instr_rt),
        .instr_rd(instr_rd),
        .ex_control(ex_control),
        .mem_control(mem_control),
        .wb_control(wb_control),
        .ex_npc(ex_npc),
        .ex_reg_rs(ex_reg_rs),
        .ex_reg_rt(ex_reg_rt),
        .ex_sign_ext(ex_sign_ext),
        .ex_instr_rt(ex_instr_rt),
        .ex_instr_rd(ex_instr_rd)
    );

endmodule
