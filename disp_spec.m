function A = disp_spec(data,N,L,Fs)
%�g�`data�A�t���[����N�A�t���[������L�A�T���v�����O���C�gFs��
%���͂���ƃX�y�N�g���O������\������ƂƂ��ɁA�X�y�N�g���O�����̍s��A���o�͂���֐�

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

%�c���̎��g��
fd = Fs/N;
freqstep = [0:(N/2-1)]*fd;
td = 0:(1/Fs):(length(data)/Fs);

imagesc(td,freqstep,A);
axis xy;
end

