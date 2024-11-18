`timescale 1ns / 1ps

module I_FETCH(
    input clk,
    output wire [31:0] IF_ID_instr,
    output wire [31:0] IF_ID_npc, 
    input  wire        EX_MEM_PCSrc,
    input  wire [31:0] EX_MEM_NPC
    );
    
    wire [31:0] PC;
    wire [31:0] dataout;
    wire [31:0] npc,npc_mux;
    
    // Instanatiations
    mux mux_IF(
    .y(npc_mux),
    .a(EX_MEM_NPC),
    .b(npc),
    .sel(EX_MEM_PCSrc)
    );
    
    pc_counter pc_counter_IF(
    .clk(clk),
    .PC(PC),
    .npc(npc_mux)
    );
    
    memory memory_IF(
    .clk(clk),
    .data(dataout),
    .addr(PC)
    );
    
    if_id if_id_IF(
    .clk(clk),
    .instr(dataout),
    .npc(npc),
    .instrout(IF_ID_instr),
    .npcout(IF_ID_npc)
    );
    
    incrementer incrementer_IF(
    .Next_PC(npc),
    .PC(PC)
    );
               
endmodule