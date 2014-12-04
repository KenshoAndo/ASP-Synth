function A = disp_spec(data,N,L,Fs)
%波形data、フレーム長N、フレーム周期L、サンプリングレイトFsを
%入力するとスペクトログラムを表示するとともに、スペクトログラムの行列Aを出力する関数

data = data';
xL = length(data);
w = hanning(N);
NW = ceil((xL-N)/L);
A = zeros(N/2,NW);

for i = 1:NW
    s = (L*(i-1))+1;
    y = data(s:s+N-1).*w;
    z = abs(fft(y,N));
    lz = 20*log10(z);
    A(:,i) = lz(1:N/2);
end

%縦軸の周波数
fd = Fs/N;
freqstep = [0:(N/2-1)]*fd;
td = 0:(1/Fs):(length(data)/Fs);

imagesc(td,freqstep,A);
axis xy;
end

