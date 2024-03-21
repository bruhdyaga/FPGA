clear; close all;

% filename = '../../prj_dsp/dsp.sim/sim_randn/behav/res.txt';
filename = 'res.txt';

fields          =   { 'clk', ...
                    'awgn1', ...
                    'awgn2'
                    };
                
fignum = 1;
nocycle = 1;

timefmt = 'M0';

plotcmd = 'plot_randn_stat';
parsefile_nonsig;