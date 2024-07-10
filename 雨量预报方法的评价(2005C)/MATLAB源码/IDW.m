%��ȡ��γ�ȣ�ͨ��ī����ͶӰ������γ��ת��Ϊƽ������,Ȼ��ͨ���������Ȩ��ֵ����

%Ԥ��������ȡ
lon = importdata('lon.dat');%����-Ԥ���
lat = importdata('lat.dat');%γ��-Ԥ���

%ī����ͶӰ��
earthRad = 6378137.0;
x = ((lon .* pi) ./ 180) .* earthRad;% 53*47
a = (lat .* pi) ./ 180;
y = (earthRad ./ 2) .* log((1.0 + sin(a)) ./ (1.0 - sin(a)));

%ʵ��������ȡ
mea=cell(7,30);%�·�,����, ����ʵ��ֵ
for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        mea{month,day}=importdata(['02',num2str(month,'%02d'),num2str(day,'%02d'),'.SIX']);
    end
end


lon2 = zeros(91,1);%����-ʵ���
lat2 = zeros(91,1);%γ��-ʵ���
for i=1:91
    lon2(i) = mea{7,1}(i,3);
    lat2(i) = mea{7,1}(i,2);
end

x2 = ((lon2 .* pi) ./ 180) .* earthRad;%91*1
a2 = (lat2 .* pi) ./ 180;
y2 = (earthRad ./ 2) .* log((1.0 + sin(a2)) ./ (1.0 - sin(a2)));




%�������Ȩ��ֵ��
p = 1;%ȡֵΪ 1

%����di-���������ֵλ�õľ���
%����Ȩ�� wi �� �ǵ� i �������Ȩ�� wi = 1/(di)^p
d = zeros(53,47,91);%��i��j�е�Ԥ����Ӧ�ĵ�k��ʵ���ľ��� % ������·�,����,ʱ���޹�
wi = zeros(53,47,91);%��i��j�е�Ԥ����Ӧ�ĵ�k��ʵ����Ȩ�� % Ȩ�غ��·�,����,ʱ���޹�
sum_wi = zeros(53,47);%Ȩֵ���

for i = 1:53
    for j = 1:47
        for k = 1:91
            d(i,j,k) = sqrt((x(i,j)-x2(k))^2 + (y(i,j)-y2(k))^2);
            if(d(i,j,k) == 0)%���Ԥ����ʵ����غ�
                wi(i,j,k) = 0;
                continue;
            end
            sum_wi(i,j) = sum_wi(i,j) + 1/(d(i,j,k));
        end
    end
end


for i = 1:53
    for j = 1:47
        for k = 1:91
            if(d(i,j,k) == 0)%���Ԥ����ʵ����غ�
                wi(i,j,k) = 0;
                continue;
            end
            wi(i,j,k) = (1/d(i,j,k))/(sum_wi(i,j));
        end
    end
end

z = cell(7,30,4);%�·�,����,ʱ��



for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4 %ʱ��
            for i=1:53
                for j=1:47
                    sum_wizi = 0;
                    for k = 1:91
                        if(wi(i,j,k)==0)%���Ԥ����ʵ����غ�
                            sum_wizi = mea{month,day}(k,time+3)*sum_wi(i,j); % ʹ����z��ʽΪʵ��ֵ
                            break;%ֱ�Ӽ���z��ʽ
                        end
                        sum_wizi = sum_wizi + mea{month,day}(k,time+3)*wi(i,j,k);
                    end%k
                    z{month,day,time}(i,j) = sum_wizi;
                end%j
            end%i
        end%time
    end%day
end%moth

%���������Ȩ��ֵ�������ֵд��excel�ļ� or cvs �ļ�

for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4
            csvwrite(['m',num2str(month,'%02d'),'d',num2str(day,'%02d'),'t',num2str(time,'%02d'),'.cvs'],z{month,day,time});
            xlswrite(['m',num2str(month,'%02d'),'d',num2str(day,'%02d'),'t',num2str(time,'%02d'),'.xls'],z{month,day,time});
        end
    end
end