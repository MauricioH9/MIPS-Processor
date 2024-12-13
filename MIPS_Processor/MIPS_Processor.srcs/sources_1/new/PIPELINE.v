`timescale 1ns / 1ps

module PIPELINE(
    input clk, rst,
    // FETCH Outputs
    output [31:0] fetch_instr, fetch_npc,
    
    // DECODE Outputs
    output [1:0] decode_wb,
    output [2:0] decode_m,
    output [3:0] decode_ex,
    output [4:0] decode_instr2016, decode_instr1511,
    output [31:0] decode_rdat1, decode_rdat2, decode_npc, decode_signext,
    
    // EX Outputs
    output ex_aluzero,
    output [1:0] ex_wb,
    output [2:0] ex_m,
    output [4:0] ex_mux5bit,
    output [31:0] ex_adderout, ex_aluresult, ex_rdat2,
    
    // MEM Outputs
    output mem_memtoreg, mem_regwrite, mem_PCSrc,
    output [4:0] mem_5bitmux,
    output [31:0] mem_addr, mem_rdat,
    
    // WB Outputs
    output [31:0] wb_muxout,
    
    // New outputs for the first 10 registers
    output [31:0] reg_out0, reg_out1, reg_out2, reg_out3, reg_out4,
    output [31:0] reg_out5, reg_out6, reg_out7, reg_out8, reg_out9
    );
    
    // Module wires
    
    // Fetch Stage
    I_FETCH I_FETCH(
        // Inputs
        .clk(clk),
        .rst(rst),
        .EX_MEM_PCSrc(mem_PCSrc),
        .EX_MEM_NPC(ex_adderout),
       
        // Outputs
        .IF_ID_instr(fetch_instr),
        .IF_ID_npc(fetch_npc)
    );
    
    // Decode Stage  
    I_DECODE I_DECODE(
        // Inputs
        .clk(clk),
        .rst(rst),
        .write_en(mem_regwrite),
        .rd(mem_5bitmux),
        .write_data(wb_muxout),
        .instr_in(fetch_instr),
        .npc_in(fetch_npc),
        
        // Outputs
        .wb_out(decode_wb),
        .m_out(decode_m),
        .ex_out(decode_ex),
        .instr_2016_out(decode_instr2016),
        .instr_1511_out(decode_instr1511),
        .rdat1_out(decode_rdat1),
        .rdat2_out(decode_rdat2),
        .npc_out(decode_npc),
        .latch_signext_out(decode_signext),
        
        // New outputs for the first 10 registers
        .latch_reg0_out(reg_out0),
        .latch_reg1_out(reg_out1),
        .latch_reg2_out(reg_out2),
        .latch_reg3_out(reg_out3),
        .latch_reg4_out(reg_out4),
        .latch_reg5_out(reg_out5),
        .latch_reg6_out(reg_out6),
        .latch_reg7_out(reg_out7),
        .latch_reg8_out(reg_out8),
        .latch_reg9_out(reg_out9)
    );
    
    // Execute Stage
    EXECUTE EXECUTE(
        // Inputs
        .clk(clk),
        .rst(rst),
        .wb_ctl(decode_wb),
        .m_ctl(decode_m),
        .ex_ctl(decode_ex),
        .instr_2016(decode_instr2016),
        .instr_1511(decode_instr1511),
        .npc_out(decode_npc),
        .rdat1(decode_rdat1),
        .rdat2(decode_rdat2),
        .sign_ext(decode_signext),
        
        // Outputs
        .alu_zero(ex_aluzero),
        .mem_wb(ex_wb),
        .mem_m(ex_m),
        .mux5_out(ex_mux5bit),
        .adder_out(ex_adderout),
        .alu_result(ex_aluresult),
        .dat2_mem(ex_rdat2)
    );
    
    // Memory Stage
    MEM_STAGE MEMORY(
        // Inputs
        .clk(clk),
        .rst(rst),
        .alu_zero(ex_aluzero),
        .ex_wb(ex_wb),
        .ex_m(ex_m),
        .in_5bitmux(ex_mux5bit),
        .mem_addr(ex_aluresult),
        .write_dat(ex_rdat2),
        
        // Outputs
        .reg_to_write(mem_regwrite),
        .mem_to_reg(mem_memtoreg),
        .PCSrc(mem_PCSrc),
        .mux_5bit(mem_5bitmux),
        .wb_dat(mem_rdat),
        .addr_out(mem_addr)  
    );
    
    // Write-Back Stage
    WB_STAGE WRITE_BACK(
        // Inputs,
        .mem_to_reg(mem_memtoreg),
        .read_dat(mem_rdat),
        .addr(mem_addr),
            
        // Outputs
        .mux_out(wb_muxout)
    );
    
endmodule