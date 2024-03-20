clc
clear
close all hidden
rng default
M = 2;                 % Modulation order
k = log2(M);            % Bits per symbol
EbNoVec = (7)';       % Eb/No values (dB)
numSymPerFrame = 500;   % Number of QAM symbols per frame

berEstHard = zeros(size(EbNoVec));
berEstHardMy = zeros(size(EbNoVec));

trellis = poly2trellis(7,[171 133]);
tbl = 32;
rate = 1/2;

for n = 1:length(EbNoVec)
    fprintf('n=%d\n',n)
    % Convert Eb/No to SNR
    snrdB = EbNoVec(n) + 10*log10(k*rate);
    % Reset the error and bit counters
    [numErrsHard,numErrsHardMy,numBits] = deal(0);

    while numErrsHard < 50 && numBits < 1e6
        % Generate binary data and convert to symbols
        dataIn = randi([0 1],numSymPerFrame*k,1);

        % Convolutionally encode the data
        dataEnc = convenc(dataIn,trellis);

        % QAM modulate
        txSig = qammod(dataEnc,M,'InputType','bit');

        % Pass through AWGN channel
        rxSig = awgn(txSig,snrdB,'measured');

        % Demodulate the noisy signal using hard decision (bit) and
        % approximate LLR approaches
        rxDataHard = qamdemod(rxSig,M,'OutputType','bit');

        % Viterbi decode the demodulated data
        dataHard = vitdec(rxDataHard,trellis,tbl,'cont','hard');
        dataHardMy = vitdec_my(rxDataHard',0)';

        % Calculate the number of bit errors in the frame. Adjust for the
        % decoding delay, which is equal to the traceback depth.
        numErrsInFrameHard = biterr(dataIn(1:end-tbl),dataHard(tbl+1:end));
        numErrsInFrameHardMy = biterr(dataIn(1:end-tbl),dataHardMy(1:end-tbl));

        % Increment the error and bit counters
        numErrsHard = numErrsHard + numErrsInFrameHard;
        numErrsHardMy = numErrsHardMy + numErrsInFrameHardMy;
        numBits = numBits + numSymPerFrame*k;

    end

    % Estimate the BER for both methods
    berEstHard(n) = numErrsHard/numBits;
    berEstHardMy(n) = numErrsHardMy/numBits;
end


fprintf('berEstHardMy = %.3e\n',berEstHardMy)
return

semilogy(EbNoVec,[berEstHardMy berEstHard],'-*')
hold on
semilogy(EbNoVec,berawgn(EbNoVec,'psk',M,'nondiff'))
legend('Custom','Hard','Uncoded','location','best')
grid
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate SBAS 500/bitSec')