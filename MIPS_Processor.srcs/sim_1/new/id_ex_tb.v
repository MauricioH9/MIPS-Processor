`timescale 1ns / 1ps

module id_ex_tb;

    reg clk;
    reg reset;

    // Inputs to the ID_EX module
    reg [3:0] controlEX_tb;
    reg [2:0] controlMEM_tb;
    reg [1:0] controlWB_tb;
    reg [31:0] if_id_npc_tb;
    reg [31:0] reg_rs_tb;
    reg [31:0] reg_rt_tb;
    reg [31:0] sign_ext_tb;
    reg [4:0] instr_rt_tb;
    reg [4:0] instr_rd_tb;

    // Outputs from the ID_EX module
    wire [3:0] ex_control_tb;
    wire [2:0] mem_control_tb;
    wire [1:0] wb_control_tb;
    wire [31:0] ex_npc_tb;
    wire [31:0] ex_reg_rs_tb;
    wire [31:0] ex_reg_rt_tb;
    wire [31:0] ex_sign_ext_tb;
    wire [4:0] ex_instr_rt_tb;
    wire [4:0] ex_instr_rd_tb;

    // Instantiate ID_EX module
    id_ex id_ex_uut (
        .clk(clk),
        .reset(reset),
        .controlEX(controlEX_tb),
        .controlMEM(controlMEM_tb),
        .controlWB(controlWB_tb),
        .if_id_npc(if_id_npc_tb),
        .reg_rs(reg_rs_tb),
        .reg_rt(reg_rt_tb),
        .sign_ext(sign_ext_tb),
        .instr_rt(instr_rt_tb),
        .instr_rd(instr_rd_tb),
        .ex_control(ex_control_tb),
        .mem_control(mem_control_tb),
        .wb_control(wb_control_tb),
        .ex_npc(ex_npc_tb),
        .ex_reg_rs(ex_reg_rs_tb),
        .ex_reg_rt(ex_reg_rt_tb),
        .ex_sign_ext(ex_sign_ext_tb),
        .ex_instr_rt(ex_instr_rt_tb),
        .ex_instr_rd(ex_instr_rd_tb)
    );

    //  Clock 
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Initialize Inputs and Simulate
    initial begin
        // Initialize all inputs
        reset = 1;         
        controlEX_tb = 4'b0;
        controlMEM_tb = 3'b0;
        controlWB_tb = 2'b0;
        if_id_npc_tb = 32'b0;
        reg_rs_tb = 32'b0;
        reg_rt_tb = 32'b0;
        sign_ext_tb = 32'b0;
        instr_rt_tb = 5'b0;
        instr_rd_tb = 5'b0;

        #10 reset = 0;    

        // Load instructions into the pipeline
        controlEX_tb = 4'b1100;
        controlMEM_tb = 3'b010;
        controlWB_tb = 2'b11;
        if_id_npc_tb = 32'h4;
        reg_rs_tb = 32'd5;
        reg_rt_tb = 32'd10;
        sign_ext_tb = 32'd15;
        instr_rt_tb = 5'b10001;
        instr_rd_tb = 5'b10010;

        #10; // Simulate for one cycle
        $display("Cycle 1 | Control Bits (EX): %b | Control Bits (MEM): %b | Control Bits (WB): %b | NPC: %0d | Reg[rs]: %0d | Reg[rt]: %0d | signExtended: %0d | Instr[20-16]: %b | Instr[15-11]: %b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        #10;
        controlEX_tb = 4'b1001;
        controlMEM_tb = 3'b001;
        controlWB_tb = 2'b10;
        if_id_npc_tb = 32'h8;
        reg_rs_tb = 32'd20;
        reg_rt_tb = 32'd30;
        sign_ext_tb = 32'd40;
        instr_rt_tb = 5'b01010;
        instr_rd_tb = 5'b01011;

        #10; // Simulate for 2nd cycle
        $display("Cycle 2 | Control Bits (EX): %b | Control Bits (MEM): %b | Control Bits (WB): %b | NPC: %0d | Reg[rs]: %0d | Reg[rt]: %0d | signExtended: %0d | Instr[20-16]: %b | Instr[15-11]: %b",
                 ex_control_tb, mem_control_tb, wb_control_tb, ex_npc_tb, ex_reg_rs_tb, ex_reg_rt_tb, ex_sign_ext_tb, ex_instr_rt_tb, ex_instr_rd_tb);

        $stop;
    end
endmodule
