function ar = rg(N,r,c,bw)
%共振特性をつくる関数rg
% N 倍音の数
% r　共振特性（振幅倍率）
% c　中心倍音の番号
% bw　共振する倍音の数（バンド幅）

b = floor(bw/2);
ar = ones(1,N);

for i = c-b:c+b
    ar(i) = r;
end

end

