`timescale 1ns / 1ps

module if_id(
    input wire clk,
    output reg [31:0] instrout, npcout,
    input wire [31:0] instr, npc
    );
    
    initial begin
        instrout <= 0;
        npcout <= 0;
    end
    
    always @(posedge clk) begin
        instrout <= instr;
        npcout <= npc;
    end
    
endmodule