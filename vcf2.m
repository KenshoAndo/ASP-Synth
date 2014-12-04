function envh = vcf2( i,N,tl,ta,td,sl,tr,Fs )
%envh = vcf( i,N,tl,ta,td,sl,tr,Fs )
% envh: 第i倍音の振幅包絡
% i: 倍音番号（第i倍音）
% N: 倍音の数
% tl: 音の時間長（秒）
% ta: VCF用のアタック時間（秒）
% td: VCF用の減衰時間（秒）
% sl: VCF用のサステインレベル（0～1）
% tr: VCF用のレリーズ時間（秒）
% Fs: サンプリング周波数

d = 1/Fs;
ni = i/N;
da = ta*ni;

if ni>sl
    ds = (ta+td)-(ni-sl)/(1-sl)*td-da;
else
    ds = tl-(ni/sl)*tr-da;
end

dr= 0.05;

lt = length(0:d:tl);    la = round(da*Fs);
ls = round(ds*Fs);      lr = round(dr*Fs);

ea = 0:1/(la-1):1;      es = ones(1,ls);
er = 1: -1/(lr-1):0;
le= lt -length(ea) -length(es) -length(er);

if 0 < le
    ee =zeros(1,le);
else
    es = es(1:ls+le);
    ee = [];
end

envh = [ea es er ee];
end


