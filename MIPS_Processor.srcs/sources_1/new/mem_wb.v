`timescale 1ns / 1ps

module mem_wb(
    input wire clk,
    input wire reset,
    
    // Inputs from EX/MEM stage
    input wire [1:0] wb_control_in,      
    input wire [31:0] read_data_in,      
    input wire [31:0] alu_result_in,      
    input wire [4:0] write_reg_in,       
    
    // Outputs to WB stage
    output reg [1:0] wb_control_out,     
    output reg [31:0] read_data_out,      
    output reg [31:0] alu_result_out,   
    output reg [4:0] write_reg_out       
);

    initial begin
        wb_control_out = 2'b0;
        read_data_out = 32'b0;
        alu_result_out = 32'b0;
        write_reg_out = 5'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wb_control_out <= 2'b0;
            read_data_out <= 32'b0;
            alu_result_out <= 32'b0;
            write_reg_out <= 5'b0;
        end else begin
            wb_control_out <= wb_control_in;
            read_data_out <= read_data_in;
            alu_result_out <= alu_result_in;
            write_reg_out <= write_reg_in;
        end
    end

endmodule
