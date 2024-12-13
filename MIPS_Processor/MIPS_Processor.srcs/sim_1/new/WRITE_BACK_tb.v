`timescale 1ns / 1ps

module WB_STAGE_tb;

    // Inputs
    reg mem_to_reg;
    reg [31:0] read_dat;
    reg [31:0] addr;

    // Outputs
    wire [31:0] mux_out;

    // Instantiate the WB_STAGE module
    WB_STAGE WB_STAGE_uut (
        .mem_to_reg(mem_to_reg),
        .read_dat(read_dat),
        .addr(addr),
        .mux_out(mux_out)
    );

    // Test scenarios
    initial begin
        // Initialize inputs
        mem_to_reg = 0;
        read_dat = 32'h00000000;
        addr = 32'h00000000;

        // Test Case 1: Select address
        addr = 32'hDEADBEEF;      // Set address
        read_dat = 32'hCAFEBABE;  // Set read data
        mem_to_reg = 0;           // Select address
        #10;

        // Test Case 2: Select memory data
        mem_to_reg = 1;           // Select memory data
        #10;

        // Test Case 3: Change inputs
        addr = 32'h12345678;
        read_dat = 32'h87654321;
        mem_to_reg = 0;           // Select address
        #10;

        mem_to_reg = 1;           // Select memory data
        #10;

        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | MemToReg=%b | ReadData=%h | Addr=%h | MuxOut=%h",
                 $time, mem_to_reg, read_dat, addr, mux_out);
    end

endmodule
