`timescale 1ns/1ps
module tb_top();

    
    reg clk, reset;
    reg uart_rx;
    wire uart_tx;    
    
    top dut(
        clk, reset,
        uart_rx, 
        uart_tx
    );
    

    

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        uart_rx = 0;
        
        // reset
        #2  reset = 1;
        #20 reset = 0;
        
    end

endmodule
