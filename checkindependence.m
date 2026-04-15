%[text] # checkindependence
%[text] Check of independence of residuals.
function checkindependence(resid,xord)

disp('Check of independence')

t=length(resid);

if nargin<2
    xord=1:t;
end

figure
plot(xord,resid,'s','LineWidth',1.5)
yline(0,'LineWidth',1.5)
xlabel('Sequence or observations')
ylabel('Residuals')
xlim([0 t+1])

end

%[appendix]{"version":"1.0"}
%---
