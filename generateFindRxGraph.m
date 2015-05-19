function Fig2Graph=generateFindRxGraph(ROWS, COLS, MAT_TYPE, DENSITY_LIST,ITERS_LIST,X)
BigList=[];
for j=['L','O','C']
    % Addresses all 3 algorithms - can be removed as necessary
    SmallList=[];
    for i=[DENSITY_LIST]
        A=findRx(ROWS,COLS,MAT_TYPE,ITERS_LIST,X,i,j);
        SmallList=[SmallList;A];
    end
    BigList=[BigList,SmallList];
end

fid=fopen('FindRxGraphData.txt','w');
fprintf(fid,'%d %d %d \n', BigList);
fclose(fid);

D=DENSITY_LIST;
L=BigList(:,1);
O=BigList(:,2);
C=BigList(:,3);

    rect=[100,50,80,50];
    figure; hold on; plot(D,L,'b'),plot(D,O,'k'),plot(D,C,'r'); hold off;
    hline=findobj(gcf,'type','line');
    set(hline,'LineWidth',3);
    set(hline(1),'LineStyle','-.');
    set(hline(3),'LineStyle',':');
    set(gca,'fontsize',14);
    set(gca,'xdir','reverse')
    xlabel('Density of matrix','FontSize',16);
    ylabel('R0.98','FontSize',16);
    legend('\delta=Linprog','\delta=OMP','\delta=CoSaMP','Position',rect);
end
