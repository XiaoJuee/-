%���©
% ��ȡ����
data = xlsread('����4����.xlsx');
% ��ȡ������������
x = data(1, 2:end); % ��һ�г�ȥ��һ��Ԫ��Ϊ x ����
y = data(2:end, 1); % ��һ�г�ȥ��һ��Ԫ��Ϊ y ����
depth = data(2:end, 2:end); % �������

theta =120;
WLfrist = zeros(251,1);
alpha = zeros(251,251);
WR = zeros(251,251);
WL = zeros(251,251);
W = zeros(251,251);
sum = 0;
for i=201:251
    alpha(i,201) = atan( (depth(i,201) -  depth(i,200)) / 0.1);
    WR(i,201) = depth(i,201)/(sind(90 + alpha(i,201) - theta/2)) * sind(theta/2);
    WL(i,201) = depth(i,201)/(sind(90 - alpha(i,201) - theta/2)) * sind(theta/2);
    W(i,201) = WR(i,201) + WL(i,201);
    for j = 151 : 201
        alpha(i,j) = atan( (depth(i,j) -  depth(i,j-1)) / 0.1);
        WR(i,j) = depth(i,j)/(sind(90 + alpha(i,j) - theta/2)) * sind(theta/2);
        WL(i,j) = depth(i,j)/(sind(90 - alpha(i,j) - theta/2)) * sind(theta/2);
        W(i,j) = WR(i,j) + WL(i,j);
        sum = sum + 1852/W(i,j) * W(i,j);
    end
end

long = 4-2.5;
short = 5-4;
sum
long*short*1852*1852 - sum
327804/(long*short*1852*1852)