`timescale 1ns / 1ps

module if_id(
    input wire clk, rst,
    input wire [31:0] instr, npc,
    output reg [31:0] instr_out, npc_out
    );
    
    initial begin
        instr_out <= 0;
        npc_out <= 0;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            instr_out <= 0;
            npc_out <= 0;
        end
        else begin
            instr_out <= instr;
            npc_out <= npc;
        end
    end
endmodule