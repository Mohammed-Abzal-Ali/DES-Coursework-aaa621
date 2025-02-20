% Produce the cartesian product between 2 character arrays
% e.g. ('1','2') x ('4','5') = ((1,4),(1,5),(2,4),(2,5))

function set_out = CartProd(set1, set2)
    % Get size of each of the input sets
    % Size: no. of elements x length of largest element
    sz1 = size(set1);
    sz2 = size(set2);
    % Combine the elements
    set_out = char();
    for idx_1 = 1:sz1(1)
        for idx_2 = 1:sz2(1)
            out_idx = ((idx_1 - 1) * sz2(1))+ idx_2;
            out_len = 3 + sz1(2) + sz2(2);
            out_str = strcat('(', set1(idx_1,:), ',', set2(idx_2,:), ')');
            set_out(out_idx,1:out_len) = char(out_str);
        end
    end
end