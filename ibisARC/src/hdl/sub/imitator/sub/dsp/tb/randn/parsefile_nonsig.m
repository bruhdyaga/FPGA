%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Copyright  2015  SRNS.RU Team                                              %%%
%%%      _______. .______     .__   __.      ___ ____.    .______      __    __  %%%
%%%     /       | |   _  \    |  \ |  |     /       |     |   _  \    |  |  |  | %%%
%%%    |   (----` |  |_)  |   |   \|  |    |   (----`     |  |_)  |   |  |  |  | %%%
%%%     \   \     |      /    |  . `  |     \   \         |      /    |  |  |  | %%%
%%% .----)   |    |  |\  \--. |  |\   | .----)   |    __  |  |\  \--. |  `--'  | %%%
%%% |_______/     | _| `.___| |__| \__| |_______/    (__) | _| `.___|  \______/  %%%
%%%                                                                              %%%
%%%   Boldenkov E., Korogodin I.                                                 %%%
%%%                                                                              %%%
%%%   Licensed under the Apache License, Version 2.0 (the "License");            %%%
%%%   you may not use this file except in compliance with the License.           %%%
%%%   You may obtain a copy of the License at                                    %%%
%%%                                                                              %%%
%%%       http://www.apache.org/licenses/LICENSE-2.0                             %%%
%%%                                                                              %%%
%%%   Unless required by applicable law or agreed to in writing, software        %%%
%%%   distributed under the License is distributed on an "AS IS" BASIS,          %%%
%%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   %%%
%%%   See the License for the specific language governing permissions and        %%%
%%%   limitations under the License.                                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nfields = size(fields, 2);
cyc_out = 0;
% Create empty structs tree
for j = 1:Nfields
    D.(fields{j}) = [];
end
D.size = 0;
D.fields = fields;
D0 = D;

f = dir(filename); prev_bytes = f.bytes;
fid = fopen(filename, 'r');
while (1)
            
    f=dir(filename);
    if (f.bytes < prev_bytes)
            prev_bytes = f.bytes;
            fclose(fid);
            fid = fopen(filename, 'r');
            D = D0;
    end
    
    % Read data from file
    MaxRows = 10000;
    for j = 1:MaxRows
        position = ftell(fid);
        [data, scount] = fscanf(fid, '%g', [Nfields 1]);
        if ~feof(fid);
            if length(data) == length(D.fields)
                D.size = D.size + 1;
                for i = 1:Nfields
                    D.(D.fields{i})(D.size) = data(i, 1);
                end
            else 
                stat = fseek(fid, position, 'bof');
            end
        else
            if nocycle
                cyc_out = 1;
                break;
            end
            stat = fseek(fid, position, 'bof');
            if stat < 0
                fprintf('I cann''t do fseek\n');
            end
            break;
        end
    end

    eval(plotcmd);

    if cyc_out
        break
    else
        pause(0.1);
    end
end

fclose(fid);