module axi_vexriscv_master(
    input clk, reset,
    // Master AW
    output reg [31:0] m_awaddr,
    output [7:0] m_awlen,
    output [2:0] m_awsize, 
    output [1:0] m_awburst,
    output reg m_awvalid, 
    input m_awready,
    // Master W
    output reg [31:0] m_wdata,
    output reg [3:0] m_wstrb,
    output reg m_wlast, m_wvalid,
    input m_wready,
    // Master B
    output reg m_bready,
    input [1:0] m_bresp,
    input m_bvalid,
    // Master AR
    output reg [31:0] m_araddr,
    output [7:0] m_arlen,
    output [2:0] m_arsize, 
    output [1:0] m_arburst,
    output reg m_arvalid, 
    input m_arready, 
    // Master R
    output reg m_rready,
    input [31:0] m_rdata, 
    input [1:0] m_rresp,
    input m_rlast, m_rvalid
);
    wire ibus_cmd_v;
    reg ibus_cmd_r;
    wire [31:0] ibus_addr;
    reg ibus_rsp_v;
    reg [31:0] ibus_rsp_data;
    reg ibus_rsp_err;
    wire dbus_cmd_v;
    reg dbus_cmd_r;
    wire dbus_wr;
    wire [31:0] dbus_addr;
    wire [31:0] dbus_wdata;
    wire [3:0] dbus_mask;
    wire [2:0] dbus_size;
    wire dbus_last;
    reg dbus_rsp_v;
    reg [31:0] dbus_rsp_data;
    reg dbus_rsp_err;



    VexRiscv core (
        //inputs
        .clk(clk),
        .reset(reset),
        .iBus_cmd_valid(ibus_cmd_v), //output
        .iBus_cmd_ready(ibus_cmd_r), //input
        .iBus_cmd_payload_address(ibus_addr), //output
        .iBus_cmd_payload_size(), //output
        //inputs
        .iBus_rsp_valid(ibus_rsp_v), 
        .iBus_rsp_payload_data(ibus_rsp_data),
        .iBus_rsp_payload_error(ibus_rsp_err),
        .dBus_cmd_valid(dbus_cmd_v), //output
        .dBus_cmd_ready(dbus_cmd_r), //input
        //outputs
        .dBus_cmd_payload_wr(dbus_wr),
        .dBus_cmd_payload_address(dbus_addr),
        .dBus_cmd_payload_data(dbus_wdata),
        .dBus_cmd_payload_mask(dbus_mask), 
        .dBus_cmd_payload_size(dbus_size),
        .dBus_cmd_payload_last(dbus_last),
        .dBus_cmd_payload_uncached(1'b0),
        //inputs
        .dBus_rsp_valid(dbus_rsp_v),
        .dBus_rsp_payload_data(dbus_rsp_data),
        .dBus_rsp_payload_error(dbus_rsp_err),
        .dBus_rsp_payload_last(),
        .timerInterrupt(1'b0),
        .externalInterrupt(1'b0),
        .softwareInterrupt(1'b0),
        .debug_bus_cmd_valid(1'b0),
        .debug_bus_cmd_ready(), //output
        //inputs
        .debug_bus_cmd_payload_wr(1'b0),
        .debug_bus_cmd_payload_address(8'h00),
        .debug_bus_cmd_payload_data(32'h0),
        .debug_bus_rsp_data(), //output
        .debug_resetOut(), //output
        .debugReset(1'b0) //input
    );
    

    assign m_awlen = 8'd0;
    assign m_arlen = 8'd0;
    assign m_awburst = 2'b01;
    assign m_arburst = 2'b01;
    assign m_awsize = 3'd2;
    assign m_arsize = 3'd2;
    
    localparam D_IDLE = 2'd0,
           D_WRITE = 2'd1,
           D_WRESP = 2'd2,
           D_READ = 2'd3;

    reg [1:0] d_state;
    
    always @(*) begin
        m_awaddr = dbus_addr;
        m_awvalid = d_state == D_WRITE;
        m_wdata = dbus_wdata;
        m_wstrb = dbus_mask;
        m_wvalid = d_state == D_WRITE;
        m_wlast = 1'b1;
        m_bready = d_state == D_WRESP;
        m_arvalid = d_state == D_READ;
        m_rready = 1'b1;
        
        ibus_cmd_r = m_arready & ~dbus_cmd_v;
        ibus_rsp_v = m_rvalid & ~dbus_cmd_v;
        ibus_rsp_data = m_rdata;
        ibus_rsp_err = |m_rresp;

        dbus_cmd_r = (d_state==D_IDLE);
        dbus_rsp_v = 1'b0;
        dbus_rsp_data = m_rdata;
        dbus_rsp_err = 1'b0;
        
        m_araddr = dbus_addr;
        
        case (d_state)
            D_WRITE: begin
                m_awvalid = 1'b1;
                m_wvalid  = 1'b1;
            end
            D_WRESP: begin
                m_bready  = 1'b1;
                dbus_rsp_v   = m_bvalid;
                dbus_rsp_err = |m_bresp;
            end
            D_READ: begin
                m_araddr  = dbus_addr;
                m_arvalid = 1'b1;
                ibus_cmd_r  = 1'b0;
                dbus_rsp_v   = m_rvalid;
                dbus_rsp_err = |m_rresp;
            end
        endcase        
    end
    
    always @(posedge clk) begin
        if (reset)
            d_state <= D_IDLE;
        else begin
            case (d_state) 
                D_IDLE: begin
                            if (dbus_cmd_v && dbus_wr) d_state <= D_WRITE; // if store
                            else if (dbus_cmd_v && !dbus_wr) d_state <= D_READ; // if read
                        end
                D_WRITE: if (m_awready && m_wready) d_state <= D_WRESP;
                D_WRESP: if (m_bvalid) d_state <= D_IDLE;
                D_READ: if (m_rvalid && m_rlast) d_state <= D_IDLE;
            endcase
        end
    end
endmodule
