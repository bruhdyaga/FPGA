function rs_wait_busy(IP)


[status, SMBV] = rs_connect('tcpip', IP);
if(status == 1)
    %     disp('Connection     : Success');
else
    disp('Connection to SMBV : FAILURE');
end

rs_send_command (SMBV, '*CLS');
rs_send_command (SMBV, '*OPC');
ESRvalue = 0;
while (bitand(ESRvalue,1)) == 0
    ESRvalue = rs_send_query (SMBV, '*ESR?')
    pause(0.1)
end

end