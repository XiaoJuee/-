t = 10; %���м��ķ���
k = 1000; %δ���ֹ���ʱ����һ���µ��ߵķ���
d = 3000; %���ֹ��Ͻ��е���ʹ�ָ�������ƽ������
f = 200; %����ʱ�����������ʧ����
ans_n = 0;
ans_m = 0;
ans_wt = 1e9;
x = abs(normrnd(600,195.644,10000));
for n = 1:50
    for s = 1:100
        m=s*n;
        wt = 0;
        for i = 1:length(x);
            w = 0;
            t = 0;
            if x(i) < m
                w = w+ceil(x(i)/n)*t+d+(ceil(x(i)/n)*n-x(i))*f;
                t = t+x(i);
            else
                w = w+s*t+k;
                t = t+m;
            end
            wt = wt + w/t;
            if ans_wt*1000 < wt
                break;
            end
        end
        if ans_wt > wt/1000
            ans_n = n;
            ans_m = m;
            ans_wt = wt/1000;
        end
    end
end
disp(ans_n);
disp(ans_m);

%{
for y = 1:200
    yy = 0;
    for j = 1:1000
        x = normrnd(600,195.644);
        if x<=y
            yy = yy+200*(y-x)+3000+10;
        else
            yy = yy+10;
        end
    end
    if yy < ans_yy
        ans_yy = yy;
        ans_y = y;
    end
end
disp(ans_y);
%}