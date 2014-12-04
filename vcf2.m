function envh = vcf2( i,N,tl,ta,td,sl,tr,Fs )
%envh = vcf( i,N,tl,ta,td,sl,tr,Fs )
% envh: ��i�{���̐U���
% i: �{���ԍ��i��i�{���j
% N: �{���̐�
% tl: ���̎��Ԓ��i�b�j
% ta: VCF�p�̃A�^�b�N���ԁi�b�j
% td: VCF�p�̌������ԁi�b�j
% sl: VCF�p�̃T�X�e�C�����x���i0�`1�j
% tr: VCF�p�̃����[�Y���ԁi�b�j
% Fs: �T���v�����O���g��

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


