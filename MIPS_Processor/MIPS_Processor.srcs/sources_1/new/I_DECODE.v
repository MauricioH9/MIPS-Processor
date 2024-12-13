`timescale 1ns / 1ps

module I_DECODE(
    input clk, write_en, rst,
    input [4:0] rd,
    input [31:0] write_data,
    input [31:0] instr_in,
    input [31:0] npc_in,
    
    output [1:0] wb_out,
    output [2:0] m_out,
    output [3:0] ex_out,
    output [4:0] instr_2016_out, instr_1511_out,
    output [31:0] rdat1_out, rdat2_out, 
    output [31:0] npc_out,
    output [31:0] latch_signext_out,
    
    // Outputs for the first 10 registers from the latch
    output [31:0] latch_reg0_out, latch_reg1_out, latch_reg2_out, latch_reg3_out,
    output [31:0] latch_reg4_out, latch_reg5_out, latch_reg6_out, latch_reg7_out,
    output [31:0] latch_reg8_out, latch_reg9_out
    );
    
    // Intermediate signals
    wire [8:0] wire_control;  // Control signals from control unit
    wire [31:0] wire_data1, wire_data2;  // Register values
    wire [31:0] wire_sign_ext;  // Sign-extended value
    
    // Instantiate control unit
    control control1(
        .opcode(instr_in[31:26]),
        .control_bits(wire_control)
    );
    
    // Instantiate register file
    register reg1(
        .rs(instr_in[25:21]),
        .rt(instr_in[20:16]),
        .rd(rd),
        .write_data(write_data),
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .read_data1(wire_data1),
        .read_data2(wire_data2),
        
        // Outputs for the first 10 registers
        .reg0_out(latch_reg0_out),
        .reg1_out(latch_reg1_out),
        .reg2_out(latch_reg2_out),
        .reg3_out(latch_reg3_out),
        .reg4_out(latch_reg4_out),
        .reg5_out(latch_reg5_out),
        .reg6_out(latch_reg6_out),
        .reg7_out(latch_reg7_out),
        .reg8_out(latch_reg8_out),
        .reg9_out(latch_reg9_out)
    );
    
    // Instantiate sign extension
    s_extend s_extend1(
        .a(instr_in[15:0]),
        .y(wire_sign_ext)
    );
    
    // Instantiate ID/EX latch to store decoded values and pass out register values
    id_ex id_ex1(
        // Inputs
        .clk(clk),
        .rst(rst),
        .ctrwb_out(wire_control[1:0]),
        .ctrm_out(wire_control[4:2]),
        .ctrex_out(wire_control[8:5]),
        .npc(npc_in),
        .read_dat1(wire_data1),
        .read_dat2(wire_data2),
        .signext_out(wire_sign_ext),
        .instr_2016(instr_in[20:16]),
        .instr_1511(instr_in[15:11]),
        
        // Outputs
        .wb_ctrout(wb_out),
        .m_ctrout(m_out),
        .ex_ctrout(ex_out),
        .npc_out(npc_out),
        .rdat1_out(rdat1_out),
        .rdat2_out(rdat2_out),
        .out_ext(latch_signext_out),
        .out_2016(instr_2016_out),
        .out_1511(instr_1511_out),
        
        // Register values (passed through from register module)
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
    
endmodule
