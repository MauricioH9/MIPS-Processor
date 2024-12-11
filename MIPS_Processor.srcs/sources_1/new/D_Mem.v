`timescale 1ns / 1ps

module D_Mem(
    input wire clk,                 
    input wire MemWrite,           
    input wire MemRead,            
    input wire [31:0] Address,      
    input wire [31:0] WriteData,    
    output reg [31:0] ReadData     
);

    // Memory array
    reg [31:0] memory [0:255];      // 256 32-bit words (1KB memory)
    
    integer i;

    // Initialize all memory addresses to 0 then load
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'b0;
            
            $readmemb("data.mem", memory);
        end
    end

    // Memory Read Operation
    always @(*) begin
        if (MemRead) begin
            ReadData = memory[Address[7:0]]; 
        end else begin
            ReadData = 32'b0;               // Output zero when MemRead is not enabled
        end
    end

    // Memory Write Operation
    always @(posedge clk) begin
        if (MemWrite) begin
            memory[Address[7:0]] <= WriteData; 
        end
    end

endmodule
