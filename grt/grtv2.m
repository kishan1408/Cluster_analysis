clearvars -except threshold400
data=threshold400;
d=data;
[q,a,z] = unique(d(:,1));
grt=struct;

col=hsv(length(5:5:100));
cc=1;
tic
mat2=zeros(length(col),20);
for jj=10:5:100
%%
nn=500;% number of  frames
rmax=200; %  rmax
dr=5;
t=jj; % actual t = t'*4 ms
nf=10; % frames to merge

if nf >=t
    nf=t-1;
end
%%

for i =1:nn
  f1=d(a(i):a(i+nf)-1,[2,3]) ;
  f2=d(a(i+t):a(i+nf+t+1)-1,[2,3]) ;
  dd=dist([f1' f2']);
  [N,X]=hist(reshape(dd(length(f1)+1:end,1:length(f1)),length(f1)*length(f2),1),1:dr:rmax+dr);
  N(end)=[];X(end)=[];N=N./(2*pi*X*dr);N=N/((length(N)*(length(N)-1))^0.5);
  
  grt(i).Val=N;
  grt(i).r=X;
  
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
plot(X,sum(mat)/nn,'.','Color',col(cc,:))
grid on
grid minor
xdata1=X;
ydata1=sum(mat)/nn;
xplot1 = linspace(0,rmax);
% Find coefficients for spline interpolant
fitResults1 = spline(xdata1, ydata1);
% Evaluate piecewise polynomial
yplot1 = ppval(fitResults1, xplot1);
% Plot the fit
fitLine1 = plot(xplot1,yplot1,'Color',col(cc,:));
mat2(cc,:)=ydata1';
cc=cc+1;
jj
toc;

end
Contour(mat2,20)
% surf(mat);
% shading interp

% daspect([5 5 1])
% axis tight
% view(-50,30)
% camlight left
