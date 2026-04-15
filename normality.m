%[text] # normality
%[text] Check of normal distribution of residuals.
function normality(resid)
disp('Check of normality')
figure
subplot(1,2,1)
normplot(resid)
xlabel('Residuals')
subplot(1,2,2)
histogram(resid, 'Normalization', 'pdf')
hold on
x = linspace(min(resid), max(resid), 100);
pd = fitdist(resid', 'Normal');
y = pdf(pd, x);
plot(x, y, 'r-', 'LineWidth', 1.5)
ylabel('Probability Density')
title('Normality Check of Residuals')
fig=gcf;
fig.Position(3)=1120;
hold off
end

%[appendix]{"version":"1.0"}
%---
