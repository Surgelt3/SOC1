module w_router (
    input [31:0] m_wdata,
    input [3:0] m_wstrb,
    input m_wlast, m_wvalid,
    output reg m_wready,

    output reg [31:0] s_wdata0, s_wdata1, s_wdata2, s_wdata3, s_wdata4, 
    output reg [3:0] s_wstrb0, s_wstrb1, s_wstrb2, s_wstrb3, s_wstrb4, 
    output reg s_wlast0, s_wlast1, s_wlast2, s_wlast3, s_wlast4, s_wvalid0, s_wvalid1, s_wvalid2, s_wvalid3, s_wvalid4, 
    input s_wready0, s_wready1, s_wready2, s_wready3, s_wready4, 

    input [2:0] aw_sel_q
);

    always @(*) begin
        s_wlast0 = 1'b0;
        s_wlast1 = 1'b0;
        s_wlast2 = 1'b0;
        s_wlast3 = 1'b0;
        s_wlast4 = 1'b0;
        s_wvalid0 = 1'b0;
        s_wvalid1 = 1'b0;
        s_wvalid2 = 1'b0;
        s_wvalid3 = 1'b0;
        s_wvalid4 = 1'b0;
        s_wdata0 = m_wdata;
        s_wdata1 = m_wdata;
        s_wdata2 = m_wdata;
        s_wdata3 = m_wdata;
        s_wdata4 = m_wdata;
        s_wstrb0 = m_wstrb;
        s_wstrb1 = m_wstrb;
        s_wstrb2 = m_wstrb;
        s_wstrb3 = m_wstrb;
        s_wstrb4 = m_wstrb;
        
        case (aw_sel_q)
            3'b000: begin
                    s_wvalid0 = m_wvalid;
                    s_wlast0 = m_wlast;
                    m_wready = s_wready0;
                    end
            3'b001: begin
                    s_wvalid1 = m_wvalid;
                    s_wlast1 = m_wlast;
                    m_wready = s_wready1;
                    end
            3'b010: begin
                    s_wvalid2 = m_wvalid;
                    s_wlast2 = m_wlast;
                    m_wready = s_wready2;
                    end
            3'b011: begin
                    s_wvalid3 = m_wvalid;
                    s_wlast3 = m_wlast;
                    m_wready = s_wready3;
                    end
            3'b100: begin
                    s_wvalid4 = m_wvalid;
                    s_wlast4 = m_wlast;
                    m_wready = s_wready4;
                    end
            default: begin
                    s_wvalid0 = m_wvalid;
                    s_wlast0 = m_wlast;
                    m_wready = s_wready0;
                    end
        endcase
    end

endmodule