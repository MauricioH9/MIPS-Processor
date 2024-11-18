`timescale 1ns / 1ps

module memory_tb;
    reg clk;
    reg [31:0] addr;        
    wire [31:0] data;       

    memory memory_uut (
        .clk(clk),
        .data(data),
        .addr(addr)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        addr = 32'd0;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd1;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd2;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd3;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd4;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd5;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);
        addr = 32'd9;
        #10;
        $display("Time=%0d | Address=%0d | Data=%h", $time, addr, data);

        $stop;
    end
endmodule