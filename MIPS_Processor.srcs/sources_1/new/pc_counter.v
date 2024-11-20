`timescale 1ns / 1ps

module pc_counter(
    input clk,
    input reset,
    output reg [31:0] PC,
    input wire [31:0] npc
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0;
        else
            PC <= npc;
    end
endmodule