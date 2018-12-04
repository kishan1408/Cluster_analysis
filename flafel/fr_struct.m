function [Fr_st ts te] = fr_struct(fr,x,y,N)
%FR_STRUCT Breaks the full data into frames with constant number of points
% or full frame (whichever is greater).Inputs are X positions of all point
% ,y position of all points and fn is the frame to which the point belongs
% and N is the optimal number of points required for clustering 
% This structure has frame data in Fr_st.data and start t in Fr_st.ts end
% t in Fr_st.te and duration in Fr_st.delt . So Fr_st(1).data(:,1) gives
% x,y position of first point in frame 1
ts=[];te=[];delt=[];
i=1; % points in full data set
k1=0;
while i+1<(length(fr))
    d=1;
    k1=k1+1;%frame number
    k2=0;% points in each frame
    Fr_st(k1).ts=fr(i);ts(end+1)=fr(i);
        while ~(fr(i+1)> fr(i) && d>=N) && (i+1<(length(fr)))
         k2=k2+1;
         Fr_st(k1).datax(k2)=x(i);
         Fr_st(k1).datay(k2)=y(i);
                    
         d=d+1;
         i=i+1;
        end
   
    Fr_st(k1).te=fr(i);te(end+1)=fr(i);
    Fr_st(k1).delt=Fr_st(k1).te-Fr_st(k1).te;
    
end
end

