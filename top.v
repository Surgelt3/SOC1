module top();

    wire dBus_cmd_valid, dBus_cmd_ready, dBus_cmd_payload_wr, dBus_cmd_payload_uncached;
    wire [31:0] dBus_cmd_payload_address, dBus_cmd_payload_data;
    wire [3:0] dBus_cmd_payload_mask;
    wire [2:0] dBus_cmd_payload_size;
    wire dBus_cmd_payload_last, dBus_rsp_valid, dBus_rsp_payload_last;
    wire [31:0] dBus_rsp_payload_data;
    wire dBus_rsp_payload_error, timerInterrupt, externalInterrupt, softwareInterrupt, debug_bus_cmd_valid; 
    reg debug_bus_cmd_ready; 
    wire debug_bus_cmd_payload_wr;
    wire [7:0] debug_bus_cmd_payload_address;
    wire [31:0] debug_bus_cmd_payload_data;
    reg [31:0] debug_bus_rsp_data;
    wire debug_resetOut, iBus_cmd_valid, iBus_cmd_ready;
    reg [31:0] iBus_cmd_payload_address;
    wire [2:0] iBus_cmd_payload_size;
    wire iBus_rsp_valid;
    wire [31:0] iBus_rsp_payload_data;
    wire iBus_rsp_payload_error, iBus_rsp_payload_error;
    wire clk, reset;
    wire debugReset;

    VexRiscv core(
        
    );


endmodule