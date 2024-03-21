module slowSigDly
#(
    parameter DELAY = 1
)
(
    input  iClk,
    input  iSig,
    output oSig
);

  reg  [$clog2(DELAY)-1:0] sCtnRE = '0;
  reg  [$clog2(DELAY)-1:0] sCtnFE = '0;
  reg                      sSig;

  always_ff@(posedge iClk) sSig <= iSig;

  wire sSigRE = ~sSig &  iSig;
  wire sSigFE =  sSig & ~iSig;

  wire sCtnREen = (sCtnRE != 0 || sSigRE == 1'b1) ? 1'b1 : 1'b0;
  wire sCtnFEen = (sCtnFE != 0 || sSigFE == 1'b1) ? 1'b1 : 1'b0;
  
  always_ff@(posedge iClk) begin
    if (sSigRE) sCtnRE <= DELAY - 1; else if (sCtnREen) sCtnRE <= sCtnRE - 1'b1;
    if (sSigFE) sCtnFE <= DELAY - 1; else if (sCtnFEen) sCtnFE <= sCtnFE - 1'b1;
  end

  // DELAY = 6, iSig RE\FE period > DELAY
  
  // iSig      ___---________
  // sCtnFEen  ______------__
  // sCtnREen  ___------_____
  // oSig      _________---__
  
  // iSig      ---__---------
  // sCtnFEen  ___------_____
  // sCtnREen  _____------___
  // oSig      ---------__---

  // iSig      ---___________
  // sCtnFEen  ___------_____
  // sCtnREen  ______________
  // oSig      ---------_____

  // iSig      ___-----------
  // sCtnFEen  ______________
  // sCtnREen  ___------_____
  // oSig      _________-----

  assign oSig = ( sCtnFEen && !sCtnREen) ? 1'b1 :
                (!sCtnFEen &&  sCtnREen) ? 1'b0 : iSig;
endmodule
