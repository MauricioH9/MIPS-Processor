`timescale 1ns / 1ps

module registers(
    input wire clk,
    input wire reset,                
    input wire RegWrite,             // Write enable signal
    input wire [4:0] rs,             // Address of the rs register to read
    input wire [4:0] rt,             // Address of the rt register to read
    input wire [4:0] rd,             // Address of the rd register to write
    input wire [31:0] write_data,    // Data to write to the register
    output reg [31:0] read_data_rs,  // Data from the rs register
    output reg [31:0] read_data_rt   // Data from the rt register
);
    // Array of 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];
    integer i;

    always @(*) begin
        read_data_rs = registers[rs];
        read_data_rt = registers[rt];
    end

    // Write data to the register on the rising clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to zero
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (RegWrite && rd != 0) begin
            // Write to the register if enabled and not writing to $0
            registers[rd] <= write_data;
        end
    end
endmodule
