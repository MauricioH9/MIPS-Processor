`timescale 1ns / 1ps

module program_counter(
    input wire [31:0] npc,
    input clk, rst,
    output reg [31:0] pc
    );
    
    initial begin
        pc <= 0;
    end
    
    always @ (posedge clk) begin
        if(rst)
            pc <= 0;
        else
            pc <= npc;
    end
    
endmodule