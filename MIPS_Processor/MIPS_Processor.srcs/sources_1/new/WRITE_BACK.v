`timescale 1ns / 1ps

module WB_STAGE(
    input mem_to_reg,
    input [31:0] read_dat, addr,
    output [31:0] mux_out
    );
    
    mux mux1(
        .a(addr),
        .b(read_dat),
        .sel(mem_to_reg),
        .y(mux_out)
    );
endmodule