`timescale 1ns / 1ps

module ex_mem(
    input clk, rst,
    input wire aluzero,
    input wire [1:0] ctlwb_out,
    input wire [2:0] ctlm_out,
    input wire [31:0] adder_out, alu_out, read_dat2,
    input wire [4:0] mux_out,
    output reg zero,
    output reg [1:0] wb_out,
    output reg [2:0] m_out,
    output reg [31:0] adder_result, alu_result, dat2_out,
    output reg [4:0] mux_result 
    );
    
    initial begin
        zero <= 0;
        wb_out <= 0;
        m_out <= 0;
        adder_result <= 0;
        alu_result <= 0;
        dat2_out <= 0;
        mux_result <= 0;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            zero <= 0;
            wb_out <= 0;
            m_out <= 0;
            adder_result <= 0;
            alu_result <= 0;
            dat2_out <= 0;
            mux_result <= 0;
        end 
        else begin
            zero <= aluzero;
            wb_out <= ctlwb_out;
            m_out <= ctlm_out;
            adder_result <= adder_out;
            alu_result <= alu_out;
            dat2_out <= read_dat2;
            mux_result <= mux_out;
        end
    end
    
endmodule