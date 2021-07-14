
%  Author:    Muah Kim
%  Created:   12.May.2021
%  Lastly Updated:  14.July.2021

% Modulation Parameters
modulation_order = 2^2; 
block_length = 128;
num_subcarrier = 140; % num_subcarrier >= block_length. The difference between them helps to fight ISI.
num_cp = 10; % Number of cyclic prefix 
num_blocks = 100;  

% Channel Parameters 
n_taps = 1; % number of channel taps.
SNR_dB = 10;
noise_pwr = 1;
signal_pwr = 10.^(SNR_dB/10)*noise_pwr*log2(modulation_order); % Signal power
%rolloff = 0.25; % Rolloff factor

% Initialization of Variables
BE = 0; % Bit errors
SE = 0; % Symbol errors

% Channel Encoder 
bits_encoded = randi([0 1],1, num_blocks*block_length*log2(modulation_order)); % This randomly generated bit source should be substituted by a encoded bits.

% Bit-2-Sym Mapping
sym_num = bit2symnum(bits_encoded, modulation_order);
sym_encoded = sqrt(signal_pwr) * bit2sym(modulation_order,sym_num); 

for i = 1:num_blocks
    % Tx Modulation and Adding CP
    sym_block = [sym_encoded((i-1)*block_length+1:i*block_length) complex(zeros(1,num_subcarrier-block_length))]; % S/P
    signal_tx = ifft(sym_block, num_subcarrier);
    signal_tx_w_cp = [signal_tx(end-num_cp+1:end) signal_tx]; %adding CP    
    
    % Fading channel with exponential attenuation
    h = exp(-(0:n_taps-1));
    h = h/norm(h);
    signal_fading = conv(signal_tx_w_cp,h,'same');

    % Additive Gaussian noise
    noise = sqrt(noise_pwr/2)*(randn(size(signal_fading))+1i*randn(size(signal_fading)));
    sinal_fading_awgn = signal_fading + noise;

    % Rx Removing CP and Demodulation
    signal_rx_w_cp = sinal_fading_awgn; % detected signal
    signal_rx = signal_rx_w_cp(:,num_cp+1:end); % remove CP
    sym_wo_eq_block = fft(signal_rx, num_subcarrier);%num_subcarrier); 
    
    % Channel equalization
    H = fft(h,num_subcarrier);
    sym_eq_block = sym_wo_eq_block./H;
    sym_eq_block = sym_eq_block(1:block_length);
    
    sym_num_block_rec = min_distance_detection(sym_eq_block,modulation_order,signal_pwr);
    bits_rec = sym2bit(sym_num_block_rec-1,modulation_order)';    
    
    SE = SE + sum(sym_num((i-1)*block_length+1:i*block_length)~=(sym_num_block_rec-1)');
    BE = BE + sum(bits_encoded((i-1)*block_length*log2(modulation_order)+1:i*block_length*log2(modulation_order))~=bits_rec); % should be converted to binary (demodulated) and then compared. 
end

SER = SE/length(sym_encoded);
BER = BE/length(bits_encoded);
    