module axi_xbar #(
    parameter integer num_slaves=5
)(
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
    input [num_slaves-1:0] s_awready,
    output [num_slaves-1:0][31:0] s_awaddr,
    output [num_slaves-1:0][7:0] s_awlen,
    output [num_slaves-1:0][2:0] s_awsize,
    output [num_slaves-1:0][1:0] s_awburst,
    output [num_slaves-1:0] s_awvalid,
    // Slave W
    input [num_slaves-1:0] s_wready,
    output [num_slaves-1:0][31:0] s_wdata,
    output [num_slaves-1:0][3:0] s_wstrb,
    output [num_slaves-1:0] s_wlast, s_wvalid,
    // Slave B
    input [num_slaves-1:0][1:0] s_bresp,
    input [num_slaves-1:0] s_bvalid,
    output [num_slaves-1:0] s_bready,
    // Slave AR
    input [num_slaves-1:0] s_arready,
    output [num_slaves-1:0][31:0] s_araddr,
    output [num_slaves-1:0][7:0] s_arlen,
    output [num_slaves-1:0][2:0] s_arsize,
    output [num_slaves-1:0][1:0] s_arburst,
    output [num_slaves-1:0] s_arvalid,
    // Slave R
    input [num_slaves-1:0][31:0] s_rdata,
    input [num_slaves-1:0][1:0] s_rresp,
    input [num_slaves-1:0] s_rlast, s_rvalid,
    output [num_slaves-1:0] s_rready
);
    
    wire [2:0] ar_sel_q, aw_sel_q, ar_slave, aw_slave;

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
        s_araddr,
        s_arlen,
        s_arsize,
        s_arburst,
        s_arvalid, 
        s_arready, //input
        arslave, //input
        ar_sel_q //output
    );

    addr_decode_axi AR_addr_decoder (
        m_araddr, //input
        ar_slave //output
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
        s_awaddr,
        s_awlen,
        s_awsize,
        s_awburst,
        s_awvalid, 
        s_awready, //input
        awslave, //input
        aw_sel_q //output
    );

    addr_decode_axi AW_addr_decoder (
        m_awaddr, //input
        aw_slave //output
    );

    w_router W_router(
        //inputs
        m_wdata,
        m_wstrb,
        m_wlast, m_wvalid,
        //outputs
        m_wready,
        s_wdata,
        s_wstrb,
        s_wlast, s_wvalid,
        //inputs
        s_wready,
        aw_sel_q
    );

    b_router B_router (
        //output
        m_bresp,
        m_bvalid,
        //inputs
        m_bready,
        s_bresp,
        s_bvalid,
        s_bready, //output
        aw_sel_q //input
    );

    r_router R_router (
        //outputs
        m_rdata, 
        m_rresp,
        m_rlast, m_rvalid,
        //inputs
        m_rready,
        s_rdata,
        s_rresp,
        s_rlast, s_rvalid,
        s_rready, //output
        ar_sel_q //input
    );

endmodule