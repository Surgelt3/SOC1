module address_router#(
    parameter integer num_slaves = 5
)(
    input clk, reset,
    input [31:0] m_addr,
    input [7:0] m_len,
    input [2:0] m_size, 
    input [1:0] m_burst,
    input m_valid, 
    
    output m_ready,

    output reg [num_slaves-1:0][31:0] s_addr,
    output reg [num_slaves-1:0][7:0] s_len,
    output reg [num_slaves-1:0][2:0] s_size,
    output reg [num_slaves-1:0][1:0] s_burst,
    output reg [num_slaves-1:0] s_valid,

    input [num_slaves-1:0] s_ready,

    input [2:0] slave,
    output reg [2:0] sel_q
);

    always @(*) begin
        s_valid = '0;
        s_addr = 'm_addr;
        s_len = 'm_len;
        s_size = 'm_size;
        s_burst = 'm_burst;
        s_valid[slave] = 'm_valid;
    end

    assign m_ready = s_ready[slave];

    always @(posedge clk) begin
        if (reset) begin
            sel_q <= 3'd0;
        end else if (m_valid && m_ready) begin
            sel_q <= slave;
        end
    end

endmodule