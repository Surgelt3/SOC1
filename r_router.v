module r_router #(
    parameter integer num_slaves = 5
)(
    output [31:0] m_rdata,
    output [1:0] m_rresp,
    output m_rlast, m_rvalid,
    input m_rready,

    input [num_slaves-1:0][31:0] s_rdata,
    input [num_slaves-1:0][1:0] s_rresp,
    input [num_slaves-1:0] s_rlast, s_rvalid,
    output [num_slaves-1:0] s_rready,

    input [2:0] ar_sel_q
);

    assign m_rdata = s_rdata[ar_sel_q];
    assign m_rresp = s_rresp[ar_sel_q];
    assign m_rlast = s_rlast[ar_sel_q];
    assign m_rvalid = s_rvalid[ar_sel_q];

    genvar j;
    generate
        for (j=0; j<num_slaves; j = j + 1) begin: GEN_READY
            assign s_rready[j] = (ar_sel_q == j) ? m_rready : 1'b0;
        end
    endgenerate

endmodule