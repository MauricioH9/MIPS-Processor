`timescale 1ns / 1ps

module id_ex(
    input wire clk, rst,
    input wire [1:0] ctrwb_out,
    input wire [2:0] ctrm_out,
    input wire [3:0] ctrex_out,
    input wire [31:0] npc, read_dat1, read_dat2, signext_out,
    input wire [4:0] instr_2016, instr_1511,
   
    input wire [31:0] reg0_out, reg1_out, reg2_out, reg3_out, reg4_out,
    input wire [31:0] reg5_out, reg6_out, reg7_out, reg8_out, reg9_out,
    
    output reg [1:0] wb_ctrout,
    output reg [2:0] m_ctrout,
    output reg [3:0] ex_ctrout,
    output reg [31:0] npc_out, rdat1_out, rdat2_out, out_ext,
    output reg [4:0] out_2016, out_1511,
    output reg [31:0] latch_reg0_out, latch_reg1_out, latch_reg2_out, latch_reg3_out,
    output reg [31:0] latch_reg4_out, latch_reg5_out, latch_reg6_out, latch_reg7_out,
    output reg [31:0] latch_reg8_out, latch_reg9_out
    );
    
    initial begin
        wb_ctrout <= 0;
        m_ctrout <= 0;
        ex_ctrout <= 0;
        npc_out <= 0;
        rdat1_out <= 0;
        rdat2_out <= 0;
        out_ext <= 0;
        out_2016 <= 0;
        out_1511 <= 0;
        latch_reg0_out <= 0;
        latch_reg1_out <= 0;
        latch_reg2_out <= 0;
        latch_reg3_out <= 0;
        latch_reg4_out <= 0;
        latch_reg5_out <= 0;
        latch_reg6_out <= 0;
        latch_reg7_out <= 0;
        latch_reg8_out <= 0;
        latch_reg9_out <= 0;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            wb_ctrout <= 0;
            m_ctrout <= 0;
            ex_ctrout <= 0;
            npc_out <= 0;
            rdat1_out <= 0;
            rdat2_out <= 0;
            out_ext <= 0;
            out_2016 <= 0;
            out_1511 <= 0;
            latch_reg0_out <= 0;
            latch_reg1_out <= 0;
            latch_reg2_out <= 0;
            latch_reg3_out <= 0;
            latch_reg4_out <= 0;
            latch_reg5_out <= 0;
            latch_reg6_out <= 0;
            latch_reg7_out <= 0;
            latch_reg8_out <= 0;
            latch_reg9_out <= 0;
        end
        else begin
            wb_ctrout <= ctrwb_out;
            m_ctrout <= ctrm_out;
            ex_ctrout <= ctrex_out;
            npc_out <= npc;
            rdat1_out <= read_dat1;
            rdat2_out <= read_dat2;
            out_ext <= signext_out;
            out_2016 <= instr_2016;
            out_1511 <= instr_1511;
            
            latch_reg0_out <= reg0_out;
            latch_reg1_out <= reg1_out;
            latch_reg2_out <= reg2_out;
            latch_reg3_out <= reg3_out;
            latch_reg4_out <= reg4_out;
            latch_reg5_out <= reg5_out;
            latch_reg6_out <= reg6_out;
            latch_reg7_out <= reg7_out;
            latch_reg8_out <= reg8_out;
            latch_reg9_out <= reg9_out;
        end
    end
endmodule
