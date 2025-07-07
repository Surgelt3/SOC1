module address_router(
    input clk, reset,
    input [31:0] m_addr,
    input [7:0] m_len,
    input [2:0] m_size, 
    input [1:0] m_burst,
    input m_valid, 
    
    output reg m_ready,

    output [31:0] s_addr0, s_addr1, s_addr2, s_addr3, s_addr4,
    output [7:0] s_len0, s_len1, s_len2, s_len3, s_len4, 
    output [2:0] s_size0, s_size1, s_size2, s_size3, s_size4,
    output [1:0] s_burst0, s_burst1, s_burst2, s_burst3, s_burst4, 
    output reg s_valid0, s_valid1, s_valid2, s_valid3, s_valid4, 

    input s_ready0, s_ready1, s_ready2, s_ready3, s_ready4,

    output reg [2:0] sel_q
);
    wire [2:0] slave;
    addr_decode_axi addr_decoder_a_router (
        m_addr[31:16], //input
        slave //output
    );
    
    assign {s_addr0, s_addr1, s_addr2, s_addr3, s_addr4} = {5{m_addr}};
    assign {s_len0, s_len1, s_len2, s_len3, s_len4} = {5{m_len}};
    assign {s_size0, s_size1, s_size2, s_size3, s_size4} = {5{m_size}};
    assign {s_burst0, s_burst1, s_burst2, s_burst3, s_burst4} = {5{m_burst}};

    always @(*) begin
        s_valid0 = 1'b0; 
        s_valid1 = 1'b0;
        s_valid2 = 1'b0;
        s_valid3 = 1'b0;
        s_valid4 = 1'b0;
        case (slave)
            3'b000: begin
                    m_ready = s_ready0;
                    s_valid0 = m_valid;
                    end
            3'b001: begin
                    m_ready = s_ready1;
                    s_valid1 = m_valid;
                    end
            3'b010: begin
                    m_ready = s_ready2;
                    s_valid2 = m_valid;
                    end
            3'b011: begin
                    m_ready = s_ready3;
                    s_valid3 = m_valid;
                    end
            3'b100: begin
                    m_ready = s_ready4;
                    s_valid4 = m_valid;
                    end
            default: begin
                    m_ready = s_ready0;
                    s_valid0 = m_valid;
                    end            
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            sel_q <= 3'd0;
        end else if (m_valid && m_ready) begin
            sel_q <= slave;
        end
    end

endmodule