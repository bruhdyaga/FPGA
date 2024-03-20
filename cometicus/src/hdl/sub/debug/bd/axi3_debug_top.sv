module axi3_debug_top
(
    axi3_interface.debug     axi3
);

axi3_debug axi3_debug_inst(
    .clk      (axi3.aclk   ),
    .probe0   (1'b0        ),
    .probe1   (axi3.resetn ),
    .probe2   (axi3.araddr ),
    .probe3   (axi3.arburst),
    .probe4   (axi3.arcache),
    .probe5   (axi3.arid   ),
    .probe6   (axi3.arlen  ),
    .probe7   (axi3.arlock ),
    .probe8   (axi3.arprot ),
    .probe9   (axi3.arqos  ),
    .probe10  (axi3.arready),
    .probe11  (axi3.arsize ),
    .probe12  (axi3.arvalid),
    .probe13  (axi3.awaddr ),
    .probe14  (axi3.awburst),
    .probe15  (axi3.awcache),
    .probe16  (axi3.awid   ),
    .probe17  (axi3.awlen  ),
    .probe18  (axi3.awlock ),
    .probe19  (axi3.awprot ),
    .probe20  (axi3.awqos  ),
    .probe21  (axi3.awready),
    .probe22  (axi3.awsize ),
    .probe23  (axi3.awvalid),
    .probe24  (axi3.bid    ),
    .probe25  (axi3.bready ),
    .probe26  (axi3.bresp  ),
    .probe27  (axi3.bvalid ),
    .probe28  (axi3.rdata  ),
    .probe29  (axi3.rid    ),
    .probe30  (axi3.rlast  ),
    .probe31  (axi3.rready ),
    .probe32  (axi3.rresp  ),
    .probe33  (axi3.rvalid ),
    .probe34  (axi3.wdata  ),
    .probe35  (axi3.wid    ),
    .probe36  (axi3.wlast  ),
    .probe37  (axi3.wready ),
    .probe38  (axi3.wstrb  ),
    .probe39  (axi3.wvalid )
);

endmodule