function [p,pbartlett]=unifactor(A,xindepend,ydepend,xdata,Aord)
%UNIFACTOR Diseño experimental unifactorial
%
%   UNIFACTOR Realiza una análisis estadístico de un diseño unifactorial
%
%   Se presenta:
%
%   1. El p-value del ANOVA (Reporte tabla y gráfica de cajas).
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
[p,table,stats]=anova1(A);

%Prueba de Bartlett
pbartlett=vartestn(A);
xlabel(xindepend)
ylabel(ydepend)

%%Prueba de rangos múltiples, método de la mínima diferencia signifactiva.

if p<0.05
    [c,m]=rangmult(stats,j,xindepend,ydepend,xdata);
end

%Cálculo de residuos

resid=A-ones(i,j)*diag(m(:,1));
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

