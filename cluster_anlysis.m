%% 
clear all;
close all;
pause(3);
addpath('../flafel');
%%
%-------------------- file load --------------------------------

filename = uigetfile({'*.*'},'Select Data file ');
pause(0.3)
delimiter = '\t';
startRow = 17;
formatSpec = '%*s%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'ReturnOnError', false);
fclose(fileID);
threshold400 = [dataArray{1:end-1}];
f_name=strcat(filename([1:length(filename)-4]),'_Results');
clearvars  delimiter startRow formatSpec fileID dataArray ans;
mkdir(f_name) % make folder to store results
cd(f_name);
pause(1);
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
    
    saveas(h,'Points_frames','tiff');
   pause(1) 
  close(figure(1));
  
  

%% Frame structure based on N (Number of points)
   N=5000;
   [FF,ts,te]=fr_struct(timefr,pos(:,1),pos(:,2),N);
   pause(4);
   plot(tfr*(te-ts),'.-r')
   title('FrameRate'); xlabel('Frame number'); ylabel('time (s)');
    saveas(figure(1),'frame_rate','tiff');
   pause(1)
    close(figure(1));

%%

% DBSCAN
    epsilon=50+100000/N;
    MinPts1=5;
 parpool  
 pause(4)
 parfor i= 1:length(FF)
    points=[FF(i).datax',FF(i).datay'];
    IDX=DBSCAN(points,epsilon,MinPts1);
    C1(i).idx=IDX;
    C1(i).num=max(IDX);
    i
 end
delete(gcp)

%% Plot Results

for i =1:length(FF)
    points=[FF(i).datax',FF(i).datay'];
    C2(i).N=PlotCluster(points,C1(i).idx,0,5000,25000,30000);
    title([' Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts1) ', t = ' num2str(tfr*FF(i).ts) 's)']);
    name=strcat('frame',sprintf('00%d',i),'_',sprintf('%d',FF(i).ts));
    fig = gcf;
    fig.InvertHardcopy = 'off';
    print(figure(1),name,'-dpng','-r150');
    pause(1);
    close(figure(1));
end

%%
save all;

%% 

%% 

cd ..
