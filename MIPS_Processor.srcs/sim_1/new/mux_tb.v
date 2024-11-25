`timescale 1ns / 1ps

module mux_tb();
    //  inputs
    reg [31:0] a, b;
    reg sel;
    
    //outputs 
    wire [31:0] y;
    
    //unit under Test
    mux mux_uut(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
    );
    
    initial begin
    a = 32'hAAAAAAAA;
    b = 32'h55555555;
    sel = 1'b1; 
    #10; // increase time by 10 timee units    
    a = 32'h00000000;    
    #10;            
    sel = 1'b1;    
    #10;   
    b = 32'hFFFFFFFF;
    #5;   
    a = 32'hA5A5A5A5;
    #5;   
    sel = 1'b0;
    b = 32'hDDDDDDDD;
    #5    
    sel = 1'bx;      
    
    end
    
    always@(a or b or sel) begin   
        #1 $display("At t = %0d sel = %b a = %h b = %h y = %h", $time, sel, a, b, y);
        end
endmodule