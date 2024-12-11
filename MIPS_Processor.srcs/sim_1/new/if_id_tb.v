`timescale 1ns / 1ps

module if_id_tb;
    reg clk;
    reg reset;
    reg [31:0] instr;
    reg [31:0] npc;
    wire [31:0] instrout;
    wire [31:0] npcout;

    // Instantiate  if_id module
    if_id if_id_uut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .npc(npc),
        .instrout(instrout),
        .npcout(npcout)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;        
        instr = 32'b0;
        npc = 32'b0;

        // Wait for reset 
        #10;
        reset = 0;         

        // Test Case 1: Load first instruction and NPC
        instr = 32'hAABBCCDD; // Instruction
        npc = 32'h00000004;   // NPC
        #10;
        $display("Time=%0d | Reset=%b | Instr=%h | NPC=%h | InstrOut=%h | NPCOut=%h", 
                 $time, reset, instr, npc, instrout, npcout);

        // Test Case 2: Load second instruction and NPC
        instr = 32'h11223344; // Instruction
        npc = 32'h00000008;   // NPC
        #10;
        $display("Time=%0d | Reset=%b | Instr=%h | NPC=%h | InstrOut=%h | NPCOut=%h", 
                 $time, reset, instr, npc, instrout, npcout);

        // Test Case 3: Reassert reset
        reset = 1;
        #10;
        $display("Time=%0d | Reset=%b | Instr=%h | NPC=%h | InstrOut=%h | NPCOut=%h", 
                 $time, reset, instr, npc, instrout, npcout);

        // Test Case 4: Resume normal operation after reset
        reset = 0;
        instr = 32'h55667788; // Instruction
        npc = 32'h0000000C;   // NPC
        #10;
        $display("Time=%0d | Reset=%b | Instr=%h | NPC=%h | InstrOut=%h | NPCOut=%h", 
                 $time, reset, instr, npc, instrout, npcout);

        $stop;
    end

endmodule
