function wlin=checkconstvar(residlin,i,j,xindepend,xdata,xxdata)
%CHECKCONSTVAR Revisión de varianza constante.

%Supuesto de varianza constante

if nargin<6
    xxdata=xdata;
end

w=ones(i,j)*diag(xxdata);
wlin=w(:)';

%comprobación de monotonicidad
dif=xdata(2)-xdata(1);
xx=min(xdata):dif:max(xdata);

figure
plot(wlin,residlin,'s')
if length(xdata)>2
    rango=0.1*(xxdata(j)-xxdata(1));
    axis([xxdata(1)-rango xxdata(j)+rango -1 1])
    line([xxdata(1)-rango/2 xxdata(j)+rango/2],[0 0],'Color','r')
else
    axis([xxdata(1)-dif xxdata(j)+dif -1 1])
    line([xxdata(1)-dif*0.9 xxdata(j)+dif*0.9],[0 0],'Color','r')
end
axis 'auto y'
if length(xx)==length(xdata)
    set(gca,'XTick',xdata)
end
title('Check of constant variance assumption')
xlabel(xindepend)
ylabel('Residuals')