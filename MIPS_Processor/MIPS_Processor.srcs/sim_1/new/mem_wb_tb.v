`timescale 1ns / 1ps

module mem_wb_tb;

    reg clk, rst;
    
    reg [2:0] test_id_ex_wb;
    reg [4:0] test_mux_5bit;
    reg [31:0] test_addr;
    reg [31:0] test_d_mem_dat;

    wire test_reg_write;
    wire test_mem_to_reg;
    wire [4:0] test_bits5_mux;
    wire [31:0] test_read_dat;
    wire [31:0] test_mem_addr;

    // Instantiate the module
    mem_wb mem_wb_uut (
        .clk(clk),
        .rst(rst),
        .id_ex_wb(test_id_ex_wb),
        .mux_5bit(test_mux_5bit),
        .addr(test_addr),
        .d_mem_dat(test_d_mem_dat),
        .reg_write(test_reg_write),
        .mem_to_reg(test_mem_to_reg),
        .bits5_mux(test_bits5_mux),
        .read_dat(test_read_dat),
        .mem_addr(test_mem_addr)
    );

    initial clk <= 0;
    always #1 clk = ~clk;

    initial begin
        rst = 1;
        test_id_ex_wb = 3'b000;
        test_mux_5bit = 5'b00000;
        test_addr = 32'h00000000;
        test_d_mem_dat = 32'h00000000;

        #10;
        rst = 0;

        test_id_ex_wb = 3'b011;       // reg_write = 1, mem_to_reg = 1
        test_mux_5bit = 5'b10101;
        test_addr = 32'hAABBCCDD;
        test_d_mem_dat = 32'h11223344;
        
        #10;

        rst = 1;
        #10;
        
        rst = 0;

        test_id_ex_wb = 3'b101;       // reg_write = 1, mem_to_reg = 0
        test_mux_5bit = 5'b01010;
        test_addr = 32'h12345678;
        test_d_mem_dat = 32'h87654321;
        #10;

        $finish;
    end
endmodule

