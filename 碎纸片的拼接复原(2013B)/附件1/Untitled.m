d =cell(1,19);
for i = 1:19
    imageName=strcat(num2str(i-1,'%03d'),'.bmp');
    d{i}=imread(imageName);
end
a = cell(19,19);
for i = 1:19
    for j = 1:19
        sum = 0;
        for jj = 1:1980
            sum = sum + abs( double(d{i}(jj,72))-double(d{j}(jj,1)) );% j��i����Ĳ�ֵ
        end
        a{i,j} = sum; % ˳���� i j
    end
end
xlswrite('D:\homewrok\��ģ\ֽƬ\201391394826489\2013��ȫ����ѧ����ѧ��ģ����B�⸽��\����1\a.xls', a);
%{
for i = 1:19
    for j = 1:19
        sum = 0;
        for jj = 1:1980
            if d{i}(jj,1) == d{j}(jj,72)
                sum=sum+1;
            end
        end
        a{i,j} = sum;
    end
end

c = cell(1,19);
for i = 1:19
    jj = 1;
    maxa = 0;
    for j = 1:19
        if maxa < a{j,i}
            jj = j;
            maxa = a{j,i};
        end
    end
    c{1,i} = jj;
end
disp(c);
i = 9;
ansd=[];
while i~=7
    ansd=[ansd,d{i}];
    i = c(i);
end
ansd=[ansd,d{7}];
imshow(ansd);
%}


