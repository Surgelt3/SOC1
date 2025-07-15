module top(
    input clk, reset
);

    // Master AW
    wire [31:0] m_awaddr;
    wire [7:0] m_awlen;
    wire [2:0] m_awsize;
    wire [1:0] m_awburst;
    wire m_awvalid;
    wire m_awready;
    // Master W
    wire [31:0] m_wdata;
    wire [3:0] m_wstrb;
    wire m_wlast, m_wvalid;
    wire m_wready;
    // Master B
    wire m_bready;
    wire [1:0] m_bresp;
    wire m_bvalid;
    // Master AR
    wire [31:0] m_araddr;
    wire [7:0] m_arlen;
    wire [2:0] m_arsize; 
    wire [1:0] m_arburst;
    wire m_arvalid;
    wire m_arready; 
    // Master R
    wire m_rready;
    wire [31:0] m_rdata;
    wire [1:0] m_rresp;
    wire m_rlast, m_rvalid;
    // Slave AW
    wire s_awready0, s_awready1, s_awready2, s_awready3, s_awready4;
    wire [31:0] s_awaddr0, s_awaddr1, s_awaddr2, s_awaddr3, s_awaddr4;
    wire [7:0] s_awlen0, s_awlen1, s_awlen2, s_awlen3, s_awlen4;
    wire [2:0] s_awsize0, s_awsize1, s_awsize2, s_awsize3, s_awsize4;
    wire [1:0] s_awburst0, s_awburst1, s_awburst2, s_awburst3, s_awburst4;
    wire s_awvalid0, s_awvalid1, s_awvalid2, s_awvalid3, s_awvalid4;
    // Slave W
    wire s_wready0, s_wready1, s_wready2, s_wready3, s_wready4;
    wire [31:0] s_wdata0, s_wdata1, s_wdata2, s_wdata3, s_wdata4;
    wire [3:0] s_wstrb0, s_wstrb1, s_wstrb2, s_wstrb3, s_wstrb4;
    wire s_wlast0, s_wlast1, s_wlast2, s_wlast3, s_wlast4, s_wvalid0, s_wvalid1, s_wvalid2, s_wvalid3, s_wvalid4;
    // Slave B
    wire [1:0] s_bresp0, s_bresp1, s_bresp2, s_bresp3, s_bresp4;
    wire s_bvalid0, s_bvalid1, s_bvalid2, s_bvalid3, s_bvalid4;
    wire s_bready0, s_bready1, s_bready2, s_bready3, s_bready4;
    // Slave AR
    wire s_arready0, s_arready1, s_arready2, s_arready3, s_arready4;
    wire [31:0] s_araddr0, as_addr1, s_araddr2, s_araddr3, s_araddr4;
    wire [7:0] s_arlen0, s_arlen1, s_arlen2, s_arlen3, s_arlen4;
    wire [2:0] s_arsize0, s_arsize1, s_arsize2, s_arsize3, s_arsize4;
    wire [1:0] s_arburst0, s_arburst1, s_arburst2, s_arburst3, s_arburst4;
    wire s_arvalid0, s_arvalid1, s_arvalid2, s_arvalid3, s_arvalid4;
    // Slave R
    wire [31:0] s_rdata0, s_rdata1, s_rdata2, s_rdata3, s_rdata4;
    wire [1:0] s_rresp0, s_rresp1, s_rresp2, s_rresp3, s_rresp4;
    wire s_rlast0, s_rlast1, s_rlast2, s_rlast3, s_rlast4, s_rvalid0, s_rvalid1, s_rvalid2, s_rvalid3, s_rvalid4;
    wire s_rready0, s_rready1, s_rready2, s_rready3, s_rready4;

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
    
    axi_xbar Axi_xbar (
        clk, reset, //inputs
        // Master AW
        //inputs
        m_awaddr,
        m_awlen,
        m_awsize, 
        m_awburst,
        m_awvalid, 
        m_awready, //output
        // Master W
        //inputs
        m_wdata,
        m_wstrb,
        m_wlast, m_wvalid,
        m_wready, //output
        // Master B
        m_bready, //input
        //outputs
        m_bresp,
        m_bvalid,
        // Master AR
        //inputs
        m_araddr,
        m_arlen,
        m_arsize, 
        m_arburst,
        m_arvalid, 
        m_arready, //output
        // Master R
        m_rready, //input
        //outputs
        m_rdata, 
        m_rresp,
        m_rlast, m_rvalid,
        // Slave AW
        s_awready0, s_awready1, s_awready2, s_awready3, s_awready4, //input
        //outputs
        s_awaddr0, s_awaddr1, s_awaddr2, s_awaddr3, s_awaddr4,
        s_awlen0, s_awlen1, s_awlen2, s_awlen3, s_awlen4,
        s_awsize0, s_awsize1, s_awsize2, s_awsize3, s_awsize4,
        s_awburst0, s_awburst1, s_awburst2, s_awburst3, s_awburst4,
        s_awvalid0, s_awvalid1, s_awvalid2, s_awvalid3, s_awvalid4,
        // Slave W
        s_wready0, s_wready1, s_wready2, s_wready3, s_wready4, //input
        //outputs
        s_wdata0, s_wdata1, s_wdata2, s_wdata3, s_wdata4,
        s_wstrb0, s_wstrb1, s_wstrb2, s_wstrb3, s_wstrb4,
        s_wlast0, s_wlast1, s_wlast2, s_wlast3, s_wlast4, s_wvalid0, s_wvalid1, s_wvalid2, s_wvalid3, s_wvalid4,
        // Slave B
        //inputs
        s_bresp0, s_bresp1, s_bresp2, s_bresp3, s_bresp4,
        s_bvalid0, s_bvalid1, s_bvalid2, s_bvalid3, s_bvalid4,
        s_bready0, s_bready1, s_bready2, s_bready3, s_bready4, //output
        // Slave AR
        s_arready0, s_arready1, s_arready2, s_arready3, s_arready4, //input
        //outputs
        s_araddr0, as_addr1, s_araddr2, s_araddr3, s_araddr4,
        s_arlen0, s_arlen1, s_arlen2, s_arlen3, s_arlen4,
        s_arsize0, s_arsize1, s_arsize2, s_arsize3, s_arsize4,
        s_arburst0, s_arburst1, s_arburst2, s_arburst3, s_arburst4,
        s_arvalid0, s_arvalid1, s_arvalid2, s_arvalid3, s_arvalid4,
        // Slave R
        //inputs
        s_rdata0, s_rdata1, s_rdata2, s_rdata3, s_rdata4,
        s_rresp0, s_rresp1, s_rresp2, s_rresp3, s_rresp4,
        s_rlast0, s_rlast1, s_rlast2, s_rlast3, s_rlast4, s_rvalid0, s_rvalid1, s_rvalid2, s_rvalid3, s_rvalid4,
        s_rready0, s_rready1, s_rready2, s_rready3, s_rready4 //output
    );
    
    
    axi_uartlite_0 Uart_slave(
        clk,
        reset,
        , //add interupt
        s_awaddr2, //inputs
        s_awvalid2, //input
        s_awready2, //output
        s_wdata2, //input
        s_wstrb2, //input
        s_wvalid2, //input
        s_wready2, //output
        s_bresp2, //output
        s_bvalid2, //output
        s_bready2, //input
        s_araddr2, //input
        s_arvalid2, //input
        s_arready2, //output
        s_rdata2, //output
        s_rresp2, //output
        s_rvalid2, //output
        s_rready2, //input
        , //rx
        //tx
    );


    bram boot_ram(
        clk, 
        s_araddr0,
        s_arvalid0, s_rready0,
        s_rdata0,
        s_arready0, s_rvalid0
    );



endmodule