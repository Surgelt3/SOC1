module w_router #(
    parameter integer num_slaves = 5
)(
    input [31:0] m_wdata,
    input [3:0] m_wstrb,
    input m_wlast, m_wvalid,
    output m_wready,

    output reg [num_slaves-1:0][31:0] s_wdata,
    output reg [num_slaves-1:0][3:0] s_wstrb,
    output reg [num_slaves-1:0] s_wlast, s_wvalid,
    input [num_slaves-1:0] s_wready,

    input [2:0] aw_sel_q
);

    always @(*) begin
        s_wvalid = '0;
        s_wlast = '0;
        s_wdata = 'm_wdata;
        s_wstrb = 'm_wstrb;

        s_wvalid[aw_sel_q] = m_wvalid;
        s_wlast[aw_sel_q] = m_wlast;
    end

    assign m_wready = s_wready[aw_sel_q];

endmodule