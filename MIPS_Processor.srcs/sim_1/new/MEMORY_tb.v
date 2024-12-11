`timescale 1ns / 1ps

module MEMORY_tb;

    reg clk;
    reg reset;

    // Inputs from EX/MEM stage
    reg [1:0] wb_control_in;
    reg [2:0] mem_control_in;
    reg [31:0] alu_result_in;
    reg [31:0] reg_rt_in;
    reg alu_zero_in;
    reg [4:0] write_reg_in;

    // Outputs to WB stage
    wire [1:0] wb_control_out;
    wire [31:0] read_data_out;
    wire [31:0] alu_result_out;
    wire [4:0] write_reg_out;
    
    // Branch Output
    wire branch_taken;

    // Instantiate MEMORY 
    MEMORY MEMORY_uut (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),
        .mem_control_in(mem_control_in),
        .alu_result_in(alu_result_in),
        .reg_rt_in(reg_rt_in),
        .alu_zero_in(alu_zero_in),
        .write_reg_in(write_reg_in),
        .wb_control_out(wb_control_out),
        .read_data_out(read_data_out),
        .alu_result_out(alu_result_out),
        .write_reg_out(write_reg_out),
        .branch_taken(branch_taken)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $monitor("Time=%0t | wb_control_out=%b | read_data_out=%h | alu_result_out=%h | write_reg_out=%d | branch_taken=%b",
                 $time, wb_control_out, read_data_out, alu_result_out, write_reg_out, branch_taken);

        reset = 1;
        wb_control_in = 2'b0;
        mem_control_in = 3'b0;
        alu_result_in = 32'b0;
        reg_rt_in = 32'b0;
        alu_zero_in = 1'b0;
        write_reg_in = 5'b0;

        #10 reset = 0;

        // Test Case 1: Memory Write
        wb_control_in = 2'b10;
        mem_control_in = 3'b110; // mem_write = 1, mem_read = 0, branch = 0
        alu_result_in = 32'h10;  // Address
        reg_rt_in = 32'hA5A5A5A5; // Write Data
        #10;

        // Test Case 2: Memory Read
        mem_control_in = 3'b010; // mem_write = 0, mem_read = 1, branch = 0
        #10;

        // Test Case 3: Branch Taken
        mem_control_in = 3'b001; // mem_write = 0, mem_read = 0, branch = 1
        alu_zero_in = 1'b1; // Branch condition met
        #10;

        // Test Case 4: No Operation
        mem_control_in = 3'b000; // mem_write = 0, mem_read = 0, branch = 0
        alu_zero_in = 1'b0;
        #10;

        // Test Case 5: Mixed Operation
        wb_control_in = 2'b11;
        mem_control_in = 3'b110; // mem_write = 1, mem_read = 0, branch = 1
        alu_result_in = 32'h20;
        reg_rt_in = 32'hDEADBEEF;
        alu_zero_in = 1'b1;
        write_reg_in = 5'b10101;
        #10;

        $stop;
    end

endmodule
