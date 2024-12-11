`timescale 1ns / 1ps

module EXECUTE_tb;

    reg clk;
    reg reset;
    // Inputs
    reg [1:0] wb_control_in;
    reg [2:0] mem_control_in;
    reg [3:0] ex_control_in;
    reg [31:0] npc_in;
    reg [31:0] reg_rs_in;
    reg [31:0] reg_rt_in;
    reg [31:0] sign_extended_in;
    reg [4:0] instr_rt_in;
    reg [4:0] instr_rd_in;
    reg [5:0] instr_function_in;
    // Outputs
    wire [1:0] wb_control_out;
    wire [2:0] mem_control_out;
    wire [31:0] alu_result_out;
    wire alu_zero_out;
    wire [31:0] reg_rt_out;
    wire [4:0] write_reg_out;

    // Instantiate EXECUTE 
    EXECUTE EXECUET_uut (
        .clk(clk),
        .reset(reset),
        .wb_control_in(wb_control_in),
        .mem_control_in(mem_control_in),
        .ex_control_in(ex_control_in),
        .npc_in(npc_in),
        .reg_rs_in(reg_rs_in),
        .reg_rt_in(reg_rt_in),
        .sign_extended_in(sign_extended_in),
        .instr_rt_in(instr_rt_in),
        .instr_rd_in(instr_rd_in),
        .instr_function_in(instr_function_in),
        .wb_control_out(wb_control_out),
        .mem_control_out(mem_control_out),
        .alu_result_out(alu_result_out),
        .alu_zero_out(alu_zero_out),
        .reg_rt_out(reg_rt_out),
        .write_reg_out(write_reg_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        wb_control_in = 2'b0;
        mem_control_in = 3'b0;
        ex_control_in = 4'b0;
        npc_in = 32'b0;
        reg_rs_in = 32'b0;
        reg_rt_in = 32'b0;
        sign_extended_in = 32'b0;
        instr_rt_in = 5'b0;
        instr_rd_in = 5'b0;
        instr_function_in = 6'b0;

        #10 reset = 0;

        // Test Case 1: Simple ADD (R-type instruction)
        wb_control_in = 2'b10;
        mem_control_in = 3'b101;
        ex_control_in = 4'b0110; // ALUOp = 10 (R-type), ALUSrc = 0
        npc_in = 32'h4;
        reg_rs_in = 32'd10;
        reg_rt_in = 32'd20;
        sign_extended_in = 32'd5;
        instr_rt_in = 5'd2;
        instr_rd_in = 5'd3;
        instr_function_in = 6'b100000; // ADD
        #10;

        // Test Case 2: Branch instruction
        ex_control_in = 4'b0010; // ALUOp = 01 (Branch), ALUSrc = 0
        reg_rs_in = 32'd30;
        reg_rt_in = 32'd30;
        instr_function_in = 6'b100010; // SUB
        #10;

        // Test Case 3: Immediate ADD instruction (I-type)
        ex_control_in = 4'b0011; // ALUOp = 00 (Immediate), ALUSrc = 1
        reg_rs_in = 32'd15;
        sign_extended_in = 32'd10;
        instr_rt_in = 5'd4;
        #10;

        // Test Case 4: RegDst selection (write to RD instead of RT)
        ex_control_in = 4'b1011; // RegDst = 1, ALUSrc = 1
        instr_rd_in = 5'd5;
        #10;

        reset = 1;
        #10 reset = 0;

        $stop;
    end

    initial begin
        $monitor("ALUControl=%b | ALUResult=%h | Zero=%b | WriteReg=%d | WBControl=%b | MEMControl=%b",
                 ex_control_in[2:1], alu_result_out, alu_zero_out, write_reg_out, wb_control_out, mem_control_out);
    end
endmodule
