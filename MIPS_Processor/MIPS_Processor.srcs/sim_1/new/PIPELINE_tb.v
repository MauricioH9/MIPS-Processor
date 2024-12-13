`timescale 1ns / 1ps

module PIPELINE_tb;

    reg clk, rst;

    // Fetch Stage
    wire [31:0] fetch_instr, fetch_npc;

    // Decode Stage
    wire [1:0] decode_wb;
    wire [2:0] decode_m;
    wire [3:0] decode_ex;
    wire [4:0] decode_instr2016, decode_instr1511;
    wire [31:0] decode_rdat1, decode_rdat2, decode_npc, decode_signext;

    // Execution Stage
    wire ex_aluzero;
    wire [1:0] ex_wb;
    wire [2:0] ex_m;
    wire [4:0] ex_mux5bit;
    wire [31:0] ex_adderout, ex_aluresult, ex_rdat2;

    // Memory Stage
    wire mem_memtoreg, mem_regwrite, mem_PCSrc;
    wire [4:0] mem_5bitmux;
    wire [31:0] mem_addr, mem_rdat;

    // Write-Back Stage
    wire [31:0] wb_muxout;
    
    wire [31:0] reg_out0, reg_out1, reg_out2, reg_out3, reg_out4;
    wire [31:0] reg_out5, reg_out6, reg_out7, reg_out8, reg_out9;

    // Instantiate the PIPELINE module
    PIPELINE MIPS_PIPELINE_uut (
        .clk(clk),
        .rst(rst),
        .fetch_instr(fetch_instr),
        .fetch_npc(fetch_npc),
        .decode_wb(decode_wb),
        .decode_m(decode_m),
        .decode_ex(decode_ex),
        .decode_instr2016(decode_instr2016),
        .decode_instr1511(decode_instr1511),
        .decode_rdat1(decode_rdat1),
        .decode_rdat2(decode_rdat2),
        .decode_npc(decode_npc),
        .decode_signext(decode_signext),
        .ex_aluzero(ex_aluzero),
        .ex_wb(ex_wb),
        .ex_m(ex_m),
        .ex_mux5bit(ex_mux5bit),
        .ex_adderout(ex_adderout),
        .ex_aluresult(ex_aluresult),
        .ex_rdat2(ex_rdat2),
        .mem_memtoreg(mem_memtoreg),
        .mem_regwrite(mem_regwrite),
        .mem_PCSrc(mem_PCSrc),
        .mem_5bitmux(mem_5bitmux),
        .mem_addr(mem_addr),
        .mem_rdat(mem_rdat),
        .wb_muxout(wb_muxout),
        
        // New outputs for the first 10 registers
        .reg_out0(reg_out0),
        .reg_out1(reg_out1),
        .reg_out2(reg_out2),
        .reg_out3(reg_out3),
        .reg_out4(reg_out4),
        .reg_out5(reg_out5),
        .reg_out6(reg_out6),
        .reg_out7(reg_out7),
        .reg_out8(reg_out8),
        .reg_out9(reg_out9)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        
        #20;
        rst = 0;
        
        #250;
        $finish; 
    end

endmodule
