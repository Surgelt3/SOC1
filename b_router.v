module b_router #(
    parameter integer num_slaves = 5
)(
    output [1:0] m_bresp,
    output m_bvalid,
    input m_bready,

    input [num_slaves-1:0][1:0] s_bresp,
    input [num_slaves-1:0] s_bvalid,
    output [num_slaves-1:0] s_bready,

    input [2:0] aw_sel_q
);

    assign m_bresp = s_rresp[aw_sel_q];
    assign m_bvalid = s_bvalid[aw_sel_q];

    genvar j;
    generate
        for (j=0; j<num_slaves; j = j + 1) begin: GEN_READY
            assign s_bready[j] = (aw_sel_q == j) ? m_bready : 1'b0;
        end
    endgenerate

endmodule