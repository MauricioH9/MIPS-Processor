`timescale 1ns / 1ps

module register(
    input clk, rst, write_en,
    input [4:0] rs, rt, rd,
    input [31:0] write_data,
    output reg [31:0] read_data1, read_data2,

    output reg [31:0] reg0_out, reg1_out, reg2_out, reg3_out, reg4_out,
    output reg [31:0] reg5_out, reg6_out, reg7_out, reg8_out, reg9_out
    );
    
    // 32 registers, each 32 bits long
    reg [31:0] registers [0:31];
    integer i;
    
    // read from reg
    always @* begin
        read_data1 <= registers[rs];
        read_data2 <= registers[rt];
        
        // Capture the values of the first 10 registers
        reg0_out <= registers[0];
        reg1_out <= registers[1];
        reg2_out <= registers[2];
        reg3_out <= registers[3];
        reg4_out <= registers[4];
        reg5_out <= registers[5];
        reg6_out <= registers[6];
        reg7_out <= registers[7];
        reg8_out <= registers[8];
        reg9_out <= registers[9];
    end
    
    // write to reg
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 0;
        end
        if (write_en && rd != 5'b00000) begin
            registers[rd] <= write_data;
        end
    end
    
endmodule
