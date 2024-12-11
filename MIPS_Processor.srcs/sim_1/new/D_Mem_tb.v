`timescale 1ns / 1ps

module D_Mem_tb;

    reg clk;
    reg MemWrite;
    reg MemRead;
    reg [31:0] Address;
    reg [31:0] WriteData;
    wire [31:0] ReadData;

    // Instantiate D_Mem 
    D_Mem D_Mem_uut (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(Address),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $monitor("Time=%0t | MemWrite=%b | MemRead=%b | Address=%h | WriteData=%h | ReadData=%h",
                 $time, MemWrite, MemRead, Address, WriteData, ReadData);

        MemWrite = 0;
        MemRead = 0;
        Address = 32'b0;
        WriteData = 32'b0;

        // Test Case 1: Write to memory
        #10;
        MemWrite = 1;
        Address = 32'h00000010;
        WriteData = 32'hA5A5A5A5;
        #10;

        // Test Case 2: Disable write and check value
        MemWrite = 0;
        MemRead = 1;
        Address = 32'h00000010;
        #10;

        // Test Case 3: Write to another memory location
        MemWrite = 1;
        MemRead = 0;
        Address = 32'h00000020;
        WriteData = 32'hDEADBEEF;
        #10;

        // Test Case 4: Read from the new location
        MemWrite = 0;
        MemRead = 1;
        Address = 32'h00000020;
        #10;

        // Test Case 5: Read from an uninitialized location
        MemRead = 1;
        Address = 32'h00000030;
        #10;

        $stop;
    end

endmodule
