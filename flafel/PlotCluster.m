
function R=PlotCluster(X,IDX,y1,y2,x1,x2)

    k=max(IDX);
    R=struct();
    Colors=lines(k);
    figure('Color',[0.8 0.8 0.8]);
    plot(X(:,1),X(:,2),'.r')
    set(gca,'Color',[0 0 0]);
    hold on ;
    Legends = {};
    
    for i=0:k
        Xi=X(IDX==i,:);
        if i~=0
            Style = 'o';
            MarkerSize = 3;
            Color =  Colors(i,:);
            
           % Legends{end+1} = ['Cluster #' num2str(i)];
           R(k).cluster=Xi;
        else
            Style = '.';
            MarkerSize = 1;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
                 R(1).noise=Xi;
            end
        end
        if ~isempty(Xi) && length(Xi)>2
             
           %[p1 p2]=points2contour(Xi(p,1),Xi(p,2),1,'cw')
            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
            p = convhull(Xi(:,1),Xi(:,2)); 
            plot(Xi(p,1),Xi(p,2),':g','MarkerSize',3);
           % pause();
        end
        hold on;
    end
    hold off;
       ylim([y1,y2]);
       xlim([x1,x2]);
    
    grid on;
    

end