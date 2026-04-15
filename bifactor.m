%[text] # bifactor
%[text] Analysis of Variance (ANOVA) for one factor
function p = bifactor(data,numreplicas,group,alpha,xindepend,ydepend,xord)

if nargin<7
    xord=1:numel(data);
end

[nn,mm]=size(data);
xdatann = 1:nn/numreplicas;
xdatamm = 1:mm;

[p,tbl,stats]=anova2(data,numreplicas);

% figure
% bar(p)
% % ylim(alpha)
%[text] Pruebas de hipótesis para p-values, pruebas de rango múltiples para efectos independientes si aplica.
if p(1)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are no differences between the treatments ' xindepend{1}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are differences between the treatments ' xindepend{1}]);
    [~,~] = rangmult(stats,alpha,xdatamm,group{1},xindepend{1},ydepend);
end

if p(2)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are no differences between the treatments ' xindepend{2}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are differences between the treatments ' xindepend{2}]);
    [~,~] = rangmult(stats,alpha,xdatann,group{2},xindepend{2},ydepend,'row');
end

if p(3)>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There is no a significant interaction between the two factors ' xindepend{1} 'and ' xindepend{2}])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There is no a significant interaction between the two factors ' xindepend{1} 'and ' xindepend{2}]);
end

end
%[text] 

%[appendix]{"version":"1.0"}
%---
