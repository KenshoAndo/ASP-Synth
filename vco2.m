function outwav = vco2(finst,a,tl,ta,td,sl,tr,Fs)
%時変化フィルタを内部で呼び出す
% finst: 瞬時周波数ベクトル
% tl: 時間長
% a: selector.mによる倍音の振幅
% ta: VCF用のアタック時間
% td: VCF用の減衰時間
% sl: VCF用のサステインレベル
% tr: VCF用のレリーズ時間
% Fs: サンプリング周波数
lt= length(0:1/Fs:tl);

y = zeros(1,(length(finst)+1));
%y = zeros(1,(length(finst)));
d = 1/Fs;

for i = 1:length(a)
    b = i*2*pi*finst*d;
    ph = cumsum([0 b]);
    envh = vcf2(i,length(a),tl,ta,td,sl,tr,Fs);
    envh =[envh 0];
    envh= envh(1:lt+1);
    
    yy = a(i)*sin(ph).*envh;
    y = y+yy;
end

outwav = y/max(abs(y));

end

