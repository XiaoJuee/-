%�Դ�ֱ�ڵ����ߵ�������з������
%A�� ���� A��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
long = 4.5-1.5;
short = 2.5-0;
x = 1:short*1852;
%�Ƕȼ���
theta =120;
alpha = atan(0.0304);
beta = 180;
lambda = atan(-tan(alpha) * cosd(beta));

WR = zeros(long*1852,1);
WL = zeros(long*1852,1);
W = zeros(long*1852,1);
D = zeros(long*1852,1);

Dnorth = depth(1,201); %�����

l = 1:long*1852;
for i = 1:long*1852
    D(i) = Dnorth - l(i) * tan(lambda);
    WR(i) = D(i)/(sind(90 + lambda - theta/2)) * sind(theta/2);
    WL(i) = D(i)/(sind(90 - lambda- theta/2)) * sind(theta/2);
    W(i) = WR(i) + WL(i);
end

%ÿm�ĺ���������������������ƽ̹��ȥ��

%eta = 1 - d/w
%d = w*(1 - eta)
d = zeros(long*1852,1);
for i = 1:long*1852
    d(i) = W(i) * (1-0.1);
end

%���Ʋ��ߵ�����
sum = 0;
for i = 1:long*1852
    sum = short*1852/d(i) + sum;
end
sum


%��ͼ
%�Դ�ֱ�ڵ����ߵ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_ = [];
y_ = [];
for i = 1:long*1852
     y = WL(i);
     x_ = [x_ , i+1*1852];
     y_ = [y_ , y];
     while 1
         if y+WR(i) > short*1852
             break;
         end
         y = y + d(i);
         x_ = [x_ , i+1*1852];
         y_ = [y_ , y];
     end
end
plot(x_,y_,'.');
title('A����');
