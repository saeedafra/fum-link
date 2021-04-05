
%  Author:    Muah Kim
%  Created:   01.Apr.2021
%  Lastly Updated:  01.Apr.2021

function [OutStream, n] = encoder_rs(InStream, m, k) 
    % m: Number of bits per symbol 
    % k: Number of symbols in a message, Message length
    
    n = 2^m - 1; % Codeword length 
    N_msg = fix(length(InStream)/k); % Number of messages
    if (rem(length(InStream),k) ~= 0)
        InStream_trim = InStream(1:N_msg*k);
        fprintf('The input stream is trimmed because its length is not a multiple of the message length.\n Message length: %d, Length of input stream: %d, Length of input stream after being trimmed: %d.', k, numel(InStream), numel(InStream_trim));
    else
        InStream_trim = InStream;
    end
    
    for i=1:numel(InStream_trim)
        if ~ismember(InStream_trim(i), 0:n)
            error('%d-th message symbol is invalid: %d. Message symbols must be non-negative integers smaller than or equal to %d.', i, InStream(i), n)
        end
    end
    
    if ~ismember(k, 1:n)
        error('Message length k must be smaller than or equal to the block length, 2^m-1.')
    end
    
    InStream_Sq = transpose(reshape(InStream_trim, N_msg,k)); % Input stream in a square shape. Each row corresponds to a message. 

    msg = transpose(gf(InStream_Sq,m));
    OutStream_Sq = rsenc(msg, n, k); % Each row represents a codeword of a message in the same row of InStream_sq.
    OutStream = gf2dec(reshape(transpose(OutStream_Sq), 1, []),m,primpoly(m));

end