%%


function done = setupSMBV_all(IP, IPN, Testbed, SigType, Freq, Sat_NUM, SV_ID, data, q_cn0, ChangeSNRonly)
global output mode QAM
done = 0;

q_cn0 = q_cn0-5.5; % моя коррекция на 5дБ

No = -204;                  % No = 10*log10(300*1.38*10e-23);
NF = 1 + 10;                % 10 dB correction (-157 - qcno)
L_cable = 2 + 2 + 2;

Ncor = 0.5;
JS_Level = -60;
CNR = 0;

NavData = data;     % 'ZERO|ONE|PN9|PN11|PN15|PN16|PN20|PN21|PN23|RNData'
NS = Sat_NUM;
if ( (NS~=0) && (NS~=1) && (NS~=4) && (NS~=5) && (NS~=6) )  % SMBV пїЅпїЅпїЅпїЅпїЅ 1,4,5,6 пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ
    NS = 1;
end

%% Connect via TCP/IP
[status, SMBV] = rs_connect('tcpip', IP);
if(status == 1)
    %     disp('Connection     : Success');
else
    disp('Connection     : FAILURE');
end

%% Connect via TCP/IP 2
if (mode)
    [status, SMBV_N] = rs_connect('tcpip', IPN);
    if(status == 1)
        %     disp('Connection     : Success');
    else
        disp('Connection     : FAILURE');
    end
end


%% Setting signals
if (ChangeSNRonly == 0)
    
    rs_mysend(SMBV, '*IDN?', output);
    rs_mysend(SMBV, 'OUTP 0', output);
    rs_mysend(SMBV, '*RST; *CLS', output);
    rs_mysend(SMBV, '*OPC?', output);
    
    if (mode)
        rs_mysend(SMBV_N, '*IDN?', output);
        rs_mysend(SMBV_N, 'OUTP 0', output);
        rs_mysend(SMBV_N, '*RST; *CLS', output);
        rs_mysend(SMBV_N, '*OPC?', output);
    end
    
    %%
    [stat, res] = rs_mysend(SMBV, 'SYST:SERR?', 0);
    if ~strcmp(res, sprintf('0,"No error"\n'))
        errordlg(res);
        return;
    end
    
    if (mode)
        [stat, res] = rs_mysend(SMBV_N, 'SYST:SERR?', 0);
        if ~strcmp(res, sprintf('0,"No error"\n'))
            errordlg(res);
            return;
        end
    end
    
    if (strfind(SigType,'GlnL1') > 0)
        L = 'L1';
    elseif (strfind(SigType,'GlnL2') > 0)
        L = 'L2';
    end
    
    switch SigType
        case 'GpsL1CA'
            if (QAM)
                done = SMBV_CDM_fnc(SMBV,SigType,output);
            else
                done = SMBV_GPS_fnc(SMBV,NS,SV_ID,NavData,output);
            end
            dF = 2*1.023e6;
            NBW = dF / 1e6;
        
        case 'GpsL2C'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 2*0.5115e6;
            NBW = dF / 1e6;
            
        case 'GlnL1OF'
            %             done = SMBV_CDM_fnc(SMBV,SigType,output);
            done = SMBV_GLN_fnc(SMBV,NS,SV_ID,NavData,L,output);
            dF = 1*1.023e6;
            NBW = dF / 1e6;
            
        case 'GlnL2OF'
            done = SMBV_GLN_fnc(SMBV,NS,SV_ID,NavData,L,output);
            dF = 1*1.023e6;
            NBW = dF / 1e6;
            
        case 'GlnL1SF'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 2*5.11e6;
            NBW = dF / 1e6;
            
        case 'GlnL2SF'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 2*5.11e6;
            NBW = dF / 1e6;
            
        case 'GlnL1OCd'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 2*1.023e6;
            NBW = dF / 1e6;
        case 'GlnL1OCp'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 4*1.023e6;
            NBW = dF / 1e6;
            
        case 'GlnL1SCd'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 1 * 2*(5+2.5)*1.023e6;
            NBW = dF / 1e6;
        case 'GlnL1SCp'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 1 * 2*(5+2.5)*1.023e6;
            NBW = dF / 1e6;
            
        case 'GlnL3OC'
            done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
            dF = 2*10.230e6;
            NBW = dF / 1e6;
            
%         case 'BOC_5_25_2ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 1 * 2*(5+2.5)*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BOC_5_25_10ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 1 * 2*(5+2.5)*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BOC_5_25_100ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 1 * 2*(5+2.5)*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BOC_5_25_1s'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 1 * 2*(5+2.5)*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BPSK_5_25_2ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 2*2.5*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BPSK_5_25_10ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 2*2.5*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BPSK_5_25_100ms'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 2*2.5*1.023e6;
%             NBW = dF / 1e6;
%             
%         case 'BPSK_5_25_1s'
%             done = SMBV_CDM_fnc(SMBV,SigType,output, SV_ID);
%             dF = 2*2.5*1.023e6;
%             NBW = dF / 1e6;
            
    end
    
    %% TESTBED settings
    if (strcmp(Testbed,'MCR'))
        %% J/S AWGN setup (for mode = 1)
        if (mode)
            
            rs_mysend( SMBV_N, sprintf('FREQ %.f',Freq), output);
            rs_mysend( SMBV_N, 'SOUR:AWGN:MODE ONLY', output);
            rs_mysend( SMBV_N, sprintf('SOUR:AWGN:BWID %d MHz',NBW), output);
            rs_mysend( SMBV_N, 'SOURce:AWGN:POWer:RMODe NOISe', output);
            
            P_noise = JS_Level + q_cn0 + Ncor;
            
            rs_mysend( SMBV_N,sprintf('SOURce:AWGN:POWer:NOISe %g dBm',P_noise), output);
            rs_mysend( SMBV_N, 'SOURce:AWGN:BRATe 1e6', output);
            
            rs_mysend( SMBV_N, sprintf('SOURce:AWGN:CNRatio %g',CNR), output);
            rs_mysend( SMBV_N, 'SOUR:AWGN:STAT ON', output);
            rs_mysend( SMBV_N, '*OPC?', output);
            rs_mysend( SMBV_N, 'OUTP 1', output);
            
            rs_mysend( SMBV,sprintf('LEVEL %g dBm',JS_Level), output);
            rs_mysend( SMBV, sprintf('FREQ %.f',Freq), output);
            rs_mysend( SMBV, '*OPC?', output);
            rs_mysend( SMBV, 'OUTP 1', output);
        else
            
            rs_mysend( SMBV, 'SOUR:AWGN:STAT OFF', output);
            Level = No + NF + q_cn0 + L_cable + (10*log10(NS)) + 30;
            
            %             fprintf('Level = %.f\n',Level);
            
            if Level < -145
                Level = -145;
            end
            if Level > 0
                Level = 0;
            end
            
            %             disp('***** bug? *****');
            
            rs_mysend( SMBV, sprintf('LEVEL %.f dBm',Level), output);
            rs_mysend( SMBV, sprintf('FREQ %.f',Freq), output);
            rs_mysend( SMBV, '*OPC?', output);
            rs_mysend( SMBV, 'OUTP 1', output);
            
        end
    elseif (strcmp(Testbed,'Impala'))
        
        rs_mysend( SMBV, sprintf('FREQ %.f',Freq), output);
        rs_mysend( SMBV, 'SOUR:AWGN:MODE ADD', output);
        rs_mysend( SMBV, sprintf('SOUR:AWGN:BWID %d MHz', 20), output);
        rs_mysend( SMBV, 'SOURce:AWGN:POWer:RMODe NOISe', output);
        rs_mysend( SMBV, 'SOURce:AWGN:POWer:NOISe -10 dBm', output);
        rs_mysend( SMBV, 'SOURce:AWGN:BRATe 100e6', output);
        
        CNR = q_cn0 - 10*log10(20*1e6) + 10*log10(NS) + L_cable;
        
        if CNR < -50
            CNR = -50;
        end
        if CNR > 40
            CNR = 40;
        end
        
        rs_mysend( SMBV, sprintf('SOURce:AWGN:CNRatio %.f',CNR), output);
        rs_mysend( SMBV, 'SOUR:AWGN:STAT ON', output);
        rs_mysend( SMBV, '*OPC?', output);
        rs_mysend( SMBV, 'OUTP 1', output);
        
    end
    
elseif (ChangeSNRonly == 1)
    
    rs_mysend( SMBV, sprintf('FREQ %.f',Freq), output);
    if (mode)
        rs_mysend( SMBV_N, sprintf('FREQ %.f',Freq), output);
    end
    
    if (strfind(SigType,'GpsL1CA'))
        rs_mysend( SMBV, sprintf('SOUR:BB:GPS:SAT:COUNT %d',NS), output);
        rs_mysend( SMBV, '*OPC?', output);
        
        for i = 1:NS
            rs_mysend( SMBV,sprintf('SOUR:BB:GPS:SAT%d:STAT ON',i), output);
            if (~isempty(SV_ID)) && (length(SV_ID) == NS)
                rs_mysend(SMBV, sprintf('SOUR:BB:GPS:SAT%d:SVID %d', i, SV_ID(i)), output);
            end
            rs_mysend( SMBV, '*OPC?', output);
        end
        
    elseif(strfind(SigType,'GlnL'))
        rs_mysend( SMBV, sprintf('SOUR:BB:GLONASS:SAT:COUNT %d',NS), output);
        rs_mysend( SMBV, '*OPC?', output);
        
        for i = 1:NS
            rs_mysend( SMBV,sprintf('SOUR:BB:GLONASS:SAT%d:STAT ON',i), output);
            if (~isempty(SV_ID)) && (length(SV_ID) == NS)
                rs_mysend(SMBV, sprintf('SOUR:BB:GLON:SAT%d:SVID %d', i, SV_ID(i)), output);
            end
            
            rs_mysend( SMBV, '*OPC?', output);
        end
    end
    
    
    if (strcmp(Testbed,'MCR'))
        if (mode)
            P_noise = JS_Level + q_cn0 + Ncor;
            rs_mysend( SMBV_N,sprintf('SOURce:AWGN:POWer:NOISe %g dBm',P_noise), output);
            
        else
            
            Level = No + NF + q_cn0 + L_cable + (10*log10(NS)) + 30;
            if Level < -145
                Level = -145;
            end
            if Level > 0
                Level = 0;
            end
            rs_mysend( SMBV,sprintf('LEVEL %g dBm',Level), output);
        end
        
    elseif (strcmp(Testbed,'Impala'))
        
        CNR = q_cn0 - 10*log10(20*1e6) + 10*log10(NS) + L_cable;
        if CNR < -50
            CNR = -50;
        end
        if CNR > 40
            CNR = 40;
        end
        
        rs_mysend( SMBV, sprintf('SOURce:AWGN:CNRatio %g',CNR), output);
        
    end
    
end

done = 1;
end