
%  Author:    Muah Kim
%  Created:   01.Apr.2021
%  Lastly Updated:  06.Apr.2021

function [OutStream, n] = encoder_rs(InStream_bit, m, k) 
    % m: Number of bits per symbol 
    % k: Number of symbols in a message, Message length
    n = 2^m - 1; % Codeword length and symbol size 
    
    N_msg = fix(length(InStream_bit)/k/m); % Number of messages
    if (rem(length(InStream_bit),k*m) ~= 0)
        InStream_bit_trim = InStream_bit(1:N_msg*k*m);
        fprintf('The input stream is trimmed because its length is not a multiple of the message length.\n Message length: %d*%d=%d bits, Length of input stream: %d bits, Length of input stream after being trimmed: %d bits.', k,m, k*m, numel(InStream_bit), numel(InStream_bit_trim));
    else
        InStream_bit_trim = InStream_bit;
    end
    InStream_sym = bit2symnum(InStream_bit_trim, 2^m);
    
    for i=1:numel(InStream_sym)
        if ~ismember(InStream_sym(i), 0:n)
            error('%d-th message symbol is invalid: %d. Message symbols must be non-negative integers smaller than or equal to %d.', i, InStream_bit(i), n)
        end
    end
    
    if ~ismember(k, 1:n)
        error('Message length k must be smaller than or equal to the block length, 2^m-1.')
    end
    InStream_sym_Sq = transpose(reshape(InStream_sym, N_msg,k)); % Input stream in a square shape. Each row corresponds to a message. 

    msg = transpose(gf(InStream_sym_Sq,m));
    OutStream_sym_Sq = rsenc(msg, n, k); % Each row represents a codeword of a message in the same row of InStream_sq.
    OutStream_sym = gf2dec(reshape(transpose(OutStream_sym_Sq), 1, []),m,primpoly(m));
    OutStream = sym2bit(OutStream_sym, 2^m);
    
end