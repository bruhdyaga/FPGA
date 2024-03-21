function out = SMBV_RESET(IP)


%% 1
[status, SMBV] = rs_connect('tcpip', IP);
if(status == 1)
    %     disp('Connection     : Success');
else
    disp('Connection to SMBV : FAILURE');
    out = -1;
    return
end

% rs_mysend(SMBV, '*IDN?', 0);
% rs_mysend(SMBV, 'OUTP 0', 0);
rs_mysend(SMBV, '*RST; *CLS', 0);
% rs_mysend(SMBV, '*OPC?', 0);
rs_mysend(SMBV, '*OPC', 0);


ESRvalue = 0;
while (bitand(ESRvalue,1)) == 0
    ESRvalue = rs_send_query (SMBV, '*ESR?')
    pause(0.1)
end

%%
% [stat, res] = rs_mysend(SMBV, 'SYST:SERR?', 0);
% if ~strcmp(res, sprintf('0,"No error"\n'))
%     errordlg(res);
%     return;
% end
% 
% rs_wait_busy(IP)

out = 0;

end