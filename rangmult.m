function [c,m]=rangmult(stats,j,xindepend,ydepend,xdata)
%RANGMULT Prueba de rangos múltiples con gráfica estándar
%Prueba de rangos múltiples, método de la mínima diferencia signifactiva.

figure
[c,m]=multcompare(stats,'ctype','lsd');

h=(c(1,5)-c(1,4))/2;
g=xdata';

%comprobación de monotonicidad
dif=xdata(2)-xdata(1);
xx=min(xdata):dif:max(xdata);

%Gráfica personalizada

figure
errorbar(g,m(:,1),h*ones(j,1),'*')
if length(xx)==length(xdata)
    set(gca,'XTick',xdata)
end
title('Means and 95% LSD intervals')
xlabel(xindepend)
ylabel(ydepend)