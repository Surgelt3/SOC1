module r_router (
    output reg [31:0] m_rdata,
    output reg [1:0] m_rresp,
    output reg m_rlast, m_rvalid,
    input m_rready,

    input [31:0] s_rdata0, s_rdata1, s_rdata2, s_rdata3, s_rdata4, 
    input [1:0] s_rresp0, s_rresp1, s_rresp2, s_rresp3, s_rresp4, 
    input s_rlast0, s_rlast1, s_rlast2, s_rlast3, s_rlast4, s_rvalid0, s_rvalid1, s_rvalid2, s_rvalid3, s_rvalid4, 
    output reg s_rready0, s_rready1, s_rready2, s_rready3, s_rready4,

    input [2:0] ar_sel_q
);

    
    always @(*) begin
        s_rready0 = 1'b0;
        s_rready1 = 1'b0;
        s_rready2 = 1'b0;
        s_rready3 = 1'b0;
        s_rready4 = 1'b0;
        case (ar_sel_q)
            3'b000: begin
                    m_rdata = s_rdata0;
                    m_rresp = s_rresp0;
                    m_rlast = s_rlast0;
                    m_rvalid = s_rvalid0;
                    s_rready0 = m_rready;
                    end
            3'b001: begin
                    m_rdata = s_rdata1;
                    m_rresp = s_rresp1;
                    m_rlast = s_rlast1;
                    m_rvalid = s_rvalid1;
                    s_rready1 = m_rready;
                    end
            3'b010: begin
                    m_rdata = s_rdata2;
                    m_rresp = s_rresp2;
                    m_rlast = s_rlast2;
                    m_rvalid = s_rvalid2;
                    s_rready2 = m_rready;
                    end
            3'b011: begin
                    m_rdata = s_rdata3;
                    m_rresp = s_rresp3;
                    m_rlast = s_rlast3;
                    m_rvalid = s_rvalid3;
                    s_rready3 = m_rready;
                    end
            3'b100: begin
                    m_rdata = s_rdata4;
                    m_rresp = s_rresp4;
                    m_rlast = s_rlast4;
                    m_rvalid = s_rvalid4;
                    s_rready4 = m_rready;
                    end
            default: begin
                    m_rdata = s_rdata0;
                    m_rresp = s_rresp0;
                    m_rlast = s_rlast0;
                    m_rvalid = s_rvalid0;
                    s_rready0 = m_rready;
                    end
        endcase
    
    end

endmodule