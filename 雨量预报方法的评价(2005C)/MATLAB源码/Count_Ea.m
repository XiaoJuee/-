%������������������Լ�ƽ����������������
z = cell(7,30,4);%�·�,����,ʱ���-��Ȩֵ
dis=cell(7,30,4,2);%�·�,����,ʱ�Σ����� %Ԥ��

for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4
            z{month,day,time}=importdata(['m',num2str(month,'%02d'),'d',num2str(day,'%02d'),'t',num2str(time,'%02d'),'.cvs']);
            for method = 1:2
                dis{month,day,time,method} = importdata(['f',num2str(month),num2str(day,'%02d'),num2str(time),'_dis',num2str(method)]);
            end
        end
    end
end

%�������
Ea = cell(7,30,4,2);%�·�,����,ʱ���,����
%������ R
R =  cell(7,30,4,2);%�·�,����,ʱ���,����
ping = 0.001;%ƽ��ֵ
wubao_wutoyou = zeros(2,1);
wubao_youtowu = zeros(2,1);
count = zeros(2,1);
for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4 %ʱ��
            for method = 1:2
                R{month,day,time,method} = zeros(53,47);
                for i = 1:53
                    for j = 1:47
                        Ea{month,day,time,method}(i,j) = abs(dis{month,day,time,method}(i,j)-z{month,day,time}(i,j));
                        if(z{month,day,time}(i,j)==0)%��ƽ��ֵ + ����
                            if(dis{month,day,time,method}(i,j)>0.1)%�󱨼���
                                wubao_wutoyou(method) = wubao_wutoyou(method) + 1;
                            end
                            count(method) = count(method) + 1;
                            dis{month,day,time,method}(i,j) = dis{month,day,time,method}(i,j) + ping;
                            z{month,day,time}(i,j) = z{month,day,time}(i,j) + ping;
                            R{month,day,time,method}(i,j) = abs(dis{month,day,time,method}(i,j)-z{month,day,time}(i,j))/(z{month,day,time}(i,j));
                            z{month,day,time}(i,j) = z{month,day,time}(i,j) - ping;
                        else
                            R{month,day,time,method}(i,j) = abs(dis{month,day,time,method}(i,j)-z{month,day,time}(i,j))/(z{month,day,time}(i,j));
                        end
                        if(dis{month,day,time,method}(i,j)<=0.1)
                            if(z{month,day,time}(i,j)>0.1)
                                 wubao_youtowu(method) = wubao_youtowu(method) + 1;
                            end
                        end
                            
                    end
                end
            end%method
        end%time
    end%day
end%moth

%��������������������ƽ��ֵ �� �������ƽ��ֵ
PEa = zeros(2,1);
PR = zeros(2,1);
for method = 1:2
    for month = 6:7 
        for day = 1:30
            if month==6 && day<18 || day > 28
                continue;
            end
            for time = 1:4 %ʱ��
               for i = 1:53
                   for j = 1:47
                           PEa(method) = PEa(method) + Ea{month,day,time,method}(i,j);
                           PR(method) = PR(method) + R{month,day,time,method}(i,j);
                   end
               end
            end%time
        end%day
    end%moth
    PEa(method) = PEa(method)/(41*4*53*47);
    PR(method) = PR(method)/(41*4*53*47);
end