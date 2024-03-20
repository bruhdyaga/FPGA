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


h = figure(fignum);
set(h, 'units','normalized','outerposition',[0 0 1 1]);

M = 2; N = 2; 
if ~exist('ax', 'var')
    ax = nan(1, M*N);
    for jn = 1:N*M
        ax(jn) = subplot(M, N, jn);
    end
end

if D.size > 0
    jn = 1;
    x = D.clk;
    tmin = min(D.clk);
    tmax = max(D.clk);

    subplot(M, N, jn); jn = jn + 1;
    plot(x, D.awgn1);
    ylabel('awgn_1');
    xlabel('clks');
    xlim([tmin tmax]);

    subplot(M, N, jn); jn = jn + 1;
    plot(x, D.awgn2);
    ylabel('awgn_2');
    xlabel('clks');
    xlim([tmin tmax]);
    
    subplot(M, N, jn); jn = jn + 1;
    plot(xcorr(D.awgn1, D.awgn2));
    ylabel('xcorr 1 2');
    
    subplot(M, N, jn); jn = jn + 1;
    plot(xcorr(D.awgn1, D.awgn1));
    ylabel('xcorr 1 1');    
end