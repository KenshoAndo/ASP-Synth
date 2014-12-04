%function env = adsr( x,ta,td,sl,tr,Fs )
function env= adsr(tl,ta,td,sl,tr,Fs)
%音全体の振幅変化（振幅包絡）を作る関数
%   詳細説明をここに記述

%lt= length(x);
lt= length(0:1/Fs:tl);

la = floor(ta*Fs);
ld= floor(td*Fs);
lr= floor(tr*Fs);

ea= 0:1/(la-1):1;
ed= 1:-(1-sl)/(ld-1):sl;
er= sl:-(sl/(lr-1)):0;
es= ones(1,lt-la-ld-lr)*sl;

env= [ea ed es er 0];
env= env(1:lt+1);

end

