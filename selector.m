function a = selector( N , wavetype )
%UNTITLED 倍音振幅ベクトルをつくる関数
%　a: 倍音の振幅 
%　N: 倍音の数
%　例）a = selector(15,3);

a = zeros(1,N); %振幅ベクトル初期化

if wavetype== 1 %正弦波の場合
a(1) = 1;

elseif wavetype == 2 %のこぎり波

for i = 1:N
    a(i) = 1/i;
end

elseif wavetype== 3 %方形波
for i = 1:N
    if rem(i,2) == 1
    a(i) = 1/i;

    else
        a(i) = 0;
    end
end
end

