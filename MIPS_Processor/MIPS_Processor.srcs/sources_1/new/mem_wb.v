`timescale 1ns / 1ps

module mem_wb(
    input clk, rst,
    input wire [1:0] id_ex_wb,
    input wire [4:0] mux_5bit,
    input wire [31:0] addr, d_mem_dat,
    
    output reg reg_write, mem_to_reg,
    output reg [4:0] bits5_mux,
    output reg [31:0] read_dat, mem_addr
    );
    
    initial begin
        reg_write <= 0;
        mem_to_reg <= 0;
        bits5_mux <= 0;
        read_dat <= 0;
        mem_addr <= 0;
    end
    
    always @(posedge clk)
        if(rst) begin
            reg_write <= 0;
            mem_to_reg <= 0;
            
            bits5_mux <= 0;
            read_dat <= 0;
            mem_addr <= 0;
        end else begin
            reg_write <= id_ex_wb[1];
            mem_to_reg <= id_ex_wb[0];
            
            bits5_mux <= mux_5bit;
            read_dat <= d_mem_dat;
            mem_addr <= addr;
        end
endmodule