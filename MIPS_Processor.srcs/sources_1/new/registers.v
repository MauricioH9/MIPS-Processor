`timescale 1ns / 1ps

module registers(
    input wire clk,   
                 
    input wire RegWrite,            // Write enable signal
    input wire [4:0] rs,            // Address of the rs register to read
    input wire [4:0] rt,            // Address of the rt register to read
    input wire [4:0] rd,            // Address of the rd register to write
    
    input wire [31:0] write_data,   // Data to write to the register
    output reg [31:0] read_data_rs, // Data from the rs register
    output reg [31:0] read_data_rt  // Data from the rt register
);
    // Array of 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];

    // Initialize all registers to zero
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 0;
    end

    // Read data from registers
    always @(*) begin
        read_data_rs = registers[rs];
        read_data_rt = registers[rt];
    end

    // Write data to the register on the rising clock edge
    always @(posedge clk) begin
        if (RegWrite && rd != 0)  // Ensure register 0 remains constant as per MIPS convention
            registers[rd] <= write_data;
    end
endmodule
