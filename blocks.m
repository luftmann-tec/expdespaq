function p=blocks(A,xindepend,ydepend,xdata,Aord)
%BLOCKS Diseño experimental unifactorial por bloques
%
%   BLOCKS Realiza una anova de un diseño unifactorial por bloques
%
%   Se presenta:
%
%   1. Los p-value del ANOVA variable independiente y bloqueada (Reporte y
%   gráfica de cajas).
%   2. Prueba de Rango múltiples (Gráfica interactiva y de reporte).
%   3. Verificación de supuestos: Residuos vs. Experimentos.
%   4. Verificación de supuestos: Residuos vs. Niveles de la variable
%   independiente.
%   5. Ajuste de residuos a la distribución normal.

%   Ing. Rodolfo Salazar Peña M. en C.
%   Revisado: 11/Mar/2011

%Dimensiones de la matriz de datos
[i,j]=size(A);
ij=i*j;

if nargin<4 || isempty(xdata);
    xdata=1:j;
end

if nargin<5
    Aord=[];
end

%Análisis de varianza
[p,table,stats]=anova2(A);

stats

%Justificación del bloqueo

if p(2)>0.05
    disp('Blockade is not justified. The data is changed to unifactorial analysis')
    p=unifactor(A,xindepend,ydepend,xdata,Aord);
    return
end

%Prueba de Bartlett
%pbartlett=vartestn(A);
%xlabel(xindepend)
%ylabel(ydepend)

%%Prueba de rangos múltiples, método de la mínima diferencia signifactiva.

if p(1)<0.05
    [c,m]=rangmult(stats,j,xindepend,ydepend,xdata);
end

%Cálculo de residuos

%Cálculo de residuos
v=mean(A');
Alin=reshape(A,1,ij);
mAlin=mean(Alin);
resid=A-ones(i,j)*diag(m(:,1))-diag(v)*ones(i,j)+mAlin;
residlin=resid(:)';

%Análisis de supuestos

%Supuesto de independencia

sortedA=checkindependence(residlin,ij,Aord); 

%Supusto de varianza constante

wlin=checkconstvar(residlin,i,j,xindepend,xdata);

%supuesto de normalidad

figure
normplot(residlin)
title('Check of normality assumption')
xlabel('Residuals')