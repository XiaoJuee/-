rho = [300, 862, 74.2, 1.18]; %�ܶ�
c = [1377, 2100, 1726, 1005]; %����
k = [0.082, 0.37, 0.045, 0.028]; %�ȴ���ϵ��
kd =1 ;
for k_d2 = 0.0006:0.0001:0.025
    
k_out = 108; 
k_skin = 8.3;

d = [0.0006, k_d2, 0.0036, 0.0055]; %ÿ��ĺ��
dt = 1; %�¶Ȳ���
dx = 0.1 * 10^(-3); %���벽��

r1 = k(1) * dt / (c(1) * rho(1) * dx * dx);
r2 = k(2) * dt / (c(2) * rho(2) * dx * dx);
r3 = k(3) * dt / (c(3) * rho(3) * dx * dx);
r4 = k(4) * dt / (c(4) * rho(4) * dx * dx);

N = round(sum(d) / dx + 1);
A = zeros(N); %��ʽ��ߣ��м��������

%��߽�����
A(1, 1) = 1 + 2 * r1 + 2 * dx * k_out * r1 / k(1);

%��I��
A(1, 2) = -2 * r1;
d1 = round(d(1) / dx + 1); %����
for i = 2 : d1 - 1
    A(i, i) = 1 + 2 * r1;
    A(i, i - 1) = -r1;
    A(i, i + 1) = -r1;
end

%��I�����II��Ӵ���
A(d1, d1 - 1) = -k(1) / dx;
A(d1, d1 + 1) = -k(2) / dx;
A(d1, d1) = -(A(d1, d1 - 1) + A(d1, d1 + 1));

%��II��
d2 = d1 + round(d(2) / dx);
for i = d1 + 1 : (d2 - 1)
    A(i, i) = 1 + 2 * r2;
    A(i, i - 1) = -r2;
    A(i, i + 1) = -r2;
end

%��II�����III��Ӵ���
A(d2, d2 - 1) = -k(2) / dx;
A(d2, d2 + 1) = -k(3) / dx;
A(d2, d2) = -(A(d2, d2 - 1) + A(d2, d2 + 1));

%��III��
d3 = d2 + round(d(3) / dx);
for i = d2 + 1 : (d3 - 1)
    A(i, i) = 1 + 2 * r3;
    A(i, i - 1) = -r3;
    A(i, i + 1) = -r3;
end

%��III�����IV��Ӵ���
A(d3, d3 - 1) = -k(3) / dx;
A(d3, d3 + 1) = -k(4) / dx;
A(d3, d3) = -(A(d3, d3 - 1) + A(d3, d3 + 1));

%��IV��
d4 = d3 + round(d(4) / dx);
for i = d3 + 1 : (d4 - 1)
    A(i, i) = 1 + 2 * r4;
    A(i, i - 1) = -r4;
    A(i, i + 1) = -r4;
end

%�ұ߽�����
A(d4, d4) = 1 + 2 * r4 + 2 * dx * k_skin * r4 / k(4);
A(d4, d4 - 1) = -2 * r4;

%�¶�
U = zeros(3601, N);
U(1, :) = 37;

%�����Է��̣�����¶�
for i = 1 : 3600
    b = U(i, :)';
    b(1) = b(1) + 2 * dx * k_out * 65 * r1 / k(1);
    b(N) = b(N) + 2 * dx * r4 * k_skin * 37 / k(4);
    b(d1) = 0;
    b(d2) = 0;
    b(d3) = 0;
    U(i + 1, :) = A \ b;
end
sum_ = 0;
for i = 1:3601
    if U(i,d4) > 44.0000
        sum_ = sum_ + 1;
    end
end
if sum_ <= 300
    kd = min(k_d2,kd);
    break;
end
end
k_d2 = kd;


%%%%%%%%%%%%%%%%
    
k_out = 108; 
k_skin = 8.3;

d = [0.0006, k_d2, 0.0036, 0.0055]; %ÿ��ĺ��
dt = 1; %�¶Ȳ���
dx = 0.1 * 10^(-3); %���벽��

r1 = k(1) * dt / (c(1) * rho(1) * dx * dx);
r2 = k(2) * dt / (c(2) * rho(2) * dx * dx);
r3 = k(3) * dt / (c(3) * rho(3) * dx * dx);
r4 = k(4) * dt / (c(4) * rho(4) * dx * dx);

N = round(sum(d) / dx + 1);
A = zeros(N); %��ʽ��ߣ��м��������

%��߽�����
A(1, 1) = 1 + 2 * r1 + 2 * dx * k_out * r1 / k(1);

%��I��
A(1, 2) = -2 * r1;
d1 = round(d(1) / dx + 1); %����
for i = 2 : d1 - 1
    A(i, i) = 1 + 2 * r1;
    A(i, i - 1) = -r1;
    A(i, i + 1) = -r1;
end

%��I�����II��Ӵ���
A(d1, d1 - 1) = -k(1) / dx;
A(d1, d1 + 1) = -k(2) / dx;
A(d1, d1) = -(A(d1, d1 - 1) + A(d1, d1 + 1));

%��II��
d2 = d1 + round(d(2) / dx);
for i = d1 + 1 : (d2 - 1)
    A(i, i) = 1 + 2 * r2;
    A(i, i - 1) = -r2;
    A(i, i + 1) = -r2;
end

%��II�����III��Ӵ���
A(d2, d2 - 1) = -k(2) / dx;
A(d2, d2 + 1) = -k(3) / dx;
A(d2, d2) = -(A(d2, d2 - 1) + A(d2, d2 + 1));

%��III��
d3 = d2 + round(d(3) / dx);
for i = d2 + 1 : (d3 - 1)
    A(i, i) = 1 + 2 * r3;
    A(i, i - 1) = -r3;
    A(i, i + 1) = -r3;
end

%��III�����IV��Ӵ���
A(d3, d3 - 1) = -k(3) / dx;
A(d3, d3 + 1) = -k(4) / dx;
A(d3, d3) = -(A(d3, d3 - 1) + A(d3, d3 + 1));

%��IV��
d4 = d3 + round(d(4) / dx);
for i = d3 + 1 : (d4 - 1)
    A(i, i) = 1 + 2 * r4;
    A(i, i - 1) = -r4;
    A(i, i + 1) = -r4;
end

%�ұ߽�����
A(d4, d4) = 1 + 2 * r4 + 2 * dx * k_skin * r4 / k(4);
A(d4, d4 - 1) = -2 * r4;

%�¶�
U = zeros(3601, N);
U(1, :) = 37;

%�����Է��̣�����¶�
for i = 1 : 3600
    b = U(i, :)';
    b(1) = b(1) + 2 * dx * k_out * 65 * r1 / k(1);
    b(N) = b(N) + 2 * dx * r4 * k_skin * 37 / k(4);
    b(d1) = 0;
    b(d2) = 0;
    b(d3) = 0;
    U(i + 1, :) = A \ b;
end



t = 1:3601;
xlabel('ʱ��(s)');
ylabel('�¶�(��)');
title('Ƥ�������¶���ʱ��仯ͼ');
hold on
plot(t, U(:, d4), 'r')

figure
mesh(U)
xlabel('λ��');
ylabel('ʱ��');
zlabel('�¶�');

