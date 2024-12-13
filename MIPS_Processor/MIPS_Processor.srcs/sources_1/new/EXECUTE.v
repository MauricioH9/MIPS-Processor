`timescale 1ns / 1ps

module EXECUTE(
        input clk, rst,
        input [1:0] wb_ctl,
        input [2:0] m_ctl, 
        input [3:0] ex_ctl, 
        input [4:0] instr_2016, instr_1511,
        input [31:0] npc_out, rdat1, rdat2, sign_ext,
        output alu_zero,
        output [1:0] mem_wb,
        output [2:0] mem_m,
        output [4:0] mux5_out,
        output [31:0] adder_out, alu_result, dat2_mem
    );
    
    // Wires for intermediate connections
    wire alu_zero_out;
    wire [4:0] mux_5bit_out;
    wire [5:0] alu_control;
    wire [31:0] alu_in2, add_out, alu_out;
    
    ex_mem ex_mem1(
        // Inputs
        .clk(clk),
        .rst(rst),
        .aluzero(alu_zero_out),
        .ctlwb_out(wb_ctl),
        .mux_out(mux_5bit_out),
        .ctlm_out(m_ctl),
        .adder_out(add_out),
        .alu_out(alu_out),
        .read_dat2(rdat2),
        
        // Outputs
        .zero(alu_zero),
        .wb_out(mem_wb),
        .m_out(mem_m),
        .adder_result(adder_out),
        .alu_result(alu_result),
        .dat2_out(dat2_mem),
        .mux_result(mux5_out)
    );
    
    adder adder1(
        .add_in1(npc_out),
        .add_in2(sign_ext),
        .add_out(add_out)
    );
    
    mux mux1(
        .a(rdat2),
        .b(sign_ext),
        .sel(ex_ctl[0]),
        .y(alu_in2)
    );
    
    mux_5bit mux2(
        .a(instr_2016),
        .b(instr_1511),
        .sel(ex_ctl[3]),
        .y(mux_5bit_out)
    );
    
    alu alu1(
        .in1(rdat1),
        .in2(alu_in2),
        .alu_control(alu_control),
        .zero(alu_zero_out),
        .result(alu_out)
    );
    
    alu_control alu_control1(
        .funct(sign_ext[5:0]),
        .alu_op(ex_ctl[2:1]),
        .alu_control(alu_control)
    );
    
endmodule