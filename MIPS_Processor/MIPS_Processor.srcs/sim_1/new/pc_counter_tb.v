`timescale 1ns / 1ps

module program_counter_tb;
    reg [31:0] npc_test;
    reg clk_test;
    
    wire [31:0] pc_test;
    
    program_counter program_counter_uut(
        .pc(pc_test),
        .clk(clk_test),
        .npc(npc_test)
    );
    
    initial clk_test <= 0;
    always #5 clk_test <= ~clk_test;
    
    initial begin
        npc_test <= 32'h00000000;
        #10
        npc_test <= 32'hAA00FF00;
        #10
        npc_test <= 32'h88AAFF00;
        #10
        npc_test <= 32'h00CCAABB;
        $finish;
    end    

endmodule
