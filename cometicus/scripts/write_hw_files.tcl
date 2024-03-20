set fileName      "cometicus"
set rootPath      "../.."

puts "INFO: Current directory: [pwd]"
# # # puts "INFO: Update XSA platform"
  # # # write_hw_platform -fixed -force -file ${rootPath}/xsa/${fileName}.xsa

puts "INFO: Copy .bit, .ltx files"
  # save previous .bit file
  if {  ([file exists                  "${fileName}.bit"] == 1)   \
     && ([file exists  "${rootPath}/bin/${fileName}.bit"] == 1) } \
  {file copy -force    "${rootPath}/bin/${fileName}.bit" "${rootPath}/bin/${fileName}_prev.bit";}
  # copy .bit file
  if { [file exists      "${fileName}.bit"] != 1 } {puts "WARNING: [pwd]/${fileName}.bit not exist!";} \
  else {file copy -force "${fileName}.bit" "${rootPath}/bin/${fileName}.bit";}
  
  # copy new bin file
  # if { [file exists "${fileName}.bit"] == 1 } {file copy -force "${fileName}.bit" "${rootPath}/../../bin/cometicus.bit";}

  #
  # .ltx doesn't exist yet. So move .ltx copy to make.tcl
  #
  # # save previous
  # if { [file exists  "${fileName}.ltx"] == 1 } {file copy -force "${rootPath}/bin/${fileName}.ltx" "${rootPath}/bin/${fileName}_prev.ltx";}
  # # copy .ltx file
  # if { [file exists  "${fileName}.ltx"] != 1 } {puts "WARNING: [pwd]/${fileName}.ltx not exist!";} \
  # else {file copy -force "${fileName}.ltx" "${rootPath}/bin/${fileName}.ltx";}

# puts "INFO: Write .bin file"
  # if { [file exists  "${fileName}.bit"] == 1 } \
  # {write_cfgmem  -format bin -size 16 -interface SPIx4 -loadbit "up 0x00000000 ${rootPath}/bin/${fileName}.bit" -checksum -force -file "${rootPath}/bin/${fileName}.bin" }
