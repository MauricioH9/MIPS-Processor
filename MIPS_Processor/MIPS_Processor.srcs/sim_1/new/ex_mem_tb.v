`timescale 1ns / 1ps

module ex_mem_tb;

    reg rst, clk;
    reg test_aluzero;
    reg [1:0] test_ctlwb;
    reg [2:0] test_ctlm;
    reg [31:0] test_adder_out, test_alu_out, test_read_dat2;
    reg [4:0] test_mux_out;
    
    wire test_zero;
    wire [1:0] test_wb_out;
    wire [2:0] test_m_out;
    wire [31:0] test_adder_result, test_alu_result, test_dat2_out;
    wire [4:0] test_mux_result;
    
    ex_mem ex_mem_uut(
        .clk(clk),
        .rst(rst),
        .aluzero(test_aluzero),
        .ctlwb_out(test_ctlwb),
        .ctlm_out(test_ctlm),
        .adder_out(test_adder_out),
        .alu_out(test_alu_out),
        .read_dat2(test_read_dat2),
        .mux_out(test_mux_out),
        .zero(test_zero),
        .wb_out(test_wb_out),
        .m_out(test_m_out),
        .adder_result(test_adder_result),
        .alu_result(test_alu_result),
        .dat2_out(test_dat2_out),
        .mux_result(test_mux_result)
    );
    
    initial clk = 0;
    always #1 clk = ~clk;
    
    initial begin
        rst = 1;
        test_ctlwb = 2'b10;
        test_ctlm = 3'b011;
        test_adder_out = 32'h00004ACD;
        test_alu_out = 32'h00483212;
        test_read_dat2 = 32'h0000CCCC;
        test_mux_out = 5'b11001;
        test_aluzero = 1;
        #10
        rst = 0;
        #20
        $finish;
    end
    
endmodule
