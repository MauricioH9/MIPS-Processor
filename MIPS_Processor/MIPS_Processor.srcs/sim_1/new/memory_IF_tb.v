`timescale 1ns / 1ps

module memory_tb;
    reg [31:0] addr_test;
    wire [31:0] data_test;
    reg clk_test;

    memory memory_uut(
        .addr(addr_test),
        .data(data_test),
        .clk(clk_test)
    );
    
    initial clk_test <= 0;
    always #5 clk_test <= ~clk_test;

    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1)
        begin
            addr_test <= i;
            #10;
        end
        $finish;
    end
    
endmodule