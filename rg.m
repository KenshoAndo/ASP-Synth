function ar = rg(N,r,c,bw)
%���U����������֐�rg
% N �{���̐�
% r�@���U�����i�U���{���j
% c�@���S�{���̔ԍ�
% bw�@���U����{���̐��i�o���h���j

b = floor(bw/2);
ar = ones(1,N);

for i = c-b:c+b
    ar(i) = r;
end

end

