module bram(
    input clk, reset,
    input [31:0] s_araddr,
    input s_arvalid, s_rready,
    output reg [31:0] s_rdata,
    output [1:0] s_rresp,
    output reg s_arready, s_rvalid
);

    reg [31:0] mem [0:65536];
    
    assign s_rresp = 2'b00;
    
    initial $readmemh("boot.hex", mem);
    
    always @(posedge clk) begin
        if (s_arvalid && !s_arready) begin
            s_arready <= 1'b1;
            s_rdata <= mem[s_araddr[15:2]];
            s_rvalid <= 1'b1;
        end else begin
            s_arready <= 1'b0;
            if (s_rready)
                s_rvalid <= 1'b0;
        end
    end

endmodule
