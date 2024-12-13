`timescale 1ns / 1ps

module MEM_STAGE(
    input rst, clk,
    input alu_zero,
    input [1:0] ex_wb,
    input [2:0] ex_m,
    input [4:0] in_5bitmux,
    input [31:0] mem_addr, write_dat,
    output reg_to_write, mem_to_reg, PCSrc,
    output [4:0] mux_5bit,
    output [31:0] wb_dat, addr_out
    );
    
    // Wires
    wire [31:0] read_dat;
    
    d_mem d_mem1(
        .clk(clk),
        .rst(rst),
        .mem_write(ex_m[0]),
        .mem_read(ex_m[1]),
        .write_dat(write_dat),
        .addr(mem_addr),
        
        .read_dat(read_dat)
    );
    
    mem_wb mem_wb1(
        .clk(clk),
        .rst(rst),
        .id_ex_wb(ex_wb),
        .mux_5bit(in_5bitmux),
        .addr(mem_addr),
        .d_mem_dat(read_dat),
        
        .reg_write(reg_to_write),
        .mem_to_reg(mem_to_reg),
        .bits5_mux(mux_5bit),
        .read_dat(wb_dat),
        .mem_addr(addr_out)
    );
    
    // Branch and gate
    assign PCSrc = ex_m[2] & alu_zero;
    
endmodule