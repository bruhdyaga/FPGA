module intbus_debug_top
(
    intbus_interf.debug     int_bus
);

intbus_debug intbus_debug_inst(
    .clk    (int_bus.clk      ),
    .probe0 (int_bus.resetn   ),
    .probe1 (int_bus.addr     ),
    .probe2 (int_bus.wdata    ),
    .probe3 (int_bus.rdata    ),
    .probe4 (int_bus.rvalid   ),
    .probe5 (int_bus.wr       ),
    .probe6 (int_bus.rd       ),
    .probe7 (int_bus.baseaddr ),
    .probe8 (int_bus.asize    )
);

endmodule