`timescale 1ns / 1ps

module MEMORY(
    input wire clk,
    input wire reset,

    // Inputs from EX/MEM stage
    input wire [1:0] wb_control_in,       
    input wire [2:0] mem_control_in,      
    input wire [31:0] alu_result_in,       
    input wire [31:0] reg_rt_in,         
    input wire alu_zero_in,                
    input wire [4:0] write_reg_in,        

    // Outputs to WB stage
    output wire [1:0] wb_control_out,      
    output wire [31:0] read_data_out,     
    output wire [31:0] alu_result_out,     
    output wire [4:0] write_reg_out,      
    
    // Branch Output
    output wire branch_taken    // Branch decision
);

    // Internal wires
    wire mem_read, mem_write, branch;
    wire [31:0] read_data;
    wire branch_condition;

    // Extract control signals
    assign mem_read = mem_control_in[1];
    assign mem_write = mem_control_in[2];
    assign branch = mem_control_in[0];

    //  Data Memory
    D_Mem D_Mem_MEM (
        .clk(clk),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .Address(alu_result_in),
        .WriteData(reg_rt_in),
        .ReadData(read_data)
    );

    //  AND Gate
    branch branch_MEM (
        .a(branch),
        .b(alu_zero_in),
        .y(branch_condition)
    );

    // Output branch condition
    assign branch_taken = branch_condition;

    // MEM/WB  
    mem_wb mem_wb_MEM (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),
        .read_data_in(read_data),
        .alu_result_in(alu_result_in),
        .write_reg_in(write_reg_in),
        .wb_control_out(wb_control_out),
        .read_data_out(read_data_out),
        .alu_result_out(alu_result_out),
        .write_reg_out(write_reg_out)
    );

endmodule
