function sortedA=checkindependence(residlin,ij,Aord)
%CHECKINDEPENDENCE Revisión del supuesto de independencia para Anovas

%Ordenación según corridas experimentales

if isempty(Aord)
    sortedA=residlin;
else
    Aordlin=reshape(Aord,1,ij);
    B=[Aordlin; residlin];
    Bnew=sortpar(B);
    sortedA=Bnew(2,:);
end

q=1:ij;

figure
plot(q,sortedA,'s')
line([1 ij],[0 0],'Color','r')
axis([0 ij+1 -1 1])
axis 'auto y'
title('Check of independence assumption')
xlabel('Experimental Running')
ylabel('Residuals')