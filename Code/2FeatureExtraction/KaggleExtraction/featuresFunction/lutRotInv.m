function [lookup_table] = lutRotInv(FeatureName)
%
% function [lookup_table] = lutRotInv(FeatureName)
%
% Returns a look-up table to compute the rotation invariant versions LBP81,
% CCR81 and BGC81

switch FeatureName

    case 'LBP81ri'
        W = 8;   % Number of pixels of the LBP pattern
        N = 2^W; % Number of different patterns
        lookup_table = zeros(1,N);
        weights = 2.^(W-1:-1:0);
        for pattern = 0:N-1;
            bits  = fliplr(bitget(pattern, (1:W)));
            value = zeros(1, W);
            for i=0:W-1;
                rotated_bits = [bits(1+i:W), bits(1:i)];
                value(i+1)   = sum(rotated_bits.*weights);
            end;
            lookup_table(pattern+1) = min(value);
        end;
        bins = unique(lookup_table);
        for i=1:N;
            lookup_table(i) = find(bins==lookup_table(i))-1;
        end;
		
	case 'LBP81ri_new'
        W = 8;   % Number of pixels of the LBP pattern
        N = 2^W; % Number of different patterns
        lookup_table = zeros(1,N);
        weights = 2.^(W-1:-1:0);
        for pattern = 0:N-1;
            bits  = fliplr(bitget(pattern, (1:W)));
            value = zeros(0, 0);
			count = 1;
            for i=0:2:W-1;
                rotated_bits = circshift(bits, [0 -(i+2)]);
                value(count)   = sum(rotated_bits.*weights);
				count = count + 1;
            end;
            lookup_table(pattern+1) = min(value);
        end;
        bins = unique(lookup_table);
        for i=1:N;
            lookup_table(i) = find(bins==lookup_table(i))-1;
        end;

    case 'LBP81riu2'
        W = 8;   % Number of pixels of the CCR pattern
        N = 2^W; % Number of different patterns
        lookup_table = zeros(1,N);
        for pattern = 0:N-1;
            bits     = fliplr(bitget(pattern, (1:W)));
            changes  = diff(bits(1:W));
            if sum(changes~=0)>2;
                % Non-uniform patterns
                lookup_table(pattern+1) = W + 1;
            else
                % Uniform patterns
                lookup_table(pattern+1) = sum(bits);
            end;
        end;

    case 'CCR81ri'
        W = 9;   % Number of pixels of the CCR pattern
        N = 2^W; % Number of different patterns
        weights = 2.^(W-1:-1:0);
        lookup_table = zeros(1,N);
        outer_bits_indexes = [1 2 3 6 9 8 7 4];
        for pattern = 0:N-1;
            bits = fliplr(bitget(pattern,(1:W)));
            outer_bits = bits(outer_bits_indexes);
            value = zeros(1, W-1);
            for i=0:W-2;
                rotated_bits = [outer_bits(1+i:W-1), outer_bits(1:i)];
                linear_texel = [rotated_bits(1:4), bits(5), rotated_bits(5:W-1)];
                value(i+1)   = sum(linear_texel.*weights);
            end;
            lookup_table(pattern+1) = min(value);
        end;
        bins = unique(lookup_table);
        for i=1:N;
            lookup_table(i) = find(bins==lookup_table(i))-1;
        end;

    case 'CCR81riu2'
        W = 9;   % Number of pixels of the CCR pattern
        N = 2^W; % Number of different patterns
        lookup_table = zeros(1,N);
        central_pixel_index = 5;
        outer_bits_indexes = [1 2 3 6 9 8 7 4];
        for pattern = 0:N-1;
            bits = fliplr(bitget(pattern,(1:W)));
            outer_bits = bits(outer_bits_indexes);
            changes    = diff(outer_bits);
            if sum(changes~=0)>2;
                % Non-uniform pattern
                lookup_table(pattern+1) = 2*W;
            else
                % Uniform patterns
                if bitget(pattern, central_pixel_index);
                    lookup_table(pattern+1) = sum(outer_bits) + W ;
                else
                    lookup_table(pattern+1) = sum(outer_bits) ;
                end;
            end;
        end;

    otherwise
        error(['The specified feature name ' FeatureName ' does not exist']);
end;