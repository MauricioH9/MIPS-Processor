`timescale 1ns / 1ps

module if_id_tb;
    reg clk_test, rst;
    reg [31:0] instr_test, npc_test;
    
    wire [31:0] instr_out_test, npc_out_test;
    
    if_id if_id_uut(
        .rst(rst),
        .clk(clk_test),
        .instr(instr_test),
        .npc(npc_test),
        .instr_out(instr_out_test),
        .npc_out(npc_out_test)
    );
    
    initial clk_test <= 0;
    always #5 clk_test = ~clk_test;
    
    initial begin
        rst = 1;
        instr_test = 32'hFFFFFFFF;
        npc_test = 32'hFFFFFFFF;
        #20
        rst = 0;
        instr_test <= 32'hAAAAAAAA;
        npc_test <= 32'hAAAAAAAA;
        #20
        instr_test <= 32'h0000FFFF;
        npc_test <= 32'hFFFF0000;
        #20
        instr_test <= 32'hFFFFFFFF;
        npc_test <= 32'hFFFFFFFF;
        #20
        instr_test <= 32'h00000000;
        npc_test <= 32'h00000000;
        #20
        $finish;
    end

endmodule
