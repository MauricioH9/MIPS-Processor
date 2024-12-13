`timescale 1ns / 1ps

module I_FETCH(
    input clk, rst,
    input wire EX_MEM_PCSrc,
    input wire [31:0] EX_MEM_NPC,
    output wire [31:0] IF_ID_instr,
    output wire [31:0] IF_ID_npc
    );
    
    // Signals
    wire [31:0] PC;
    wire [31:0] data_out;
    wire [31:0] npc, npc_mux;
    
    mux mux1(
        .y(npc_mux),
        .a(npc),
        .b(EX_MEM_NPC),
        .sel(EX_MEM_PCSrc)
    );
    
    program_counter program_counter1(
        .rst(rst),
        .clk(clk),
        .pc(PC),
        .npc(npc_mux)
    );
    
    memory memory1(
        .clk(clk),
        .data(data_out),
        .addr(PC)
    );
    
    if_id latch1(
        .clk(clk),
        .rst(rst),
        .instr(data_out),
        .npc(npc),
        .instr_out(IF_ID_instr),
        .npc_out(IF_ID_npc)
    );
    
    incr incr1(
        .out(npc),
        .a(PC)
    );
    
endmodule