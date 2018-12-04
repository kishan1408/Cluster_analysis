function Plt_cluster(data,order,strt,thr)
% input data order and cluster structre with end and start points of order
% list.


    k=length(strt);

    Colors=hsv(k);
    plot(data(:,1),data(:,2),'.c')
    hold on ;
    %Legends = {};
    for i=1:k
        st=strt(i).start+1;
        en=strt(i).end-1;
        
        idx=order(st:en);
        Xi=data(idx,:);
        if ((en-st) <= thr) && mean(std(Xi)) < 200
        Style = 'o';
        MarkerSize = 2;
        Color = Colors(i,:);
        %Legends{end+1} = ['Cluster #' num2str(i)];
         p = convhull(Xi(:,1),Xi(:,2));
        %[p1 p2]=points2contour(Xi(p,1),Xi(p,2),1,'cw')
         plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
         plot(Xi(p,1),Xi(p,2),':r');
         hold on;
         pause()
         i
        end
    end
    hold off;
    ylim([0,7000]);
    xlim([0,30000])
    
    grid on;

end



