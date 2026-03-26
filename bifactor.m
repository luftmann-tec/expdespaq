function p=bifactor(A,n,xindepend1,xindepend2,ydepend,xdata1,xdata2,Aord)
%BIFACTOR Diseño experimental bifactorial
%
%   BIFACTOR Realiza una anova de un diseño bifactorial.
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
in=i/n;

%Transposición

B=transpbifactor(A,n);
[i2,j2]=size(B);

if nargin<6 || isempty(xdata1);
    xdata1=1:j;
end

if nargin<7 || isempty(xdata2);
    xdata2=1:in;
end

if nargin<8
    Aord=[];
end

%Análisis de varianza
[p,table1,stats1]=anova2(A,n);

%Prueba de Bartlett
%pbart1=vartestn(A);
%xlabel(xindepend1)
%ylabel(ydepend)

%Prueba de rangos múltiples primera variable

if p(1)<0.05
    [c1,m1]=rangmult(stats1,j,xindepend1,ydepend,xdata1);
end

%Prueba de Bartlett
%pbart2=vartestn(B);
%xlabel(xindepend2)
%ylabel(ydepend)

%Pruebas de rangos múltiples segunda variable

if p(2)<0.05
    [p2,table2,stats2]=anova2(B,n,'off');
    [c2,m2]=rangmult(stats2,j2,xindepend2,ydepend,xdata2);
end

%Análisis de interacción

%Matriz de valores medio y cálculo de residuos
for z=1:j
    for k=1:in
        C=A((k-1)*n+1:k*n,z);
        mC=mean(C);
        resid((k-1)*n+1:k*n,z)=C-mC;
        D(k,z)=mC;  %Matriz de valores medios
    end
end

residlin1=resid(:)';
resid2=transpbifactor(resid,2);
residlin2=resid2(:)';

if p(3)<0.05
    %Gráfica 1
    [f1,g1]=interactions(D,xindepend1,xindepend2,ydepend,xdata1,xdata2);
    %Gráfica 2
    [f2,g2]=interactions(D',xindepend2,xindepend1,ydepend,xdata2,xdata1);
end

%Análisis de supuestos

%Supuesto de independencia

sortedA=checkindependence(residlin1,ij,Aord); 

%Supusto de varianza constante

%Variable 1
wlin1=checkconstvar(residlin1,i,j,xindepend1,xdata1); 

%Variable 2

wlin2=checkconstvar(residlin2,i2,j2,xindepend2,xdata2); 

%supuesto de normalidad

figure
normplot(residlin1)
title('Check of normality assumption')
xlabel('Residuals')



