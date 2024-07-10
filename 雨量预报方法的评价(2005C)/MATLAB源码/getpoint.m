%��ȡ��γ�ȣ�ͨ��ī����ͶӰ������γ��ת��Ϊƽ�����꣬�ٽ���Ӧƽ�����걣�������execl
lon = importdata('lon.dat');%����-Ԥ���
lat = importdata('lat.dat');%γ��-Ԥ���

%ī����ͶӰ��
earthRad = 6378137.0;
x = ((lon .* pi) ./ 180) .* earthRad;
a = (lat .* pi) ./ 180;
y = (earthRad ./ 2) .* log((1.0 + sin(a)) ./ (1.0 - sin(a)));
%�����execl
xlswrite('xpoint.xls',x);
xlswrite('ypoint.xls',y);

mea=cell(7,30);%�·�,����, ����ʵ��ֵ
for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        mea{month,day}=importdata(['02',num2str(month,'%02d'),num2str(day,'%02d'),'.SIX']);%��ȡ�ļ�
    end
end


lon2 = zeros(91,1);%����-ʵ���
lat2 = zeros(91,1);%γ��-ʵ���

for i=1:91
    lon2(i) = mea{7,1}(i,3);
    lat2(i) = mea{7,1}(i,2);
end

x2 = ((lon2 .* pi) ./ 180) .* earthRad;
a2 = (lat2 .* pi) ./ 180;
y2 = (earthRad ./ 2) .* log((1.0 + sin(a2)) ./ (1.0 - sin(a2)));
xlswrite('shice_xpoint.xls',x2);
xlswrite('shice_ypoint.xls',y2);