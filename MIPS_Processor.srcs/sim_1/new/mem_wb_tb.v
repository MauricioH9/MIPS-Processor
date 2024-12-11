`timescale 1ns / 1ps

module mem_wb_tb;

    reg clk;
    reg reset;

    // Inputs to the MEM/WB module
    reg [1:0] wb_control_in;
    reg [31:0] read_data_in;
    reg [31:0] alu_result_in;
    reg [4:0] write_reg_in;

    // Outputs from the MEM/WB module
    wire [1:0] wb_control_out;
    wire [31:0] read_data_out;
    wire [31:0] alu_result_out;
    wire [4:0] write_reg_out;

    // Instantiate  mem_wb 
    mem_wb mem_wb_uut (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),
        .read_data_in(read_data_in),
        .alu_result_in(alu_result_in),
        .write_reg_in(write_reg_in),
        .wb_control_out(wb_control_out),
        .read_data_out(read_data_out),
        .alu_result_out(alu_result_out),
        .write_reg_out(write_reg_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%0t | wb_control_out=%b | read_data_out=%h | alu_result_out=%h | write_reg_out=%d",
                 $time, wb_control_out, read_data_out, alu_result_out, write_reg_out);

        reset = 1;
        wb_control_in = 2'b00;
        read_data_in = 32'b0;
        alu_result_in = 32'b0;
        write_reg_in = 5'b0;

        #10 reset = 0;

        // Test Case 1: Normal operation, propagate inputs to outputs
        #10;
        wb_control_in = 2'b11;
        read_data_in = 32'hA5A5A5A5;
        alu_result_in = 32'h12345678;
        write_reg_in = 5'b10101;
        #10;

        // Test Case 2: Update inputs, observe outputs
        wb_control_in = 2'b10;
        read_data_in = 32'hDEADBEEF;
        alu_result_in = 32'h87654321;
        write_reg_in = 5'b11011;
        #10;

        // Test Case 3: Assert reset and observe outputs reset to 0
        reset = 1;
        #10 reset = 0;

        // Test Case 4: Verify outputs after reset
        wb_control_in = 2'b01;
        read_data_in = 32'h55555555;
        alu_result_in = 32'hAAAAAAAA;
        write_reg_in = 5'b11111;
        #10;

        $stop;
    end
endmodule

