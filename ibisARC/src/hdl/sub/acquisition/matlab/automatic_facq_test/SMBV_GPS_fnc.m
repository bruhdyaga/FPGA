function done = SMBV_GPS_fnc(ID,NS,SV_ID,Data,output)
%% Скрипт для настройки SMBV на выдачу сигналов GPS.
done = 0;

%% Setting GPS
rs_mysend( ID, 'SOUR:BB:GPS:PRES', output);
rs_mysend( ID, '*OPC?', output);
rs_mysend( ID, 'SOUR:BB:GPS:SMODE STATIC', output);    % Необязательная
rs_mysend( ID, 'SOUR:BB:GPS:RFB L1', output);          % Необязательная, RF band L1/L2
rs_mysend( ID, 'SOUR:BB:GPS:SEQ AUTO', output);       % Необязательная, TRIGGER mode
rs_mysend( ID, sprintf('SOUR:BB:GPS:NAVigation:DATA %s',Data), output);   %ZERO|ONE|PATTern|PN9|PN11|PN15|PN16|PN20|PN21|PN23|DLISt|RNData

rs_mysend( ID, sprintf('SOUR:BB:GPS:SAT:COUNT %d',NS), output);
rs_mysend( ID, '*OPC?', output);

for i = 1:NS
    rs_mysend( ID,sprintf('SOUR:BB:GPS:SAT%d:STAT ON',i), output);
    if (~isempty(SV_ID)) && (length(SV_ID) == NS) 
    rs_mysend(ID, sprintf('SOUR:BB:GPS:SAT%d:SVID %d', i, SV_ID(i)), output);
    end
    rs_mysend( ID, '*OPC?', output);
end

    rs_mysend( ID, '*OPC?', output);

if ~((~isempty(SV_ID)) && (length(SV_ID) == NS)) && (~isempty(strfind(Data,'RND')))
rs_mysend( ID, 'SOUR:BB:GPS:GOC', output);
end
% rs_mysend( InstrObject, 'SOUR:AWGN:STAT OFF', output);

%% Включение GNSS
rs_mysend( ID, 'SOUR:BB:GPS:STAT ON', output);
rs_mysend( ID, '*WAI', output);
rs_mysend( ID, '*OPC?', output);
 

done = 1;
end

