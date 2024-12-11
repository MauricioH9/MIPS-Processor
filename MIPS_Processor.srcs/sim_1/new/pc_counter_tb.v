`timescale 1ns / 1ps

module pc_counter_tb;
    reg clk;
    reg reset;              
    reg [31:0] npc;          
    wire [31:0] PC;          

    // Instantiate  pc_counter module
    pc_counter pc_counter_uut (
        .PC(PC),
        .npc(npc),
        .clk(clk),
        .reset(reset)        
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    initial begin

        reset = 1;           
        npc = 32'd0;          // Initialize NPC

        #10;                  
        reset = 0;            

        // Test Case 1: First increment
        npc = 32'd4;
        #10;
        $display("Time=%0d | Reset=%b | NPC=%0d | PC=%0d", $time, reset, npc, PC);

        // Test Case 2: Second increment
        npc = 32'd8;
        #10;
        $display("Time=%0d | Reset=%b | NPC=%0d | PC=%0d", $time, reset, npc, PC);

        // Test Case 3: Third increment
        npc = 32'd12;
        #10;
        $display("Time=%0d | Reset=%b | NPC=%0d | PC=%0d", $time, reset, npc, PC);

        // Test Case 4: Reassert reset
        reset = 1;
        #10;
        $display("Time=%0d | Reset=%b | NPC=%0d | PC=%0d", $time, reset, npc, PC);

        // Test Case 5: Resume normal operation
        reset = 0;
        npc = 32'd16;
        #10;
        $display("Time=%0d | Reset=%b | NPC=%0d | PC=%0d", $time, reset, npc, PC);

        // End simulation
        $stop;
    end

endmodule
