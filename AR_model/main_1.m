clear global
clear
clc
global m
global data
global AF
global NSR
load AF
load NSR
data=[];

for ii=1:10
    data(:,ii)=AF{ii}(1,:)';
end
data=zscore(data);
%load and standardize AF data

factor=1:1:30;
for ii=1:length(factor)
    for jj=1:10
        temp=ar(data(:,jj),factor(ii),'yw');
        am(ii,jj)=aic(temp);
    end
end
plot(factor,am)
xlabel('factor P')
ylabel('prediction error')
title('Prediction Error of Ten Sets AF Data')
%find order P of AF
%because the error does not reduce significantly
%after 15, thus we choose 15

%establish AF AR model 
figure()
factor=15;%select factor as 15 
ts=iddata(data,[]);
m=ar(ts(:,1),factor,'yw');
compare(ts(:,1),m,1)
legend('original signal','simulated signal and accuracy')
figure()
[e,r]=resid(m,ts(:,1),'corr',40);
plot(e) 
title('Risidual')
%plot the  residual


%% establish AR model for NSR
data_1=[];
factor=1:5:150;
for ii=1:10
    data_1(:,ii)=NSR{ii}(1,:)';
end
data_1=zscore(data_1);
%load and standardize NSR data

for ii=1:length(factor)
    for jj=1:10
        temp=ar(data_1(:,jj),factor(ii),'yw');
        am_1(ii,jj)=aic(temp);
    end
end
figure()
plot(factor,am_1)
xlabel('factor P')
ylabel('prediction error')
title('Prediction Error of Ten Sets NSR Data')
%find order P

figure()
factor=9;%select factor as 9 
ts_1=iddata(data_1,[]);
m_1=ar(ts_1(:,1),factor,'yw');
compare(ts_1(:,1),m_1,1)
%calculate the error
legend('original signal','simulated signal and accuracy')
figure()
[e,r]=resid(m_1,ts(:,1),'corr',40);
plot(e) %plot the residule
title('Risidual')

%% Classification of NSR and AF by comparison 
%the accuracy of AF AR model and NSR AR model

temp=input('Input the data set you want to classify:');
temp_1=iddata(temp,[]);
[~,error(1)]=compare(temp_1,m,1);
[~,error(2)]=compare(temp_1,m_1,1);
if error(2)>error(1)
    disp('This is NSR')
else
    disp('This is AF')
end

        
        