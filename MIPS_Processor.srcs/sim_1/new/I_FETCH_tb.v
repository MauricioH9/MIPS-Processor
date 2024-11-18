`timescale 1ns / 1ps

module I_FETCH_tb();

    reg clk_test;
    reg MEM_sel;
    reg [31:0] MEM_NPC_test;
    wire [31:0] instr_test, npc_test;

    // Instantiate I_FETCH
    I_FETCH I_FETCH_uut (
        .clk(clk_test),
        .EX_MEM_NPC(MEM_NPC_test),
        .EX_MEM_PCSrc(MEM_sel),
        .IF_ID_instr(instr_test),  
        .IF_ID_npc(npc_test)         
    );

    initial clk_test <= 0;
    always #5 clk_test <= ~clk_test;

    initial begin
        MEM_sel = 0; 
        MEM_NPC_test = 32'hFFFFFFFF;

        // Observe the outputs for some cycles
        #20;

        // Test Case 1: Simulate a branch (select MEM_NPC)
        MEM_sel = 1;
        MEM_NPC_test = 32'h00000010;
        #20;

        // Test Case 2: Return to normal operation
        MEM_sel = 0;
        #20;

        // Test Case 3: Another branch scenario
        MEM_sel = 1;
        MEM_NPC_test = 32'h00000020;
        #20;

        // End the simulation
        $finish;
    end

    // Monitor output values
    initial begin
        $monitor("Time=%0d | MEM_sel=%b | MEM_NPC=%h | instr=%h | npc=%h",
                 $time, MEM_sel, MEM_NPC_test, instr_test, npc_test);
    end

endmodule
