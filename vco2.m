function outwav = vco2(finst,a,tl,ta,td,sl,tr,Fs)
%���ω��t�B���^������ŌĂяo��
% finst: �u�����g���x�N�g��
% tl: ���Ԓ�
% a: selector.m�ɂ��{���̐U��
% ta: VCF�p�̃A�^�b�N����
% td: VCF�p�̌�������
% sl: VCF�p�̃T�X�e�C�����x��
% tr: VCF�p�̃����[�Y����
% Fs: �T���v�����O���g��
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

