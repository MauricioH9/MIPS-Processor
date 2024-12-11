`timescale 1ns / 1ps

module ex_mem_tb;

    reg clk;
    reg reset;
    // Inputs 
    reg [1:0] wb_control_in;
    reg [2:0] mem_control_in;
    reg [31:0] alu_result_in;
    reg [31:0] reg_rt_in;
    reg [4:0] write_reg_in;
    // Outputs 
    wire [1:0] wb_control_out;
    wire [2:0] mem_control_out;
    wire [31:0] alu_result_out;
    wire [31:0] reg_rt_out;
    wire [4:0] write_reg_out;

    // Instantiate EX_MEM module
    ex_mem ex_mem_uut (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),
        .mem_control_in(mem_control_in),
        .alu_result_in(alu_result_in),
        .reg_rt_in(reg_rt_in),
        .write_reg_in(write_reg_in),
        .wb_control_out(wb_control_out),
        .mem_control_out(mem_control_out),
        .alu_result_out(alu_result_out),
        .reg_rt_out(reg_rt_out),
        .write_reg_out(write_reg_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $monitor("WB Control Out=%b | MEM Control Out=%b | ALU Result Out=%h | Reg RT Out=%h | Write Reg Out=%b",
                  wb_control_out, mem_control_out, alu_result_out, reg_rt_out, write_reg_out);

        reset = 1;
        wb_control_in = 2'b0;
        mem_control_in = 3'b0;
        alu_result_in = 32'b0;
        reg_rt_in = 32'b0;
        write_reg_in = 5'b0; #10 reset = 0;

        // Test Case 1: Normal operation
        wb_control_in = 2'b10;
        mem_control_in = 3'b101;
        alu_result_in = 32'hA5A5A5A5;
        reg_rt_in = 32'hDEADBEEF;
        write_reg_in = 5'b10101; #10;

        // Test Case 2: Update with new values
        wb_control_in = 2'b01;
        mem_control_in = 3'b011;
        alu_result_in = 32'h12345678;
        reg_rt_in = 32'h87654321;
        write_reg_in = 5'b11011; #10;

        // reset
        reset = 1; #10 reset = 0;

        // Test Case 4: Update after reset
        wb_control_in = 2'b11;
        mem_control_in = 3'b110;
        alu_result_in = 32'hFFFFFFFF;
        reg_rt_in = 32'h00000000;
        write_reg_in = 5'b11111; #10;

        $finish;
    end

endmodule
