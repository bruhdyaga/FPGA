clc
clear
close all hidden

Nexp = 1e0;
Ndata = 256; % количество бит данных

trellis = poly2trellis(7,[171,133]);

f = waitbar(0,'progress');

err = 0;
err_old = 0;
err_matlab = 0;
for i = 1:Nexp
%     data = randi([0 1],Ndata,1);
    data = [1,zeros(1,31)]';
%     data = ones(1,10)';
%     data_rev = [1 0 1 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0];
%     data = fliplr(data_rev)';
    
    %     codedData = convenc(data,trellis);
    my_coded_data = vitcoder_my(data);
    
%         decodedData = vitdec(codedData,trellis,20,'trunc','hard');
    decodedDataMy = vitdec_single_my(my_coded_data,1);
    decodedDataMy_old = vitdec_my(my_coded_data,1);
    
    % fprintf('biterr = %f\n',biterr(data,decodedData))
    err = biterr(data,decodedDataMy') + err;
    err_old = biterr(data,decodedDataMy_old') + err_old;
    
    if(err ~= 0)
        break
    end
    
    %     err_matlab = biterr(data,decodedData) + err_matlab;
    waitbar(i/Nexp,f,'progress');
end

close(f)

fprintf('biterrMy = %f\n',err)
fprintf('biterrMy_old = %f\n',err_old)
% fprintf('biterr = %f\n',err_matlab)