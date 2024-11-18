`timescale 1ns / 1ps

module if_id_tb();

    reg clk;
    reg [31:0] instr;
    reg [31:0] npc;
    wire [31:0] instrout;
    wire [31:0] npcout;

    if_id if_id_uut (
        .clk(clk),
        .instr(instr),
        .npc(npc),
        .instrout(instrout),
        .npcout(npcout)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5 time units for a 10-time-unit clock period
    end

    initial begin
        instr = 32'h00000000;
        npc = 32'h00000000;
        #10;
        instr = 32'hA5A5A5A5;
        npc = 32'h00000004;
        #10;  
        $display("Time=%0d | instrout=%h | npcout=%h", $time, instrout, npcout);
        instr = 32'h12345678;
        npc = 32'h00000008;
        #10;  
        $display("Time=%0d | instrout=%h | npcout=%h", $time, instrout, npcout);
        instr = 32'hDEADBEEF;
        npc = 32'h0000000C;
        #10;  
        $display("Time=%0d | instrout=%h | npcout=%h", $time, instrout, npcout);
        instr = 32'h00000000;
        npc = 32'h00000000;
        #10; 
        $display("Time=%0d | instrout=%h | npcout=%h", $time, instrout, npcout);
        $stop;
    end
endmodule