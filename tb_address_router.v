`timescale 1ns/1ps
module tb_address_router;

    
    reg clk, reset;
    reg [31:0] m_addr;
    reg [7:0] m_len;
    reg [2:0] m_size;
    reg [1:0] m_burst;
    reg m_valid;
    wire m_ready;
    wire [31:0] s_addr0, s_addr1, s_addr2, s_addr3, s_addr4;
    wire [7:0] s_len0, s_len1, s_len2, s_len3, s_len4;
    wire [2:0] s_size0, s_size1, s_size2, s_size3, s_size4;
    wire [1:0] s_burst0, s_burst1, s_burst2, s_burst3, s_burst4;
    wire s_valid0, s_valid1, s_valid2, s_valid3, s_valid4;
    reg s_ready0, s_ready1, s_ready2, s_ready3, s_ready4;
    wire [2:0] sel_q;
    
    
    address_router ar(
        clk, reset,
        m_addr,
        m_len,
        m_size, 
        m_burst,
        m_valid, 
        
        m_ready,
    
        s_addr0, s_addr1, s_addr2, s_addr3, s_addr4,
        s_len0, s_len1, s_len2, s_len3, s_len4, 
        s_size0, s_size1, s_size2, s_size3, s_size4,
        s_burst0, s_burst1, s_burst2, s_burst3, s_burst4, 
        s_valid0, s_valid1, s_valid2, s_valid3, s_valid4, 
    
        s_ready0, s_ready1, s_ready2, s_ready3, s_ready4,
    
        sel_q
    );

    

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        m_addr  = 32'h0000_0000;
        m_len   = 8'd7;
        m_size  = 3'd2;
        m_burst = 2'b01;
        m_valid = 0;
        s_ready0 = 1;
        s_ready1 = 1;
        s_ready2 = 1;
        s_ready3 = 1;
        s_ready4 = 1;

        // reset
        #2  reset = 1;
        #20 reset = 0;

        @(posedge clk);
        m_valid = 0;
        m_addr  = 32'h0000_0010;
        @(posedge clk);
        m_valid = 1; //sel_q should equal 0
        @(posedge clk);
        m_valid = 0;

        repeat(3) @(posedge clk);
        m_valid = 0;
        m_addr  = 32'h2000_0010;
        @(posedge clk);
        m_valid = 1; //sel_q should equal 1
        @(posedge clk);
        m_valid = 0;
        
        repeat(3) @(posedge clk);
        m_valid = 1;
        m_addr  = 32'hF000_0010;
        @(posedge clk);
        m_valid = 0; //sel_q should equal 2

        repeat(3) @(posedge clk);
        m_valid = 1;
        m_addr  = 32'hF001_0010;
        @(posedge clk);
        m_valid = 0; //sel_q should equal 3
        
        repeat(3) @(posedge clk);
        m_valid = 1;
        m_addr  = 32'hF002_0010;
        @(posedge clk);
        m_valid = 0; //sel_q should equal 4

        repeat(3) @(posedge clk);
        s_ready3 = 1;
        m_valid = 1;
        m_addr  = 32'h2000_0010;
        @(posedge clk);
        m_valid = 0; //sel_q should equal 1
        repeat(2) @(posedge clk);
        s_ready3 = 1; //sel_q should equal 1

    end

endmodule
