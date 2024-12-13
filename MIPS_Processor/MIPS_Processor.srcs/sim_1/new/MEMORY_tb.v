`timescale 1ns / 1ps

module MEM_STAGE_tb;

    // Inputs
    reg rst;
    reg clk;
    reg alu_zero;
    reg [1:0] ex_wb;
    reg [2:0] ex_m;
    reg [4:0] in_5bitmux;
    reg [31:0] mem_addr;
    reg [31:0] write_dat;

    // Outputs
    wire reg_to_write;
    wire mem_to_reg;
    wire PCSrc;
    wire [4:0] mux_5bit;
    wire [31:0] wb_dat;
    wire [31:0] addr_out;

    // Instantiate the MEM_STAGE module
    MEM_STAGE MEM_STAGE_uut (
        .rst(rst),
        .clk(clk),
        .alu_zero(alu_zero),
        .ex_wb(ex_wb),
        .ex_m(ex_m),
        .in_5bitmux(in_5bitmux),
        .mem_addr(mem_addr),
        .write_dat(write_dat),
        .reg_to_write(reg_to_write),
        .mem_to_reg(mem_to_reg),
        .PCSrc(PCSrc),
        .mux_5bit(mux_5bit),
        .wb_dat(wb_dat),
        .addr_out(addr_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
        // Initialize inputs
        rst = 1;
        alu_zero = 0;
        ex_wb = 2'b00;
        ex_m = 3'b000;
        in_5bitmux = 5'b0;
        mem_addr = 32'b0;
        write_dat = 32'b0;

        // Reset
        #10 rst = 0;

        // Test Case 1: Write to memory
        ex_m = 3'b001;         // mem_write = 1
        mem_addr = 32'h10;     // Memory address
        write_dat = 32'hDEADBEEF; // Data to write
        #10 ex_m = 3'b000;     // Stop writing

        // Test Case 2: Read from memory
        ex_m = 3'b010;         // mem_read = 1
        mem_addr = 32'h10;     // Address to read
        #10 ex_m = 3'b000;     // Stop reading

        // Test Case 3: Branch decision (PCSrc)
        ex_m = 3'b100;         // Branch control
        alu_zero = 1;          // ALU zero flag is true
        #10 alu_zero = 0;      // ALU zero flag is false

        // Test Case 4: MEM/WB latch forwarding
        ex_wb = 2'b11;         // RegWrite and MemToReg enabled
        in_5bitmux = 5'd10;    // Write to register 10
        mem_addr = 32'h20;     // Forwarded memory address
        write_dat = 32'hCAFEBABE; // Data to write
        #10;

        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | RegToWrite=%b | MemToReg=%b | PCSrc=%b | Mux_5bit=%d | WbData=%h | AddrOut=%h",
                 $time, reg_to_write, mem_to_reg, PCSrc, mux_5bit, wb_dat, addr_out);
    end

endmodule
