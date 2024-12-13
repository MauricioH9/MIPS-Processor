`timescale 1ns / 1ps

module d_mem_tb;

    // Inputs
    reg clk;
    reg rst;
    reg mem_write;
    reg mem_read;
    reg [31:0] write_dat;
    reg [31:0] addr;

    // Output
    wire [31:0] read_dat;

    // Instantiate the d_mem module
    d_mem d_mem_uut (
        .clk(clk),
        .rst(rst),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .write_dat(write_dat),
        .addr(addr),
        .read_dat(read_dat)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
        // Initialize inputs
        rst = 1;
        mem_write = 0;
        mem_read = 0;
        write_dat = 32'h0;
        addr = 32'h0;

        // Reset the memory
        #10 rst = 0;

        // Test Case 1: Write to memory
        mem_write = 1;
        mem_read = 0;
        addr = 32'h10;         // Address to write
        write_dat = 32'hDEADBEEF; // Data to write
        #10 mem_write = 0;

        // Test Case 2: Read from memory
        mem_read = 1;
        addr = 32'h10;         // Address to read
        #10 mem_read = 0;

        // Test Case 3: Write to another address
        mem_write = 1;
        addr = 32'h20;         // Address to write
        write_dat = 32'hCAFEBABE; // Data to write
        #10 mem_write = 0;

        // Test Case 4: Read from the new address
        mem_read = 1;
        addr = 32'h20;         // Address to read
        #10 mem_read = 0;

        // Test Case 5: Read from an address that hasn't been written
        mem_read = 1;
        addr = 32'h30;         // Address to read
        #10 mem_read = 0;

        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | MemWrite=%b | MemRead=%b | Addr=%h | WriteData=%h | ReadData=%h", 
                 $time, mem_write, mem_read, addr, write_dat, read_dat);
    end

endmodule
