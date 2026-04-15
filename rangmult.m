%[text] # rangmult
%[text] The multiple comparison is carried out. Pairwise comparisons are performed using [`multcompare`](https://la.mathworks.com/help/releases/R2025b/stats/multcompare.html) with the least significant difference procedure (LSD) at the same significance level as the ANOVA.
function [c,m] = rangmult(stats,alpha,xdata,group,xindepend,ydepend,roworcolumn)
    disp('Multiple comparison test')

    if nargin<7
        roworcolumn='column';
    end
   
    figure
    [c,m]=multcompare(stats,'CriticalValueType','lsd','Alpha',alpha,'Estimate',roworcolumn);
    h=(c(1,5)-c(1,4))/2
    mm=length(xdata)

    figure
    errorbar(xdata.',m(:,1),h*ones(mm,1),'*')
    xlim([0.5 mm+0.5])
    xticks(xdata)
    xticklabels(group)
    xlabel(xindepend)
    ylabel(ydepend)
    title(['Means and ' num2str(100*(1-alpha)) '% LSD intervals'])
    grid on
end

%[appendix]{"version":"1.0"}
%---
