interface axi4_stream_interface#(
    parameter  D_WIDTH  = 32
)
();

/// Bus signals
logic                aclk;
logic [D_WIDTH-1:0]  tdata;
logic                tvalid;
logic                tready;



modport master
(
    output aclk,
    output tdata,
    output tvalid,
    input  tready
);

modport slave
(
    input  aclk,
    input  tdata,
    input  tvalid,
    output tready
);

modport debug
(
    input aclk,
    input tdata,
    input tvalid,
    input tready
);

endinterface

module axi4_stream_converter_64_to_32(
    axi4_stream_interface.slave  s_axis_data_64,
    axi4_stream_interface.master m_axis_data_64,
    axi4_stream_interface.slave  s_axis_data_32,
    axi4_stream_interface.master m_axis_data_32
);

logic m_mux = '0;
logic s_mux = '0;

// ila_axi_converter ILA(
    // .clk_0     (s_axis_data_32.aclk  ),
    // .probe0_0  (s_axis_data_64.tdata ),
    // .probe1_0  (s_axis_data_64.tvalid),
    // .probe2_0  (s_axis_data_64.tready),
    // .probe3_0  (m_axis_data_64.tdata ),
    // .probe4_0  (m_axis_data_64.tvalid),
    // .probe5_0  (m_axis_data_64.tready),
    // .probe6_0  (s_axis_data_32.tdata ),
    // .probe7_0  (s_axis_data_32.tvalid),
    // .probe8_0  (s_axis_data_32.tready),
    // .probe9_0  (m_axis_data_32.tdata ),
    // .probe10_0 (m_axis_data_32.tvalid),
    // .probe11_0 (m_axis_data_32.tready),
    // .probe12_0 (m_mux),
    // .probe13_0 (s_mux)
// );

assign m_axis_data_32.aclk   = s_axis_data_64.aclk;
assign m_axis_data_32.tdata  = m_mux ? s_axis_data_64.tdata[63:32] : s_axis_data_64.tdata[31:0];
assign m_axis_data_32.tvalid = s_axis_data_64.tvalid;
assign s_axis_data_64.tready = m_axis_data_32.tready & m_mux;

always_ff@(posedge s_axis_data_64.aclk) begin
    if(m_axis_data_32.tready & m_axis_data_32.tvalid) begin
        m_mux <= !m_mux;
    end
end

assign m_axis_data_64.aclk   = s_axis_data_32.aclk;
assign s_axis_data_32.tready = m_axis_data_64.tready;
always_ff@(posedge m_axis_data_64.aclk) begin
    if(s_mux) begin
        m_axis_data_64.tdata[63:32] = s_axis_data_32.tdata;
    end else begin
        m_axis_data_64.tdata[31:0] = s_axis_data_32.tdata;
    end
end

always_ff@(posedge m_axis_data_64.aclk) begin
    if(s_axis_data_32.tvalid & s_axis_data_32.tready) begin
        s_mux <= !s_mux;
    end
end

always_ff@(posedge m_axis_data_64.aclk) begin
    if(m_axis_data_64.tvalid & m_axis_data_64.tready) begin
        m_axis_data_64.tvalid <= '0;
    end else if(s_axis_data_32.tvalid & s_axis_data_32.tready & s_mux) begin
        m_axis_data_64.tvalid <= '1;
    end
end

initial m_axis_data_64.tvalid <= '0;

endmodule