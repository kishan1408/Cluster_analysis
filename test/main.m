%% 
clear all;
close all;

%%
%-------------------- file load --------------------------------

filename = 'E:\project\New folder\For analyses\clustering\6_threshold 400.txt';
delimiter = '\t';
startRow = 17;
formatSpec = '%*s%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'ReturnOnError', false);
fclose(fileID);
threshold400 = [dataArray{1:end-1}];
clearvars  delimiter startRow formatSpec fileID dataArray ans;

f_name=strcat(filename([1:length(filename)-4]),'_Results');
mkdir(f_name) % make folder to store results
cd(f_name);
%% data 
tfr=0.004; % 4 ms time/frame
timefr=threshold400(:,1);
[val,ind,fr]=unique(timefr);
pos=[threshold400(:,2),threshold400(:,3)];
%------bar plot of #dots/frame
    figure();
    h=bar(tfr*(val(2:end)),diff(ind));
    title('Plot for Points/Frame vs Time'); xlabel('Time(in Seconds)'); ylabel('Number of Points/Frame')
    xlim([0,tfr*val(end)])
   % set(gcf,'paperunits','inches','paperposition',[0 0 size/res]);
    saveas(h,'Points_frames','epsc');
    saveas(h,'Points_frames','tiff');
    
%% All frame projection image
    
%% Frame structure based on N (Number of points)
   N=10000;
   [FF,ts,te]=fr_struct(timefr,pos(:,1),pos(:,2),N);
   
   plot(tfr*(te-ts),'.-r')
%% optics
N=5000;
minpts=5;
epsilon=0.01;
%points=[FF(1).datax',FF(1).datay'];
points=(pos(1:N,:));
[ SetOfClusters, RD, CD, order ] = cluster_optics(points, minpts, epsilon);
%bar(RD(order));
%%
[a l]=findpeaks(CD+RD);
siz=[];
for i =1:200
    siz(end+1)=sum(diff(l)<=i);
end
%%
loc=l(diff(l)<=10);
%%

% DBSCAN

epsilon=90;
MinPts1=5;
IDX=DBSCAN(points,epsilon,MinPts1);
%nc(end+1)=max(IDX);
%end

%% Plot Results

PlotClusterinResult(points, IDX);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts1) ')']);


%%
plot(1:200,siz,'.-k')
hold on;
%% visual
Plt_cluster(points,order,SetOfClusters,20)
%% plots

