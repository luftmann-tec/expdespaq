%[text] # bifactor
%[text] Analysis of Variance (ANOVA) for one factor
function [p,tbl] = bifactor(data,alpha,xindepend,ydepend,xord)
%[text] ## Reordenamientos
%[text] Variables de control
Var1=data.Var1;
Var2=data.Var2;
%[text] Extracción de variables independientes del esquema de arbol
Var1=Var1(~isnan(Var1)); % Solo los que no son NaN
tamano1=length(Var1);    % Número de elementos de la Variable 1
tamano2=length(Var2);    % Número de elementos de la Variable 2 (Provisional)
tamano2=tamano2/tamano1; % Número de elementos de la Variable 2 (Definitivo)
Var2=Var2(1:tamano2);    % Extracción de los elementos de la Variable 2 sin repetición
%[text] Extracción de las observaciones
data=data(:,3:end);
xord=xord(:,3:end);
data=table2array(data);
xord=table2array(xord);
[~,tamano3]=size(data);  % Número de repeticiones
data=data.';             % Columnas por pares de tratamientos
xord=xord.';
%[text] Reordenamiento 1: Variable 1 en columnas, Variable 2 en el encabezado.
data1=reordenamiento1(data,tamano1,tamano2,tamano3);
%[text] Reordenamiento 2 (A partir de Reordenamiento 1): Variable 2 en columnas, Variable 1 en el encabezado.
data2=reordenamiento2(data1,tamano1,tamano2,tamano3);
%%
%[text] ## Anova bifactorial
[p,tbl,stats]=anova2(data2,tamano3,"off");
promedios=mean(data);
%[text] Pruebas de hipótesis
xdatamm = 1:tamano1;
xdatann = 1:tamano2;

if p(1)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are no differences between the treatments ' xindepend{1}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are differences between the treatments ' xindepend{1}]);
    [~,~] = rangmult(stats,alpha,xdatamm,Var1,xindepend{1},ydepend);
end

if p(2)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are no differences between the treatments ' xindepend{2}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are differences between the treatments ' xindepend{2}]);
    [~,~] = rangmult(stats,alpha,xdatann,Var2,xindepend{2},ydepend,'row');
end

if p(3)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There is no a significant interaction between the two factors ' xindepend{1} ' and ' xindepend{2}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There is a significant interaction between the two factors ' xindepend{1} ' and ' xindepend{2}]);
    proms=reshape(promedios,[tamano2 tamano1]);
    figure
    plot(Var2,proms,'-s','MarkerFaceColor','auto');
    xlabel(xindepend{2})
    ylabel(ydepend)
    legend(string(Var1))
    grid on
end
%%
%[text] ## Verificación de Supuestos
%[text] ### Cálculo de residuos
residuals=data-promedios;
resid=residuals(:).';
xord=xord(:).';
%[text] ### Independencia de residuos
checkindependence(resid,xord)
%[text] ### Homocestaticidad
resid1=reordenamiento1(residuals,tamano1,tamano2,tamano3);
resid2=reordenamiento2(resid1,tamano1,tamano2,tamano3);

homoscedasticity(data,resid2,xdatamm,alpha,Var1,xindepend{1},ydepend);
homoscedasticity(data,resid1,xdatann,alpha,Var2,xindepend{2},ydepend);
%[text] ### Normalidad
normality(resid)
%[text] Fin de la función global
end % Fin de la función global
%%
%[text] ## Sección de Funciones de Reordenamientos
%[text] Reordenamiento 1: Variable 1 en columnas, Variable 2 en el encabezado
function data1=reordenamiento1(data,tamano1,tamano2,tamano3)
data1=zeros(tamano1*tamano3,tamano2); % Preallocation
    for i=1:tamano1
        data1((i-1)*tamano3+1:i*tamano3,:)=data(:,(i-1)*tamano2+1:i*tamano2);
    end
end
%[text] Reordenamiento de observaciones 2 (A partir de Reordenamiento 1): Variable 2 en columnas, Variable 1 en el encabezado.
function data2=reordenamiento2(data1,tamano1,tamano2,tamano3)
data2=zeros(tamano2*tamano3,tamano1); % Preallocation
    for i=1:tamano2
        for j=1:tamano1
            data2((i-1)*tamano3+1:i*tamano3,j)=data1((j-1)*tamano3+1:j*tamano3,i);
        end
    end
end
%[text] 

%[appendix]{"version":"1.0"}
%---
