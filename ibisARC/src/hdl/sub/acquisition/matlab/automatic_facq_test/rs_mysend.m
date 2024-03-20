
function [Status, result] = rs_mysend( InstrObj, strCommand, output )
    
    Status = 0;

    % check number of arguments
    if (nargin ~= 3)
        disp ('*** Wrong number of input arguments to rs_batch_interpret().')
        return;
    end

    % check first argument to be an object
    if (isobject(InstrObj) ~= 1)
        disp ('*** The first parameter is not an object.');
        return;
    end
    if (isvalid(InstrObj) ~= 1)
        disp ('*** The first parameter is not a valid object.');
        return;
    end

    % check command to be a string
    if( isempty(strCommand) || (ischar(strCommand)~= 1) )
        disp ('*** Command string is empty or not a string.');
        return;
    end
    
        % query
        if ~(isempty(strfind(strCommand, '?')))
            [stat, res] = rs_send_query (InstrObj, strCommand);
            if (stat < 1)
                disp (['*** Failure processing : ' strCommand]);
            end
            result = res;
            if (output == 1)
                disp (['<<< ' strCommand]);
                disp (['--> ' res]);
            end
            Status = stat;
            if( ~Status )
                disp ('*** SCPI command processig failed' );
                clear;
                return;
            end
        return;    
        end
        
        % command
        if (output == 1)
            disp (['<<< ' strCommand]);
        end
        [stat] = rs_send_command (InstrObj, strCommand);
        if (stat < 1)
            disp (['*** Failure processing : ' strCommand]);
        end
       
            Status = stat;
            if( ~Status )
                disp ('*** SCPI command processig failed' );
                clear;
                return;
            end
%     fclose(fid);
    
% Status = 1;

return;

