module top(
    input clk, reset
);


    axi_vexriscv_master master0(
    clk, reset,
    // Master AW
    m_awaddr,
    m_awlen,
    m_awsize, 
    m_awburst,
    m_awvalid, 
    m_awready,
    // Master W
    m_wdata,
    m_wstrb,
    m_wlast, m_wvalid,
    m_wready,
    // Master B
    m_bready,
    m_bresp,
    m_bvalid,
    // Master AR
    m_araddr,
    m_arlen,
    m_arsize, 
    m_arburst,
    m_arvalid, 
    m_arready, 
    // Master R
    m_rready,
    m_rdata, 
    m_rresp,
    m_rlast, m_rvalid
);

    
    
    bram boot_ram(
        clk, 
        s_araddr,
        s_arvalid, s_rready,
        s_rdata,
        s_arready, s_rvalid
    );



endmodule