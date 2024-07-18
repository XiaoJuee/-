% ��ȡ����
data = xlsread('����4����.xlsx');
% ��ȡ������������
x = data(1, 2:end); % ��һ�г�ȥ��һ��Ԫ��Ϊ x ����
y = data(2:end, 1); % ��һ�г�ȥ��һ��Ԫ��Ϊ y ����
depth = data(2:end, 2:end); % �������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nautical_mile = 1852;
%�Ƕȼ���
theta =120;
WLfrist = zeros(201,1);
alpha = zeros(201,201);
WR = zeros(201,201);
WL = zeros(201,201);
W = zeros(201,201);
%����ÿ���㴬�Ĳ���
for i = 1:201
    alpha(i,201) = atan( (depth(i,201) -  depth(i,200)) / 0.1);
    WR(i,201) = depth(i,201)/(sind(90 + alpha(i,201) - theta/2)) * sind(theta/2);
    WL(i,201) = depth(i,201)/(sind(90 - alpha(i,201) - theta/2)) * sind(theta/2);
    W(i,201) = WR(i,201) + WL(i,201);
    for j = 200:-1:51
        alpha(i,j) = atan( (depth(i,j) -  depth(i,j-1)) / 0.1);
        WR(i,j) = depth(i,j)/(sind(90 + alpha(i,j) - theta/2)) * sind(theta/2);
        WL(i,j) = depth(i,j)/(sind(90 - alpha(i,j) - theta/2)) * sind(theta/2);
        W(i,j) = WR(i,j) + WL(i,j);
    end
end

%ѡ��
for i = 1:201
    
end




