%��ƽ���ڵ����ߵ�������з������
%���ȼ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha = deg2rad(1.5);
theta =deg2rad(120);
Dmin = 110;%�������ĵ㴦�ĺ�ˮ���
dwest = -4/2 * 1852;
Dwest = Dmin - dwest * tan(alpha); %�����

WRwest = Dwest/(sin(pi/2 + alpha - theta/2)) * sin(theta/2);%��������д�������WRwest
D1 = WRwest * (sin(pi/2 - alpha - theta/2))/sin(theta/2);%����WRwest����WL1�������D1
d1 = (Dmin - D1)/tan(alpha);%���D1���ƾ��뺣�����ĵ�ľ���

deast = 4/2 * 1852;
Deast = Dmin - deast * tan(alpha); %��ǳ��

WLeast = Deast/(sin(pi/2 - alpha - theta/2)) * sin(theta/2);%��������д�������WLeast
Dn = WLeast * (sin(pi/2 + alpha - theta/2))/sin(theta/2);%����WLeast����WRn�������Dn
dn = (Dmin - Dn)/tan(alpha);%���Dn���ƾ��뺣�����ĵ�ľ���

%
WR1 = D1/(sin(pi/2 + alpha - theta/2)) * sin(theta/2);
WL1 = D1/(sin(pi/2 - alpha - theta/2)) * sin(theta/2);
%

D = [D1];%����
d = [d1];%���뺣�����ĵ�ľ���
WR = [WR1];
WL = [WL1];
W = [WR1+WL1];
n = 1;
while 1
    Dnext_Numerator = ( WR(n) - 0.1*W(n) + 0.1*WR(n) - 0.1*(D(n)/(tan(alpha)*cos(alpha))) - D(n)/(tan(alpha)*cos(alpha)) ); %Dnext����
    Dnext_denominator = 0.1* sin(theta/2) * (1/(sin(pi/2 + alpha - theta/2))) -  sin(theta/2) * (1/(sin(pi/2 - alpha - theta/2))) -  0.1*(1/(tan(alpha)*cos(alpha))) - (1/(tan(alpha)*cos(alpha))); %Dnext��ĸ
    Dnext = Dnext_Numerator/Dnext_denominator;
    if Dnext < Dn || D(n) == Dnext
        break;
    end
    dnext = (Dmin - Dnext) / tan(alpha);
    WRnext = Dnext/(sin(pi/2 + alpha - theta/2)) * sin(theta/2);
    WLnext = Dnext/(sin(pi/2 - alpha - theta/2)) * sin(theta/2);
    Wnext = WRnext + WLnext;
    D = [D , Dnext];
    WR = [WR , WRnext];
    WL = [WL , WLnext];
    W = [W,Wnext];
    d = [d,dnext];
    n = n+1;
end

%��ͼ
%��ƽ���ڵ����ߵ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_ = [];
y_ = [];
for i = 1:n
     y = 1;
     x_ = [x_ , d(i)];
     y_ = [y_ , y];
     while 1
         if y+1 > 2*1852
             break;
         end
         y = y + 1;
         x_ = [x_ , d(i)];
         y_ = [y_ , y];
     end
end
plot(x_,y_,'.');
