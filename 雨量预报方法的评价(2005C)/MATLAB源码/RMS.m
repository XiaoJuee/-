%计算均方根误差

z = cell(7,30,4);%月份,日期,时间段-加权值
dis=cell(7,30,4,2);%月份,日期,时段，方法 %预测

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

%评级
%加权值
ZRate = cell(7,30,4);%月份,日期,时间段 加权值评级
%预测
CRate =  cell(7,30,4,2);%月份,日期,时间段,方法 预测评级

for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4 %时段
            for method = 1:2
                
                for i = 1:53
                    for j = 1:47
                        if z{month,day,time}(i,j)<=0.1
                            ZRate{month,day,time}(i,j) = 0;
                        elseif z{month,day,time}(i,j)<=2.5
                            ZRate{month,day,time}(i,j) = 3;
                        elseif z{month,day,time}(i,j)<=6.0
                            ZRate{month,day,time}(i,j) = 4;
                        elseif z{month,day,time}(i,j)<=12
                            ZRate{month,day,time}(i,j) = 5;
                        elseif z{month,day,time}(i,j)<=25
                            ZRate{month,day,time}(i,j) = 6;
                        elseif z{month,day,time}(i,j)<=60
                            ZRate{month,day,time}(i,j) = 7;
                        else
                            ZRate{month,day,time}(i,j) = 8;
                        end
                        
                        if dis{month,day,time,method}(i,j)<=0.1
                            CRate{month,day,time,method}(i,j) = 0;
                        elseif dis{month,day,time,method}(i,j)<=2.5
                            CRate{month,day,time,method}(i,j) = 3;
                        elseif dis{month,day,time,method}(i,j)<=6.0
                            CRate{month,day,time,method}(i,j) = 4;
                        elseif dis{month,day,time,method}(i,j)<=12
                            CRate{month,day,time,method}(i,j) = 5;
                        elseif dis{month,day,time,method}(i,j)<=25
                            CRate{month,day,time,method}(i,j) = 6;
                        elseif dis{month,day,time,method}(i,j)<=60
                            CRate{month,day,time,method}(i,j) = 7;
                        else
                            CRate{month,day,time,method}(i,j) = 8;
                        end
                        
                    end
                end
            end%method
        end%time
    end%day
end%moth


%方根误差
f = cell(7,30,4,2);%月份,日期,时间段,方法

for month = 6:7 
    for day = 1:30
        if month==6 && day<18 || day > 28
            continue;
        end
        for time = 1:4 %时段
            for method = 1:2
                for i = 1:53
                    for j = 1:47
                        f{month,day,time,method}(i,j) = (ZRate{month,day,time}(i,j)-CRate{month,day,time,method}(i,j))^2;
                    end
                end
            end%method
        end%time
    end%day
end%moth

%计算两个方法的均方根误差

F = zeros(2,1);
for method = 1:2
    for month = 6:7 
        for day = 1:30
            if month==6 && day<18 || day > 28
                continue;
            end
            for time = 1:4 %时段
               for i = 1:53
                   for j = 1:47
                           F(method) = F(method) + f{month,day,time,method}(i,j);
                   end
               end
            end%time
        end%day
    end%moth
    F(method) = sqrt(F(method)/(41*4*53*57));
end