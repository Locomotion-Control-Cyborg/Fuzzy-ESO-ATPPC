function[Pf,eta]=PPF(i)
%% Prescribed Performance Function
dt = .01; Tfn = 50;
Tf = 8; 
Pf_0 = 5;
Pf_infty = .1;
alpha_f = .75;
%kappa = .6;% 预设性能函参
P_f = zeros(1,Tfn/dt);
P_f(1) = Pf_0;
rho_0 = (Pf_0-Pf_infty)^(1-alpha_f)/(1-alpha_f)/Tf;
for j = 2:Tfn/dt 
    if j*dt < Tf
        P_f(j) = P_f(j-1)+ dt*(-rho_0*(abs(P_f(j-1)-Pf_infty))^alpha_f);
    else
        P_f(j) = P_f(j-1)+ dt* 0 ;
    end
end
%P_f1 = -kappa*P_f;
Pf = P_f(i);
if i*dt < Tf
    eta = -(-rho_0*(abs(P_f(i)-Pf_infty))^alpha_f)/Pf;
else
    eta = 0;
end
%P_f1 = -kappa*P_f;

% %% Plot
% t_p = linspace(0,T,length(P_f));
% plot(t_p,P_f,'r',t_p,P_f1,'b',LineWidth=1.5)
% label1 = '$\mathcal{P}_f$';
% label2 = '$-\kappa \mathcal{P}_f$';
% legend(label1,label2,'Interpreter','latex',fontsize=20)



