`timescale 1ns / 1ps

module pc_counter_tb;
    reg clk;
    reg [31:0] npc;         
    wire [31:0] PC;         

    pc_counter pc_counter_uut (
        .PC(PC),
        .npc(npc),
        .clk(clk)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        npc = 32'd0;
        #10;  
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);
        npc = 32'd4;
        #10;
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);
        npc = 32'd8;
        #10;
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);
        npc = 32'd12;
        #10;
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);
        npc = 32'd16;
        #10;
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);
        npc = 32'd20;
        #10;
        $display("Time=%0d | NPC=%0d | PC=%0d", $time, npc, PC);

        $stop;
    end
endmodule