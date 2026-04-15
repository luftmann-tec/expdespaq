%[text] # homoscedasticity
%[text] The check of homoscedasticity has the hypotheis test
%[text] $\\begin{cases}\nH\_0:\\sigma\_1=\\sigma\_2=\\ldots\\sigma\_m & \\\\\nH\_1:\\sigma\_i\\neq\\sigma\_j & \\mathrm{for\\,at\\,least\\,one\\,pair}\\,(i,j)\n\\end{cases}$
%[text] for sake of simplicity, with the same significance level $\\alpha$ of the ANOVA. Nevertheless, this is not scrictly necessary. The analysis is carried out with the [`vartestn`](https://la.mathworks.com/help/stats/vartestn.html) command with the Bartlett test.
function pbartlett = homoscedasticity(data,residuals,xdata,alpha,group,xindepend,ydepend)

disp('Check of Homoscedasticity')
mm=length(xdata);

figure
plot(xdata,residuals,'bs','LineWidth',1.5)
yline(0,'LineWidth',1.5)
xlim([0.5 mm+0.5])
xticks(xdata)
xticklabels(group)
xlabel(xindepend)
ylabel('Residuals')

pbartlett=vartestn(data,'Display','off');
set(gca, 'XTick', xdata, 'XTickLabel', group)
xlabel(xindepend)
ylabel(ydepend)

if pbartlett>alpha
    fprintf('The p-value of Bartlett test = %.4f which is greater than alpha = %.4f.\n', pbartlett, alpha);    
    fprintf('The assumption of homoscedasticity is satisfied.\n');
else
    fprintf('The p-value of Bartlett test = %.4f which is equal or smaller than alpha = %.4f.\n', pbartlett, alpha); 
    fprintf('The assumption of homoscedasticity is not satisfied.\n');
end

end

%[appendix]{"version":"1.0"}
%---
