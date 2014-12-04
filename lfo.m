function kdata = lfo( tl,kc,kr,kf,Fs )
%周波数の変化を表すベクトルkdataを出力する関数
% tl: 時間長（秒）
% kc: 中心周波数（Hz）
% kr: 周波数変化の比率
% kf: １秒あたりのビブラートの回数（Hz）
% Fs: サンプリング周波数
% 例） finst = lfo(2,800,0.05,3,Fs);

t = 0:1/Fs:tl;
kw = kc*kr;
kdata = kc+kw*sin(2*pi*kf*t);

end

