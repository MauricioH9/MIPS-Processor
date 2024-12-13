`timescale 1ns / 1ps

module I_FETCH_tb;

    // Inputs
    reg clk;
    reg rst;
    reg EX_MEM_PCSrc;
    reg [31:0] EX_MEM_NPC;

    // Outputs
    wire [31:0] IF_ID_instr;
    wire [31:0] IF_ID_npc;

    // Instantiate the Unit Under Test (UUT)
    I_FETCH I_FETCH_uut (
        .clk(clk),
        .rst(rst),
        .EX_MEM_PCSrc(EX_MEM_PCSrc),
        .EX_MEM_NPC(EX_MEM_NPC),
        .IF_ID_instr(IF_ID_instr),
        .IF_ID_npc(IF_ID_npc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Initialize inputs
        rst = 1;
        EX_MEM_PCSrc = 0;
        EX_MEM_NPC = 32'h00000000;

        // Reset and monitor
        $monitor("Time=%0t | PCSrc=%b | EX_MEM_NPC=%h | IF_ID_instr=%h | IF_ID_npc=%h", 
                 $time, EX_MEM_PCSrc, EX_MEM_NPC, IF_ID_instr, IF_ID_npc);

        // Test Case 1: Reset
        #10 rst = 0;

        // Test Case 2: Increment PC normally
        #20 EX_MEM_PCSrc = 0;

        // Test Case 3: Branching scenario (use EX_MEM_NPC)
        #10 EX_MEM_NPC = 32'h00000020;
            EX_MEM_PCSrc = 1;

        // Test Case 4: Back to normal increment
        #10 EX_MEM_PCSrc = 0;

        // End simulation
        #50 $stop;
    end

endmodule
