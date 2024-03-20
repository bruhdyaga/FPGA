module axi3_inject
#(

)
(
    axi3_interface.master         master_axi3,
    axi3_interface.slave          slave_axi3,
    axi4_stream_interface.slave   slave_axi3_stream
);

always_comb begin
    master_axi3.aclk    <= slave_axi3.aclk   ;
    master_axi3.araddr  <= '0;
    master_axi3.arburst <= '0;
    master_axi3.arcache <= '0;
    master_axi3.arid    <= '0;
    master_axi3.arlen   <= '0;
    master_axi3.arlock  <= '0;
    master_axi3.arprot  <= '0;
    master_axi3.arqos   <= '0;
    master_axi3.arsize  <= '0;
    master_axi3.arvalid <= '0;
    master_axi3.awaddr  <= slave_axi3.awaddr ;
    master_axi3.awburst <= slave_axi3.awburst;
    master_axi3.awcache <= slave_axi3.awcache;
    master_axi3.awid    <= slave_axi3.awid   ;
    master_axi3.awlen   <= slave_axi3.awlen  ;
    master_axi3.awlock  <= slave_axi3.awlock ;
    master_axi3.awprot  <= slave_axi3.awprot ;
    master_axi3.awqos   <= slave_axi3.awqos  ;
    master_axi3.awsize  <= slave_axi3.awsize ;
    master_axi3.awvalid <= slave_axi3.awvalid;
    master_axi3.bready  <= slave_axi3.bready ;
    master_axi3.rready  <= '0;
    master_axi3.wdata   <= slave_axi3.wdata  ;
    master_axi3.wid     <= slave_axi3.wid    ;
    master_axi3.wlast   <= slave_axi3.wlast  ;
    master_axi3.wstrb   <= slave_axi3.wstrb  ;
    master_axi3.wvalid  <= slave_axi3.wvalid ;

    slave_axi3.arready <= '0;
    slave_axi3.awready <= master_axi3.awready;
    slave_axi3.bid     <= master_axi3.bid    ;
    slave_axi3.bresp   <= master_axi3.bresp  ;
    slave_axi3.bvalid  <= master_axi3.bvalid ;
    slave_axi3.rdata   <= slave_axi3_stream.tdata;
    slave_axi3.rid     <= '0;
    slave_axi3.rlast   <= '1;
    slave_axi3.rresp   <= '0; // OKAY
    slave_axi3.rvalid  <= slave_axi3_stream.tvalid;
    slave_axi3.wready  <= master_axi3.wready ;

    slave_axi3_stream.tready <= slave_axi3.rready;
end

endmodule