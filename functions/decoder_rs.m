
%  Author:    Muah Kim
%  Created:   01.Apr.2021
%  Lastly Updated:  01.Apr.2021

function [RecStream] = decoder_rs(NoisyOutStream, m, k)
    % m: Number of bits per symbol 
    % k: Number of symbols in a message, Message length
    n = 2^m-1; % Block length
    N_cw = fix(length(NoisyOutStream)/n); % Number of messages
    NoisyOutStream_gf = gf(NoisyOutStream(1:N_cw*n),m); 
    
    if ( rem(length(NoisyOutStream),n) ~= 0) 
        %fprintf('The channel output stream is trimmed because its length is not a multiple of the block length. Block length: %d, Length of output stream: %d, Length of output stream after being trimmed: %d.', n, numel(NoisyOutStream), numel(NoisyOutStream_trim));
        error('The channel output stream is not a multiple of the block length.');

    end    
    for i=1:numel(NoisyOutStream_gf)
        if ~ismember(NoisyOutStream_gf(i), 0:n)
            error('%d-th codeword symbol is invalid: %d. Codeword symbols must be non-negative integers smaller than or equal to %d.', i, NoisyOutStream(i), n)
        end
    end
    
    NoisyOutStream_Sq = transpose(reshape(NoisyOutStream_gf,n, N_cw)); % Each row represents a noisy codeword. 
    [rxcode,cnumerr] = rsdec(NoisyOutStream_Sq,n,k); %rsdec() is based on the Berlekamp-Massey decoding algorithm. Each row of rxcode represents the recovered message of a codeword in the same row of NoisyOutStream_Sq.
    RecStream = gf2dec(reshape(rxcode, 1, []), m, primpoly(m)); 
    
end