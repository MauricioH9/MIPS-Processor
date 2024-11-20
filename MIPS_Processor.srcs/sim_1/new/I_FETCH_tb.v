`timescale 1ns / 1ps

module I_FETCH_tb();
    reg clk;
    reg reset;
    reg EX_MEM_PCSrc;
    reg [31:0] EX_MEM_NPC;
    wire [31:0] IF_ID_instr, IF_ID_npc;

    // Instantiate I_FETCH
    I_FETCH I_FETCH_uut (
        .clk(clk),
        .reset(reset),     
        .EX_MEM_NPC(EX_MEM_NPC),
        .EX_MEM_PCSrc(EX_MEM_PCSrc),
        .IF_ID_instr(IF_ID_instr),  
        .IF_ID_npc(IF_ID_npc)         
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        clk = 0;
        reset = 1;          
        EX_MEM_PCSrc = 0;
        EX_MEM_NPC = 32'h00000000;
        // Apply reset
        #10 reset = 0;      

        // Test Case 1: Normal operation (increment PC)
        EX_MEM_PCSrc = 0;
        #20;

        // Test Case 2: Simulate a branch (select MEM_NPC)
        EX_MEM_PCSrc = 1;
        EX_MEM_NPC = 32'h00000002; // Branch target
        #20;

        // Test Case 3: Return to normal operation
        EX_MEM_PCSrc = 0;
        #20;

        // Test Case 4: Consecutive branches
        EX_MEM_PCSrc = 1;
        EX_MEM_NPC = 32'h0000000A; // Branch target
        #20;

        // Reassert reset
        reset = 1;
        #10;
        $display("Reassert Reset | Instr=%h | NPC=%h", IF_ID_instr, IF_ID_npc);

        // Resume normal operation
        reset = 0;
        EX_MEM_PCSrc = 0;
        #20;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0d | Reset=%b | MEM_sel=%b | MEM_NPC=%h | Instr=%h | NPC=%h",
                 $time, reset, EX_MEM_PCSrc, EX_MEM_NPC, IF_ID_instr, IF_ID_npc);
    end

endmodule
