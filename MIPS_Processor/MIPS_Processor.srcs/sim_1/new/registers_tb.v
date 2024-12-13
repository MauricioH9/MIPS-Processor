`timescale 1ns / 1ps

module registers_tb;
    reg [4:0] test_rs, test_rd, test_rt;
    reg [31:0] test_write_data;
    reg clk, write_en, rst;
    
    wire [31:0] test_read1, test_read2;
    
    wire [31:0] reg0_out, reg1_out, reg2_out, reg3_out, reg4_out;
    wire [31:0] reg5_out, reg6_out, reg7_out, reg8_out, reg9_out;
    
    register register_uut(
        .rs(test_rs),
        .rd(test_rd),
        .rt(test_rt),
        .write_en(write_en),
        .write_data(test_write_data),
        .clk(clk),
        .rst(rst),
        .read_data1(test_read1),
        .read_data2(test_read2),
        .reg0_out(reg0_out),
        .reg1_out(reg1_out),
        .reg2_out(reg2_out),
        .reg3_out(reg3_out),
        .reg4_out(reg4_out),
        .reg5_out(reg5_out),
        .reg6_out(reg6_out),
        .reg7_out(reg7_out),
        .reg8_out(reg8_out),
        .reg9_out(reg9_out)
    );
    
    initial clk <= 0;
    always #1 clk <= ~clk;
    
    initial begin
        rst = 1;
        #10
        rst = 0;
        write_en = 0;
        test_rd = 5'b00000;
        test_rt = 5'b00000;
        test_rs = 5'b00000;
        test_write_data = 32'h00000000;
        #20
        write_en = 1;
        test_rd = 5'b00001;
        test_write_data = 32'h33334444;
        #10
        test_rd = 5'b00010;
        test_write_data = 32'hAAAAFFFF;
        #10
        test_rd = 6'b00011;
        test_write_data = 32'hBBBBCCCC;
        #10
        write_en = 0;
        test_rs = 5'b00001;
        test_rt = 5'b00010;
        #20
        $finish;
    end

endmodule
