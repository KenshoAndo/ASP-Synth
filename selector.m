function a = selector( N , wavetype )
%UNTITLED �{���U���x�N�g��������֐�
%�@a: �{���̐U�� 
%�@N: �{���̐�
%�@��ja = selector(15,3);

a = zeros(1,N); %�U���x�N�g��������

if wavetype== 1 %�����g�̏ꍇ
a(1) = 1;

elseif wavetype == 2 %�̂�����g

for i = 1:N
    a(i) = 1/i;
end

elseif wavetype== 3 %���`�g
for i = 1:N
    if rem(i,2) == 1
    a(i) = 1/i;

    else
        a(i) = 0;
    end
end
end

