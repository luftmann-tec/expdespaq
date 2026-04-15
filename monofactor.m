%[text] # monofactor
%[text] Analysis of Variance (ANOVA) for one factor with complementary analysis of multiple comparison test and check of goodness-of-fit tests using using the *linear statistical model* \[1,2\]
%[text] $y\_{ij}=\\mu+\\tau\_i+\\epsilon\_{ij}$
%[text] being $y\_{ij}$ the *j*-th observation of i-th treatment. $\\mu$ is a common parameter among treatments being the global mean, $\\tau\_i$ is an unique parameter for the *i*-th treatment, also known as the treatment effect, and $\\epsilon\_{ij}$ is the random component of the error. The $\\mu\_i=\\mu+\\tau\_i$ corresponds to *i*-th mean of the *i*-th treatment.
%[text] ## Execution
function [p,tbl] = monofactor(data,group,alpha,xindepend,ydepend,xord)

if nargin<6
    xord=1:numel(data);
end

[~,mm]=size(data);
xdata = 1:mm;
%[text] ### Inputs
%[text] `data`: set of observations being each column correspoding to the *i*-th treatment.
%[text] Outputs
%[text] ## One-way ANOVA
%[text] The one-way ANOVA is permormed with [`anova1`](https://la.mathworks.com/help/releases/R2025b/stats/anova1.html). 
[p,tbl,stats]=anova1(data,group,"off");
fprintf('p-value = %.4g\n', p);
disp('To check the ANOVA Table look at the bottom.')
%[text] ## Hypotheis test
%[text] The hypotheis test is
%[text] $\\begin{cases}\nH\_0:\\mu\_1=\\mu\_2=\\ldots\\mu\_m & \\\\\nH\_1:\\mu\_i\\neq\\mu\_j & \\mathrm{for\\,at\\,least\\,one\\,pair}\\,(i,j)\n\\end{cases}$
%[text] with a significance level $\\alpha$.
if p>alpha
    fprintf('Fail to reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are no differences between treatments ' xindepend])
else
    fprintf('Reject the null hypothesis at alpha = %.2f.\n', alpha);
    disp(['There are differences between the treatments ' xindepend])
%[text] ## Multiple comparison test
%[text] If null hypothesis is rejected then there are differences between the treatments. Then the multiple comparison should be carried out. Pairwise comparisons are performed using [`multcompare`](https://la.mathworks.com/help/releases/R2025b/stats/multcompare.html) with the least significant difference procedure (LSD) at the same significance level as the ANOVA.
    [~,~] = rangmult(stats,alpha,xdata,group,xindepend,ydepend);
    
end %% for Hypotheis test
%%
%[text] ## Goodness-of-fit tests
%[text] Calculate of residuals
disp('Goodness-of-fit tests')
residuals = data - mean(data);
resid=residuals(:).';
xord=xord(:).';
%[text] ### Check of indpendence
checkindependence(resid,xord)
%[text] ### Check of Homoscedasticity
%[text] The check of homoscedasticity has the hypotheis test
%[text] $\\begin{cases}\nH\_0:\\sigma\_1=\\sigma\_2=\\ldots\\sigma\_m & \\\\\nH\_1:\\sigma\_i\\neq\\sigma\_j & \\mathrm{for\\,at\\,least\\,one\\,pair}\\,(i,j)\n\\end{cases}$
%[text] for sake of simplicity, with the same significance level $\\alpha$ of the ANOVA. Nevertheless, this is not scrictly necessary. The analysis is carried out with the [`vartestn`](https://la.mathworks.com/help/stats/vartestn.html) command with the Bartlett test.
homoscedasticity(data,residuals,xdata,alpha,group,xindepend,ydepend);
%[text] **Check of normality**
normality(resid)
%[text] ### End of Function
disp('End of function monofactor')
end % End of the function
%%
%[text] ## References
%[text] \[1\] Montgomery, D. C. (1991). *Diseño y Análisis de Experimentos* (3.a ed.). México, D.F.: Grupo Editorial Iberoamérica.
%[text] \[2\] Johnson, R. A., Miller, I., y Freund, J. (2011). *Probabilidad y Estadística para Ingenieros* (8.a ed.). Naucalpan de Juárez, Méx.: Pearson Educación.

%[appendix]{"version":"1.0"}
%---
