//==============================================================
//  tb_address_router.v  –  unit-test for address_router
//==============================================================
`timescale 1ns/1ps
module tb_address_router;

    //----------------------------------------------------------
    //  Parameters
    //----------------------------------------------------------
    localparam NUM_SLAVES = 5;

    //----------------------------------------------------------
    //  DUT ports / wires
    //----------------------------------------------------------
    reg                  clk   = 0;
    reg                  rst_n = 0;

    // master -> router
    reg  [31:0]          m_addr;
    reg  [7:0]           m_len;
    reg  [2:0]           m_size;
    reg  [1:0]           m_burst;
    reg                  m_valid;
    wire                 m_ready;

    // router -> slaves
    wire [NUM_SLAVES-1:0][31:0] s_addr ;
    wire [NUM_SLAVES-1:0][7:0]  s_len  ;
    wire [NUM_SLAVES-1:0][2:0]  s_size ;
    wire [NUM_SLAVES-1:0][1:0]  s_burst;
    wire [NUM_SLAVES-1:0]       s_valid;
    reg  [NUM_SLAVES-1:0]       s_ready;

    // selection tag
    reg  [2:0]           slave;   // drives DUT
    wire [2:0]           sel_q;

    //----------------------------------------------------------
    //  Clock generator  (100 MHz)
    //----------------------------------------------------------
    always #5 clk = ~clk;

    //----------------------------------------------------------
    //  Instantiate DUT
    //----------------------------------------------------------
    address_router #(.num_slaves(NUM_SLAVES)) DUT (
        .clk     (clk),
        .reset   (~rst_n),
        .m_addr  (m_addr),
        .m_len   (m_len),
        .m_size  (m_size),
        .m_burst (m_burst),
        .m_valid (m_valid),
        .m_ready (m_ready),

        .s_addr  (s_addr),
        .s_len   (s_len),
        .s_size  (s_size),
        .s_burst (s_burst),
        .s_valid (s_valid),
        .s_ready (s_ready),

        .slave   (slave),
        .sel_q   (sel_q)
    );

    //----------------------------------------------------------
    //  Stimulus
    //----------------------------------------------------------
    integer i;
    initial begin
        // initialise
        m_addr  = 32'h0000_0000;
        m_len   = 8'd7;
        m_size  = 3'd2;
        m_burst = 2'b01;
        m_valid = 0;
        s_ready = '1;   // all slaves ready
        slave   = 3'd0;

        // reset
        #2  rst_n = 0;
        #20 rst_n = 1;

        // 1) write to slave 0
        @(posedge clk);
        slave   = 3'd0;
        m_valid = 1;
        m_addr  = 32'h0000_0010;
        @(posedge clk);
        m_valid = 0;                         // 1-cycle pulse

        // wait a few cycles
        repeat(3) @(posedge clk);

        // 2) hold slave 3 not ready to test back-pressure
        s_ready[3] = 0;
        slave   = 3'd3;
        m_addr  = 32'hF001_0004;
        m_valid = 1;
        @(posedge clk);
        m_valid = 0;

        // keep not-ready for two cycles
        repeat(2) @(posedge clk);
        s_ready[3] = 1;                      // now accepts

        repeat(3) @(posedge clk);

        // 3) another transfer to slave 1
        slave   = 3'd1;
        m_addr  = 32'h2000_1000;
        m_valid = 1;
        @(posedge clk);
        m_valid = 0;

        repeat(5) @(posedge clk);
        $finish;
    end

    //----------------------------------------------------------
    //  Waveform / console log
    //----------------------------------------------------------
    always @(posedge clk) begin
        $display("[%0t] valid=%0d ready=%0d sel=%0d q=%0d | s_valid=%0b s_ready=%0b",
                 $time, m_valid, m_ready, slave, sel_q, s_valid, s_ready);
    end

endmodule
