module addr_decode_axi (
    input [31:0] address,
    output [2:0] slave
);

    always @(*) begin
        case (in[31:16])
            16'h0000: slave = 3'd0; //BRAM
            16'h2000, 16'h2FFF: slave = 3'd1; //DDR
            16'hF000: slave = 3'd2; //UART
            16'hF001: slave = 3'd3; //GPIO
            16'hF001: slave = 3'd4 //DMA 
        endcase
    end

endmodule