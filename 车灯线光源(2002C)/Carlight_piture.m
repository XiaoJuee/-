clear,clc
a=2;
u=0:0.01:2*pi;
theta=0:pi/100:2*pi;
[U,Theta]=meshgrid(u,theta);   %���ɶ�ά��������
X=U.*sin(Theta);
Y=U.*cos(Theta);
Z=U.^2.*a;
mesh(X,Y,Z)
xlabel('x��')
ylabel('y��')
zlabel('z��')
title('z=sin(x)��z����ת')
%surf(X,Y,Z)