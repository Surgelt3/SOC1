module b_router(
    output reg [1:0] m_bresp,
    output reg m_bvalid,
    input m_bready,

    input [1:0] s_bresp0, s_bresp1, s_bresp2, s_bresp3, s_bresp4, 
    input s_bvalid0, s_bvalid1, s_bvalid2, s_bvalid3, s_bvalid4,
    output reg s_bready0, s_bready1, s_bready2, s_bready3, s_bready4, 

    input [2:0] aw_sel_q
);

    always @(*) begin
        s_bready0 = 1'b0;
        s_bready1 = 1'b0;
        s_bready2 = 1'b0;
        s_bready3 = 1'b0;
        s_bready4 = 1'b0;
        case (aw_sel_q)
            3'b000: begin
                    m_bresp = s_bresp0;
                    m_bvalid = s_bvalid0;
                    s_bready0 = m_bready;
                    end
            3'b001: begin
                    m_bresp = s_bresp1;
                    m_bvalid = s_bvalid1;
                    s_bready1 = m_bready;
                    end
            3'b010: begin
                    m_bresp = s_bresp2;
                    m_bvalid = s_bvalid2;
                    s_bready2 = m_bready;
                    end
            3'b011: begin
                    m_bresp = s_bresp3;
                    m_bvalid = s_bvalid3;
                    s_bready3 = m_bready;
                    end
            3'b100: begin
                    m_bresp = s_bresp4;
                    m_bvalid = s_bvalid4;
                    s_bready4 = m_bready;
                    end
            default: begin
                    m_bresp = s_bresp0;
                    m_bvalid = s_bvalid0;
                    s_bready0 = m_bready;
                    end
        endcase
    end

endmodule