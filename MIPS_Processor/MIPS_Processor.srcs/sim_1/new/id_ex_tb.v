`timescale 1ns / 1ps

module id_ex_tb;

    reg clk, rst;
    reg [1:0] test_ctrwb_out;
    reg [2:0] test_ctrm_out;
    reg [3:0] test_ctrex_out;
    reg [31:0] test_npc, test_read_dat1, test_read_dat2, test_signext_out;
    reg [4:0] test_instr_2016, test_instr_1511;

    wire [1:0] test_wb_ctrout;
    wire [2:0] test_m_ctrout;
    wire [3:0] test_ex_ctrout;
    wire [31:0] test_npc_out, test_rdat1_out, test_rdat2_out, test_out_ext;
    wire [4:0] test_out_2016, test_out_1511;

    id_ex id_ex_uut (
        .clk(clk),
        .rst(rst),
        .ctrwb_out(test_ctrwb_out),
        .ctrm_out(test_ctrm_out),
        .ctrex_out(test_ctrex_out),
        .npc(test_npc),
        .read_dat1(test_read_dat1),
        .read_dat2(test_read_dat2),
        .signext_out(test_signext_out),
        .instr_2016(test_instr_2016),
        .instr_1511(test_instr_1511),
        .wb_ctrout(test_wb_ctrout),
        .m_ctrout(test_m_ctrout),
        .ex_ctrout(test_ex_ctrout),
        .npc_out(test_npc_out),
        .rdat1_out(test_rdat1_out),
        .rdat2_out(test_rdat2_out),
        .out_ext(test_out_ext),
        .out_2016(test_out_2016),
        .out_1511(test_out_1511)
    );
    
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        rst = 1;
        test_ctrwb_out = 2'b11;
        test_ctrm_out = 3'b111;
        test_ctrex_out = 4'b1111;
        test_npc = 32'h11111111;
        test_read_dat1 = 32'h11111111;
        test_read_dat2 = 32'h11111111;
        test_signext_out = 32'h11111111;
        test_instr_2016 = 5'b11111;
        test_instr_1511 = 5'b11111;
        #20
        rst = 0;
        test_ctrwb_out = 2'b00;
        test_ctrm_out = 3'b000;
        test_ctrex_out = 4'b0000;
        test_npc = 32'h00000000;
        test_read_dat1 = 32'h00000000;
        test_read_dat2 = 32'h00000000;
        test_signext_out = 32'h00000000;
        test_instr_2016 = 5'b00000;
        test_instr_1511 = 5'b00000;
        #10;
        test_ctrwb_out = 2'b11;
        test_ctrm_out = 3'b101;
        test_ctrex_out = 4'b1100;
        test_npc = 32'h12345678;
        test_read_dat1 = 32'hAABBCCDD;
        test_read_dat2 = 32'h11223344;
        test_signext_out = 32'hFFFF0000;
        test_instr_2016 = 5'b10101;
        test_instr_1511 = 5'b01010;
        #10;
        test_ctrwb_out = 2'b10;
        test_ctrm_out = 3'b011;
        test_ctrex_out = 4'b1001;
        test_npc = 32'h87654321;
        test_read_dat1 = 32'h00FF00FF;
        test_read_dat2 = 32'hFF00FF00;
        test_signext_out = 32'h0000FFFF;
        test_instr_2016 = 5'b11111;
        test_instr_1511 = 5'b00001;
        #10;
        $finish;
    end

endmodule