%[text] # blocks
%[text] Analysis of Variance (ANOVA) blocks design
function p = blocks(data,group,alpha1,alpha2,xindepend,ydepend,xord)

[~,mm]=size(data);
xdata = 1:mm;

if nargin<7
    xord=1:numel(data);
else
    [numrow,numcol]=size(xord);
    xord=xord+numcol*(0:numrow-1)';
    xord=xord.';
    xord=xord(:).';
end

disp(xord)

[p,~,stats]=anova2(data);

pValue=p(1);
pValueBlock = p(2);

if pValueBlock>alpha2
    fprintf('Fail to reject the null hypothesis at alpha2 = %.2f\n', alpha2);
    disp('Block design is not justified')         
else
    fprintf('Reject the null hypothesis at alpha2 = %.2f\n', alpha2);
    disp('Block design is justified')
    if pValue>alpha1
        fprintf('Fail to reject the null hypothesis at alpha1 = %.2f\n', alpha1);
        disp('Overall treatment effect is not significant');
    else
        fprintf('Reject the null hypothesis at alpha1 = %.2f\n', alpha1);
        disp('Overall treatment effect is significant');

        [~,~] = rangmult(stats,alpha1,xdata,group,xindepend,ydepend);

        disp('Goodness-of-fit tests')
       
        residuals=data-mean(data)-mean(data,2)+mean(data(:));
        residuals=residuals.';
        resid=residuals(:).';

        checkindependence(resid,xord)

        homoscedasticity(data,residuals,xdata,alpha1,group,xindepend,ydepend);

        normality(resid)

    end
end

    
end

%[appendix]{"version":"1.0"}
%---
