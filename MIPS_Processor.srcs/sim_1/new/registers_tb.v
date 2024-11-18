`timescale 1ns / 1ps

module registers_tb;

    reg clk;
    reg RegWrite;
    reg [4:0] rs, rt, rd;
    reg [31:0] write_data;
    wire [31:0] read_data_rs, read_data_rt;

    // Instantiate the registers module
    registers registers_uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .write_data(write_data),
        .read_data_rs(read_data_rs),
        .read_data_rt(read_data_rt)
    );

    // Clock 
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        RegWrite = 0;
        rs = 0; rt = 0; rd = 0;
        write_data = 0;

        // Test Case 1: Read from register 0
        #10;
        rs = 5'b00000; // Read from register 0
        rt = 5'b00000; // Read from register 0
        #10;
        $display("TC1: Read Register 0 | rs=%d | rt=%d | read_data_rs=%h | read_data_rt=%h",
                 rs, rt, read_data_rs, read_data_rt);

        // Test Case 2: Write to register 1 and read back
        rd = 5'b00001; // Write to register 1
        write_data = 32'hA5A5A5A5; // Data to write
        RegWrite = 1; // Enable write
        #10;
        RegWrite = 0; // Disable write
        rs = 5'b00001; // Read from register 1
        rt = 5'b00001; // Read from register 1
        #10;
        $display("TC2: Write/Register 1 | rd=%d | write_data=%h | read_data_rs=%h | read_data_rt=%h",
                 rd, write_data, read_data_rs, read_data_rt);

        // Test Case 3: Attempt to write to register 0
        rd = 5'b00000; // Write to register 0
        write_data = 32'hDEADBEEF; // Data to write
        RegWrite = 1; // Enable write
        #10;
        RegWrite = 0; // Disable write
        rs = 5'b00000; // Read from register 0
        #10;
        $display("TC3: Write/Register 0 | rd=%d | write_data=%h | read_data_rs=%h",
                 rd, write_data, read_data_rs);

        // Test Case 4: Simultaneous read from different registers
        rs = 5'b00001; // Read from register 1
        rt = 5'b00000; // Read from register 0
        #10;
        $display("TC4: Simultaneous Read | rs=%d | rt=%d | read_data_rs=%h | read_data_rt=%h",
                 rs, rt, read_data_rs, read_data_rt);

        // Test Case 5: Write to register 2 and read back
        rd = 5'b00010; // Write to register 2
        write_data = 32'h12345678; // Data to write
        RegWrite = 1; // Enable write
        #10;
        RegWrite = 0; // Disable write
        rs = 5'b00010; // Read from register 2
        rt = 5'b00001; // Read from register 1
        #10;
        $display("TC5: Write/Register 2 | rd=%d | write_data=%h | read_data_rs=%h | read_data_rt=%h",
                 rd, write_data, read_data_rs, read_data_rt);

        $stop;
    end

endmodule
