function done = SMBV_GLN_fnc(ID,NS,SV_ID,Data,L,output)

done = 0;

%% Setting GLONASS
rs_mysend( ID, 'SOUR:BB:GLONASS:PRES', output);
rs_mysend( ID, '*OPC?', output);
rs_mysend( ID, 'SOUR:BB:GLONASS:SMODE STATIC', output);    % 
rs_mysend( ID, sprintf('SOUR:BB:GLONASS:RFB %s', L), output);          % RF band L1/L2
rs_mysend( ID, 'SOUR:BB:GLONASS:SEQ AUTO', output);        % TRIGGER mode

% Navigation DATA
rs_mysend( ID, sprintf('SOUR:BB:GLONASS:NAVigation:DATA %s',Data), output);   %ZERO|ONE|PATTern|PN9|PN11|PN15|PN16|PN20|PN21|PN23|DLISt|RNData
rs_mysend( ID, sprintf('SOUR:BB:GLONASS:SAT:COUNT %d',NS), output);
rs_mysend( ID, '*OPC?', output);

for i = 1:NS
%     if (strcmp(Data,'RND'))    % ��� RNData ������ �������� �������������.
        rs_mysend( ID,sprintf('SOUR:BB:GLONASS:SAT%d:STAT ON',i), output);
        if (~isempty(SV_ID)) && (length(SV_ID) == NS) 
        rs_mysend(ID, sprintf('SOUR:BB:GLON:SAT%d:SVID %d', i, SV_ID(i)), output);
        end
%     else
%         rs_mysend( ID,sprintf('SOUR:BB:GLONASS:SAT%d:FNUMber %d',i,SV_ID(i)), output);
%     end
    
    rs_mysend( ID, '*OPC?', output);
end

% if ~(strcmp(Data,'RNData'))
if ~((~isempty(SV_ID)) && (length(SV_ID) == NS)) && (~isempty(strfind(Data,'RND')))
rs_mysend( ID, 'SOUR:BB:GLONASS:GOC', output);
end

% Turn ON
rs_mysend( ID, 'SOUR:BB:GLONASS:STAT ON', output);
rs_mysend( ID, '*WAI', output);
rs_mysend( ID, '*OPC?', output);



done = 1;
end


