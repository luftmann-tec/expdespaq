function [f,g]=interactions(D,xindependA,xindependB,ydepend,xdataA,xdataB)
%INTERACTIONS Análisis de interacción Anova
%   Dr. Rodolfo Salazar Peña
%   Revisado: 30/Mar/2018

[f,g]=size(D);

figure
hold
if f==2
    plot(xdataA,D(1,:),'-bs',xdataA,D(2,:),'-go')
    legend(num2str(xdataB(1)),num2str(xdataB(2)))
elseif f==3
    plot(xdataA,D(1,:),'-bs',xdataA,D(2,:),'-go',xdataA,D(3,:),'-xr')
    legend(num2str(xdataB(1)),num2str(xdataB(2)),num2str(xdataB(3)))
elseif f==4
    plot(xdataA,D(1,:),'-bs',xdataA,D(2,:),'-go',xdataA,D(3,:),'-xr',...
        xdataA,D(4,:),'-c+')
    legend(num2str(xdataB(1)),num2str(xdataB(2)),num2str(xdataB(3)),...
        num2str(xdataB(4)))
elseif f==5
    plot(xdataA,D(1,:),'-bs',xdataA,D(2,:),'-go',xdataA,D(3,:),'-xr',...
        xdataA,D(4,:),'-c+',xdataA,D(5,:),'-kv')
    legend(num2str(xdataB(1)),num2str(xdataB(2)),num2str(xdataB(3)),...
        num2str(xdataB(4)),num2str(xdataB(5)))
end
xlim([min(xdataA) max(xdataA)])
set(gca,'XTick',xdataA)
title(['Parametric variable: ' xindependB])
xlabel(xindependA)
ylabel(ydepend)
hold
