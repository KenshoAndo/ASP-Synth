function kdata = lfo( tl,kc,kr,kf,Fs )
%���g���̕ω���\���x�N�g��kdata���o�͂���֐�
% tl: ���Ԓ��i�b�j
% kc: ���S���g���iHz�j
% kr: ���g���ω��̔䗦
% kf: �P�b������̃r�u���[�g�̉񐔁iHz�j
% Fs: �T���v�����O���g��
% ��j finst = lfo(2,800,0.05,3,Fs);

t = 0:1/Fs:tl;
kw = kc*kr;
kdata = kc+kw*sin(2*pi*kf*t);

end

