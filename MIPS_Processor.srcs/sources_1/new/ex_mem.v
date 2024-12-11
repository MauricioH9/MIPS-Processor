`timescale 1ns / 1ps

module ex_mem(
    input wire clk,
    input wire reset,
    input wire [1:0] wb_control_in,    // WB control 
    input wire [2:0] mem_control_in,   // MEM control 
    input wire [31:0] alu_result_in,   // ALU computation result
    input wire [31:0] reg_rt_in,       // Data to be written to memory
    input wire [4:0] write_reg_in,     // Register to write back
    
    // Outputs to MEM stage
    output reg [1:0] wb_control_out,   // WB control 
    output reg [2:0] mem_control_out,  // MEM control 
    output reg [31:0] alu_result_out,  // ALU computation result
    output reg [31:0] reg_rt_out,      // Data to be written to memory
    output reg [4:0] write_reg_out     // Register to write back
);

    initial begin
        wb_control_out = 2'b0;
        mem_control_out = 3'b0;
        alu_result_out = 32'b0;
        reg_rt_out = 32'b0;
        write_reg_out = 5'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all outputs
            wb_control_out <= 2'b0;
            mem_control_out <= 3'b0;
            alu_result_out <= 32'b0;
            reg_rt_out <= 32'b0;
            write_reg_out <= 5'b0;
        end else begin
            // Update outputs with input values
            wb_control_out <= wb_control_in;
            mem_control_out <= mem_control_in;
            alu_result_out <= alu_result_in;
            reg_rt_out <= reg_rt_in;
            write_reg_out <= write_reg_in;
        end
    end

endmodule
