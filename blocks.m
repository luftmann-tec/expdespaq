%[text] # blocks
%[text] Analysis of Variance (ANOVA) blocks design
function [p,tbl] = blocks(data,group,alpha1,alpha2,xindepend,ydepend,xord)

arguments (Input)
    data table
    group cell
    alpha1 double
    alpha2 double
    xindepend 
    ydepend
    xord table
end

arguments (Output)
    p double
    tbl table
end

data=table2array(data);

[~,mm]=size(data);
xdata = 1:mm;

if nargin<7
    xord=1:numel(data);
else
    xord=table2array(xord);
    [numrow,numcol]=size(xord);
    xord=xord+numcol*(0:numrow-1)';
    xord=xord.';
    xord=xord(:).';
end

[p,tbl,stats]=anova2(data,1,"off");

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

        disp('Multiple comparison test')
        [~,~] = rangmult(stats,alpha1,xdata,group,xindepend,ydepend);

        disp('Goodness-of-fit tests')
       
        residuals=data+mean(data(:))-mean(data)-mean(data,2);
        residuals=residuals.';
        resid=residuals(:).';

        disp('1. Check of indpendence')
        checkindependence(resid,xord)

        disp('2. Check of Homogeneous Variance (Homoscedasticity)')
        homoscedasticity(data,residuals,xdata,alpha1,group,xindepend,ydepend);

        disp('3. Check of of Normality')
        normality(resid)

    end
end

disp('End of function blocks')    
end

%[appendix]{"version":"1.0"}
%---
