y = zeros(1,1000);
x = zeros(1,1000);
x(1)=0;
y(1)=0;
v1=0;
v2=2;
h=0.1;
%差分求解轨迹
for n=1:1000
    x(n+1)=x(n)+h*((sqrt(x(n)^2+(100-y(n))^2)*v1-v2*x(n))/(v2*(100-y(n))));
    y(n+1)=y(n)+h;
end

plot(x,y,'-');
hold on;
%四阶龙格-库塔方法求轨迹
y = zeros(1,1000);
x = zeros(1,1000);
x(1)=0;
y(1)=0;
for n=1:1000
    k1 = h*((sqrt(x(n)^2+(100-y(n))^2)*v1-v2*x(n))/(v2*(100-y(n))));%h*f(x(n),y(n))
    k2 = h*((sqrt((x(n)+h/2)^2+(100-(y(n)+k1/2))^2)*v1-v2*(x(n)+h/2))/(v2*(100-(y(n)+k1/2))));%h*f(x(n)+h/2,y(n)+k1/2)
    k3 = h*((sqrt((x(n)+h/2)^2+(100-(y(n)+k2/2))^2)*v1-v2*(x(n)+h/2))/(v2*(100-(y(n)+k2/2))));%h*f(x(n)+h/2,y(n)+k2/2)
    k4 = h*((sqrt((x(n)+h)^2+(100-(y(n)+k3))^2)*v1-v2*(x(n)+h))/(v2*(100-(y(n)+k3))));%h*f(x(n)+h,y(n)+k3)
    x(n+1)=x(n)+(1/6)*(k1+2*k2+2*k3+k4);
    y(n+1)=y(n)+h;
end
plot(x,y,'-');
%(sqrt(x(n)^2+(100-y(n))^2)
%差分求解时间
t = zeros(1,1000);
for n=1:1000
    t(n+1)=t(n)+h*(1/(v2*(100-y(n))/(sqrt(x(n)^2+(100-y(n))^2))));
end

xlim([0,10]);
ylim([0,100]);