`timescale 1ns / 1ps

module pc_counter(
    output reg [31:0] PC,
    input wire [31:0] npc,
    input clk

    );
    
    initial begin
        PC <= 0;
    end
    
    always @ (posedge clk) begin
        PC <= npc;
    end
    
endmodule