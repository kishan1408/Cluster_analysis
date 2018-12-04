clearvars -except threshold400
data=threshold400;
d=data;
[q,a,z] = unique(d(:,1));
grt=struct;

%%
nn=1000;% number of  frames
Nthres=400; %  rmax
dr=20;
t=200; % actual t = t'*4 ms
nf=40; % frames to merge

if nf >=t
    nf=t-1;
end
%%

for i =1:nn
  f1=d(a(i):a(i+nf)-1,[2,3]) ;
  f2=d(a(i+t):a(i+nf+t+1)-1,[2,3]) ;
  dd=dist([f1' f2']);
  [N,X]=hist(reshape(dd(length(f1)+1:end,1:length(f1)),length(f1)*length(f2),1),1:dr:Nthres+dr);
  N(end)=[];X(end)=[];N=N./(2*pi*X*dr);N=N/((length(N)*(length(N)-1))^0.5);
  
  grt(i).Val=N;
  grt(i).r=X;
  i
end
 
mat=zeros(length(grt),length(N));
for i =1:length(grt)
mat(i,:)=(grt(i).Val)';
end
%%
%figure
% colormap hsv
  %force it to interpolate at every 10th pixel
  
hold on
plot(X,sum(mat)/nn,'.r')
grid on
grid minor


% surf(mat);
% shading interp

% daspect([5 5 1])
% axis tight
% view(-50,30)
% camlight left
