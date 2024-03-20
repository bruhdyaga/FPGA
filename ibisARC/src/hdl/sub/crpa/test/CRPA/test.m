% function [test_result] = test(varargin)
clear; varargin = {};
addpath('../Sub');
%     
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);
par = {'NCH', 2, 'NT', 8};
%     -
DefParams = {'NCH',               4;
             'NT',                3;
             'NBF',               2;
             'input_width',      14;
             'NF_coeff_width',   14;
             'BF_coeff_width',    4;
             'Nstat'           1024;
             'CVM_sel'            1;
             
%   
             'fd'            125e6;         %  
             'fi'          125e6/4;         %   
             'T'            0.2e-3;         %   
             'q'        10^(40/10);         %       
             'JS'       10^(80/10);         %      
            };
parse_params
params_file = [TMP 'test_params.m'];
%     NullFormer
NF_out_full_width = input_width + NF_coeff_width + ceil(log2(NCH)) + ceil(log2(NT));
%  ,    NullFormer
NF_lsb_drop = NF_out_full_width - input_width;  % ,     input_width 
% % ========    ========
Td = 1/fd;              %  
Nd = fix(T/Td);          %  
% ========    ========
phi = 2*pi*rand(NCH, 1);   %   
H = exp(1i*phi);          %    
%  
[str, ref_list] = GenerateFilterStruct(params_file);
%   
s = GenerateSignal(params_file);
s = real(s);
%     
for i=1:NCH
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end
% ========    Matlab ========
% ====   NullFormer ====
Knf = 2^(NF_coeff_width-1);          %   
%   
MACC_drop = 2*input_width + 10 - 32; 
if MACC_drop < 0
    MACC_drop = 0;
end
[R RT] = GenerateMatrix(s, str, params_file);
delays = 0:10;
le_delays = length(delays);
Rmd = cell(le_delays, 1);
for i = 1:le_delays
    y = s(:, (1:(Nstat + NT - 1)) + delays(i))';
    Rmd{i} = y2cvm(y, NT, CVM_sel);
    Rmd{i} = floor(Rmd{i}/2^(MACC_drop));
end
if (NT == 1 || NT == 2)
    Rm = Rmd{7};
else
    Rm = Rmd{6};
end
%    
NF_coeff = GenerateNFcoeff(R, str, ref_list, params_file);
%  
NF_coeff = quant(NF_coeff*Knf, NF_coeff_width);
NF_A = Knf-1;                     %    Matlab   filter(NF_coeff, A, out_nf)
% ===   BeamFormer ===
Kbf = 2^(BF_coeff_width-1);    %   
BF_coeff = H';                 %         
BF_coeff = quant(BF_coeff*Kbf, BF_coeff_width);    %   
%   NullFormer  
for i=1:NCH
    fid = fopen(sprintf('%sNF_coeffs_%d.txt', TMP, i), 'w');
    fprintf(fid, '%d\n', NF_coeff(:, :, i)');
    fclose(fid);
end
%   BeamFormer  
for i=1:NBF
    fid = fopen(sprintf('%sBF_RE_coeffs_%d.txt', TMP, i), 'w');
    fprintf(fid, '%d\n', real(BF_coeff));
    fclose(fid);
    fid = fopen(sprintf('%sBF_IM_coeffs_%d.txt', TMP, i), 'w');
    fprintf(fid, '%d\n', imag(BF_coeff));
    fclose(fid);
end
% =======   Matlab =======
% ==== NullFormer ====
out_nf = zeros(NCH, Nd);
for ch=1:NCH
    for i=1:NCH
        out_nf(ch, :) = out_nf(ch, :) + filter(NF_coeff(i, 1:NT, ch), NF_A, s(i, :)); 
    end
end
out_nf = round(out_nf*(Knf-1));  %    2^(NF_coeff_width-1)-1 -   
% === NF LSB drop ====
out_nf_drop = floor(out_nf/2^NF_lsb_drop);
% ==== BeamFormer ====
out_bf = zeros(NBF, Nd);
for ch=1:NBF
    out_bf(ch, :) = BF_coeff * out_nf_drop;
end
% ========    Verilog =========
% ====    Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       %    
fprintf(fid_param, '`define TMPPATH "%s/tmp"\n', pwd);
fprintf(fid_param, '`define CRPA_NCH %d\n', NCH);
fprintf(fid_param, '`define CRPA_NT %d\n', NT);
fprintf(fid_param, '`define CRPA_NBF %d\n', NBF);
fprintf(fid_param, '`define CRPA_INPUT_WIDTH %d\n', input_width);
fprintf(fid_param, '`define CRPA_NF_COEFF_WIDTH %d\n', NF_coeff_width);
fprintf(fid_param, '`define CRPA_BF_COEFF_WIDTH %d\n', BF_coeff_width);
fprintf(fid_param, '`define CRPA_NF_LSB_DROP %d\n', NF_lsb_drop);
fprintf(fid_param, '`define CRPA_CVM_SEL %d\n', CVM_sel);
fprintf(fid_param, '`define CRPA_CVM_NSTAT %d\n', Nstat);
fclose(fid_param);
fid = fopen('tmp/run.tcl', 'w');                     %    
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);
%break
% ====   modelsim ====
system('make batch');
% ========   ========
% ====  NullFormer ====
rtl_nf_out = [];
for i=1:NCH
    rtl_nf_out = [rtl_nf_out; textread(sprintf('tmp/out_nf_%d.txt', i), '%n')'];
end
% ====  BeamFormer ====
rtl_bf_RE_out = [];
for i=1:NBF
    rtl_bf_RE_out = [rtl_bf_RE_out; textread(sprintf('tmp/out_bf_RE_%d.txt', i), '%n')'];
end
rtl_bf_IM_out = [];
for i=1:NBF
    rtl_bf_IM_out = [rtl_bf_IM_out; textread(sprintf('tmp/out_bf_IM_%d.txt', i), '%n')'];
end
% ====  cov_matrix ====
cvm_out  = textread(sprintf('%sout_cvm.txt', TMP), '%n')';
% ========      =========
res = zeros(1, NCH);
figure(1);
fprintf('NullFormer test:\n');
for i=1:NCH
    res(i) = compare(out_nf(i, :), rtl_nf_out(i, :), Td);
    drawnow
end
res2 = zeros(1, 2*NBF);
figure(2);
fprintf('BeamFormer test:\n');
for i=1:NBF
    res2(2*i-1) = compare(real(out_bf(i, :)), rtl_bf_RE_out(i, :), Td);
    res2(2*i  ) = compare(imag(out_bf(i, :)), rtl_bf_IM_out(i, :), Td);
    drawnow
end
figure(3);
fprintf('cov_matrix test:\n');
Rv = maccs2cvm(cvm_out, NCH, NT, CVM_sel);
Ns = 1; Ms = 2; ks = 0;
ks = ks + 1; ha = subplot(Ns, Ms, ks);
plot_matrix(ha, Rv);
% title({'Verilog:', ['Matrix ' num2str(NABr) 'x' num2str(NT) ': ' num2str(NMv) ' multipliers']});
title({'Verilog'});
ks = ks + 1; ha = subplot(Ns, Ms, ks);
plot_matrix(ha, Rm);
% title({'Matlab:', ['Matrix ' num2str(NABr) 'x' num2str(NT) ': ' num2str(NMm) ' multipliers']});
title({'Matlab'});
% res3 = compare(RT, cvm_out, Td);
silent = 0;
if (norm(Rm - Rv) == 0)
    res3 = 1;
    if ~silent
        fprintf('OK\n');
    end
else
    res3 = 0;
    if ~silent
        fprintf('Fail\n');
    end
end
figure(4);
%    
N = length(s);
f = fd/2*((0:N-1)-N/2)/(N/2);
K = (Knf-1);
plot(f/1e6, 20*log10(abs(fftshift(fft(K * s(1, :))))), 'b')
grid on
hold on
ind = find(isnan(out_nf(1, :))); out_nf(ind) = zeros(size(ind));
N = length(out_nf);
f = fd/2*((0:N-1)-N/2)/(N/2);
plot(f/1e6, 20*log10(abs(fftshift(fft(out_nf(1, :))))), 'r')
hold off
ylim([100 200]);
if (sum(res) == NCH) && (sum(res2) == NBF*2) && (res3 == 1)
    test_result = 1;
else
    test_result = 0;
end