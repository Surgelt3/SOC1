module axi_xbar (
    input clk, reset,
    // Master AW
    input [31:0] m_awaddr,
    input [7:0] m_awlen,
    input [2:0] m_awsize, 
    input [1:0] m_awburst,
    input m_awvalid, 
    output m_awready,
    // Master W
    input [31:0] m_wdata,
    input [3:0] m_wstrb,
    input m_wlast, m_wvalid,
    output m_wready,
    // Master B
    input m_bready,
    output [1:0] m_bresp,
    output m_bvalid,
    // Master AR
    input [31:0] m_araddr,
    input [7:0] m_arlen,
    input [2:0] m_arsize, 
    input [1:0] m_arburst,
    input m_arvalid, 
    output m_arready, 
    // Master R
    input m_rready,
    output [31:0] m_rdata, 
    output [1:0] m_rresp,
    output m_rlast, m_rvalid,
    // Slave AW
    input s_awready0, s_awready1, s_awready2, s_awready3, s_awready4,
    output [31:0] s_awaddr0, s_awaddr1, s_awaddr2, s_awaddr3, s_awaddr4,
    output [7:0] s_awlen0, s_awlen1, s_awlen2, s_awlen3, s_awlen4,
    output [2:0] s_awsize0, s_awsize1, s_awsize2, s_awsize3, s_awsize4,
    output [1:0] s_awburst0, s_awburst1, s_awburst2, s_awburst3, s_awburst4,
    output s_awvalid0, s_awvalid1, s_awvalid2, s_awvalid3, s_awvalid4,
    // Slave W
    input s_wready0, s_wready1, s_wready2, s_wready3, s_wready4,
    output [31:0] s_wdata0, s_wdata1, s_wdata2, s_wdata3, s_wdata4,
    output [3:0] s_wstrb0, s_wstrb1, s_wstrb2, s_wstrb3, s_wstrb4,
    output s_wlast0, s_wlast1, s_wlast2, s_wlast3, s_wlast4, s_wvalid0, s_wvalid1, s_wvalid2, s_wvalid3, s_wvalid4,
    // Slave B
    input [1:0] s_bresp0, s_bresp1, s_bresp2, s_bresp3, s_bresp4,
    input s_bvalid0, s_bvalid1, s_bvalid2, s_bvalid3, s_bvalid4,
    output s_bready0, s_bready1, s_bready2, s_bready3, s_bready4,
    // Slave AR
    input s_arready0, s_arready1, s_arready2, s_arready3, s_arready4,
    output [31:0] s_araddr0, as_addr1, s_araddr2, s_araddr3, s_araddr4,
    output [7:0] s_arlen0, s_arlen1, s_arlen2, s_arlen3, s_arlen4,
    output [2:0] s_arsize0, s_arsize1, s_arsize2, s_arsize3, s_arsize4,
    output [1:0] s_arburst0, s_arburst1, s_arburst2, s_arburst3, s_arburst4,
    output s_arvalid0, s_arvalid1, s_arvalid2, s_arvalid3, s_arvalid4,
    // Slave R
    input [31:0] s_rdata0, s_rdata1, s_rdata2, s_rdata3, s_rdata4,
    input [1:0] s_rresp0, s_rresp1, s_rresp2, s_rresp3, s_rresp4,
    input s_rlast0, s_rlast1, s_rlast2, s_rlast3, s_rlast4, s_rvalid0, s_rvalid1, s_rvalid2, s_rvalid3, s_rvalid4,
    output s_rready0, s_rready1, s_rready2, s_rready3, s_rready4
);
    
    wire [2:0] ar_sel_q, aw_sel_q;
    
    address_router AR_router(
        //inputs
        clk, reset,
        m_araddr,
        m_arlen,
        m_arsize, 
        m_arburst,
        m_arvalid, 
        //outputs
        m_arready,
        s_araddr0, as_addr1, s_araddr2, s_araddr3, s_araddr4,
        s_arlen0, s_arlen1, s_arlen2, s_arlen3, s_arlen4, 
        s_arsize0, s_arsize1, s_arsize2, s_arsize3, s_arsize4,
        s_arburst0, s_arburst1, s_arburst2, s_arburst3, s_arburst4, 
        s_arvalid0, s_arvalid1, s_arvalid2, s_arvalid3, s_arvalid4, 
        s_arready0, s_arready1, s_arready2, s_arready3, s_arready4, //input
        ar_sel_q //output
    );
    
    address_router AW_router(
        //inputs
        clk, reset,
        m_awaddr,
        m_awlen,
        m_awsize, 
        m_awburst,
        m_awvalid, 
        //outputs
        m_awready,
        s_awaddr0, s_awaddr1, s_awaddr2, s_awaddr3, s_awaddr4,
        s_awlen0, s_awlen1, s_awlen2, s_awlen3, s_awlen4, 
        s_awsize0, s_awsize1, s_awsize2, s_awsize3, s_awsize4,
        s_awburst0, s_awburst1, s_awburst2, s_awburst3, s_awburst4, 
        s_awvalid0, s_awvalid1, s_awvalid2, s_awvalid3, s_awvalid4, //input
        s_awready0, s_awready1, s_awready2, s_awready3, s_awready4, //input
        aw_sel_q //output
    );

    w_router W_router(
        //inputs
        m_wdata,
        m_wstrb,
        m_wlast, m_wvalid,
        //outputs
        m_wready,
        s_wdata0, s_wdata1, s_wdata2, s_wdata3, s_wdata4, 
        s_wstrb0, s_wstrb1, s_wstrb2, s_wstrb3, s_wstrb4, 
        s_wlast0, s_wlast1, s_wlast2, s_wlast3, s_wlast4, s_wvalid0, s_wvalid1, s_wvalid2, s_wvalid3, s_wvalid4, 
        //inputs
        s_wready0, s_wready1, s_wready2, s_wready3, s_wready4, 
        aw_sel_q
    );

    b_router B_router (
        //output
        m_bresp,
        m_bvalid,
        //inputs
        m_bready,
        s_bresp0, s_bresp1, s_bresp2, s_bresp3, s_bresp4, 
        s_bvalid0, s_bvalid1, s_bvalid2, s_bvalid3, s_bvalid4,
        s_bready0, s_bready1, s_bready2, s_bready3, s_bready4, //output
        aw_sel_q //input
    );

    r_router R_router (
        //outputs
        m_rdata, 
        m_rresp,
        m_rlast, m_rvalid,
        //inputs
        m_rready,
        s_rdata0, s_rdata1, s_rdata2, s_rdata3, s_rdata4, 
        s_rresp0, s_rresp1, s_rresp2, s_rresp3, s_rresp4, 
        s_rlast0, s_rlast1, s_rlast2, s_rlast3, s_rlast4, s_rvalid0, s_rvalid1, s_rvalid2, s_rvalid3, s_rvalid4, 
        s_rready0, s_rready1, s_rready2, s_rready3, s_rready4, //output
        ar_sel_q //input
    );

endmodule