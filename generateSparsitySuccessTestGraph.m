function Fig1Graph=generateSparsitySuccessTestGraph(ROWS, COLS, MAT_TYPE, SPARSITY_LIST, LOW_K, UPP_K, ITER)
%Sparsity list must be of length 3 for the moment. I'm working on it...
if size(SPARSITY_LIST,2)==3
    Sp=sparsitySuccessTest(ROWS, COLS, MAT_TYPE, SPARSITY_LIST, LOW_K, UPP_K, ITER);
    fid=fopen('sparsitySuccessTestGraphData.txt','w');
    fprintf(fid,'%d %d %d \n',Sp);
    fclose(fid);

    Sp=Sp*(100/ITER) % Do I need to transpose? No - because I'm not reading it in.
    A=LOW_K:UPP_K;
    B1=Sp(:,1);
    C2=Sp(:,2);
    D3=Sp(:,3);
% These also need to be adjusted to hold different sparsities.

    rect=[100,50,80,50];
    figure; hold on; plot(A,B1,'r'),plot(A,C2,'b'),plot(A,D3,'k'); hold off;
    hline=findobj(gcf,'type','line');
    set(hline,'LineWidth',3);
    set(hline(2),'LineStyle',':');
    set(hline(3),'LineStyle','-.');
    set(gca,'fontsize',14);
    axis([LOW_K,UPP_K,0,110]); % This can be varied to suit scale/size. [xmin,ymin,xmax,ymax]
    xlabel('Sparsity of signal vector','FontSize',16);
    ylabel('% of signal vectors recovered','FontSize',16);
    legend('\delta=firstSparsity','\delta=secondSparsity','\delta=thirdSparsity','Position',rect); %These also need fixing. I'll get there...
else
    display('Sorry - the size of your SPARSITY_LIST must be exactly 3... for now...');
end
end
