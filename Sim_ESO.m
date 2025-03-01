clear
clc
close all
T = 50;
dt = .01;
Cnt = T/dt; 
z = 3;
x = [1 -2 2 1 0 0 0 0]; 
x_e = zeros(1,12);
W1_norm_plot = zeros(1,4);
W2_norm_plot = zeros(1,4);
x_array   = [];
x_e_array = [];
u_c_array = [];
u_array   = [];
x3_array  = [];
Se_array  = [];
vare_array = [];
varepi1_e_array = [];
for i = 1:Cnt
    [dot_x,dot_x_e,u_c,u,W1_norm,W2_norm,x3_mas,S_e,varepi_ul,varepi1_e] = ESO(i,dt,x,x_e);
    x = x+dt*dot_x;
    % x_array = [x_array;x];
    x_e = x_e+dt*dot_x_e;
    % x_e_array = [x_e_array;x_e];
    % u_array = [u_array;u'];
    % u_c_array = [u_c_array;u_c'];
    % W1_norm_plot = [W1_norm_plot;W1_norm'];
    % W2_norm_plot = [W2_norm_plot;W2_norm'];
    % x3_array = [x3_array;x3_mas'];
    % Se_array  = [Se_array; S_e'];
    % vare_array = [vare_array;varepi_ul'];
    % varepi1_e_array = [varepi1_e_array,varepi1_e'];
end
% save('Se8.mat','Se_array')
% 
% t_p = linspace(0,T,Cnt);
% filename = "ESO_data1.mat";
% save(filename)
% figure(1)
% plot(t_p,x_e_array(:,1),'--r',t_p,x_e_array(:,2),'-.k',t_p,x_e_array(:,3),'-c',t_p,x_e_array(:,4),':m','LineWidth',1.6)
% % ylim([-8,10])
% legend('$x_{1e}$','$x_{2e}$', '$x_{3e}$', '$x_{4e}$','Interpreter','latex','Location','northeast');
% xlabel('time/s')
% ylabel('Position tracking trajectories')
% fontname(gcf,"Times New Roman")
% set(gca,'FontSize',12)
% 
% figure(2)
% plot(t_p,x_e_array(:,5),'--r',t_p,x_e_array(:,6),'-.k',t_p,x_e_array(:,7),'-c',t_p,x_e_array(:,8),':m','LineWidth',1.6)
% % ylim([-15,15])
% legend('$v_{1e}$','$v_{2e}$', '$v_{3e}$', '$v_{4e}$','Interpreter','latex','Location','northeast');
% xlabel('time/s')
% ylabel('Velocity tracking trajectories')
% fontname(gcf,"Times New Roman")
% 
% figure(3)
% plot(t_p,x_array(:,1),t_p,x_array(:,2),t_p,x_array(:,3),t_p,x_array(:,4),'LineWidth',0.9)
% legend('$x_1$','$x_2$', '$x_3$', '$x_4$','Location','northeast','Interpreter','latex');
% xlabel('time/s')
% ylabel('Position tracking trajectories')
% fontname(gcf,"Times New Roman")
% 
% figure(4)
% plot(t_p,x_array(:,5),t_p,x_array(:,6),t_p,x_array(:,7),t_p,x_array(:,8),'LineWidth',0.9)
% legend('$V_1$', '$V_2$', '$V_3$', '$V_4$','Location','northeast','Interpreter','latex');
% xlabel('time/s')
% ylabel('Velocity tracking trajectories')
% fontname(gcf,"Times New Roman")
% %%%%%%%%%%%%误差%%%%%%%%%%%%%
% load('PFF.mat')
% 
% figure(5)
% plot(t_p,x_e_array(:,1)-x_e_array(:,1),t_p,x_e_array(:,2)-x_e_array(:,1),t_p,x_e_array(:,3)-x_e_array(:,1),t_p,x_e_array(:,4)-x_e_array(:,1),t_p,P_f,'r',t_p,P_f1,'b','LineWidth',0.9)
% % ylim([-8,10])
% label1 = '$\mathcal{P}_f$';
% label2 = '$-\kappa\mathcal{P}_f$';
% legend('$x_{1e}-x_{1e}$','$x_{2e}-x_{1e}$', '$x_{3e}-x_{1e}$', '$x_{4e}-x_{1e}$',label1,label2,'Interpreter','latex','Location','northeast');
% xlabel('time/s')
% ylabel('Position tracking errors')
% fontname(gcf,"Times New Roman")
% 
% figure(6)
% plot(t_p,x_e_array(:,5)-x_e_array(:,5),t_p,x_e_array(:,6)-x_e_array(:,5),t_p,x_e_array(:,7)-x_e_array(:,5),t_p,x_e_array(:,8)-x_e_array(:,5),t_p,z*P_f,'r',t_p,z*P_f1,'b','LineWidth',0.9)
% % ylim([-15,15])
% label3 = '$\mathcal{P}_f$';
% label4 = '$-\kappa\mathcal{P}_f$';
% legend('$v_{1e}-v_{1e}$','$v_{2e}-v_{1e}$', '$v_{3e}-v_{1e}$', '$v_{4e}-v_{1e}$',label3,label4,'Interpreter','latex','Location','northeast');
% xlabel('time/s')
% ylabel('Velocity tracking errors')
% fontname(gcf,"Times New Roman")
% 
% figure(7)
% plot(t_p,u_c_array(:,1),t_p,u_c_array(:,2),t_p,u_c_array(:,3),t_p,u_c_array(:,4),'LineWidth',0.9)
% legend('$u_{c1}$','$u_{c2}$','$u_{c3}$','$u_{c4}$','Interpreter','latex','Location','northeast')
% xlabel('time/s')
% ylabel('Control Inputs')
% fontname(gcf,"Times New Roman")
% set(gca, 'XLim', [0,50])
% set(gca, 'YLim', [-10,10])
% 
% figure(8)
% plot(t_p,u_array(:,1),t_p,u_array(:,2),t_p,u_array(:,3),t_p,u_array(:,4),'LineWidth',0.9)
% legend('$u_{1}$','$u_{2}$','$u_{3}$','$u_{4}$','Interpreter','latex','Location','northeast')
% xlabel('time/s')
% ylabel('Control Outputs')
% fontname(gcf,"Times New Roman")
% set(gca, 'XLim', [0,50])
% set(gca, 'YLim', [-10,10])
% 
% figure(9)
% subplot(2,2,1)
% plot(t_p,x_array(:,1),t_p,x_e_array(:,1),'LineWidth',0.9)
% legend('$x_1$', '$x_{1p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,2)
% plot(t_p,x_array(:,2),t_p,x_e_array(:,2),'LineWidth',0.9)
% legend('$x_2$', '$x_{2p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,3)
% plot(t_p,x_array(:,3),t_p,x_e_array(:,3),'LineWidth',0.9)
% legend('$x_3$', '$x_{3p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,4)
% plot(t_p,x_array(:,4),t_p,x_e_array(:,4),'LineWidth',0.9)
% legend('$x_4$', '$x_{4p}$','Location','northeast','Interpreter','latex');
% fontname(gcf,"Times New Roman")
% 
% figure(10)
% subplot(2,2,1)
% plot(t_p,x_array(:,5),t_p,x_e_array(:,5),'LineWidth',0.9)
% legend('$V_{x1}$', '$V_{x1p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,2)
% plot(t_p,x_array(:,6),t_p,x_e_array(:,6),'LineWidth',0.9)
% legend('$V_{x2}$', '$V_{x2p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,3)
% plot(t_p,x_array(:,7),t_p,x_e_array(:,7),'LineWidth',0.9)
% legend('$V_{x3}$', '$V_{x3p}$','Location','northeast','Interpreter','latex');
% subplot(2,2,4)
% plot(t_p,x_array(:,8),t_p,x_e_array(:,8),'LineWidth',0.9)  
% legend('$V_{x4}$', '$V_{x4p}$','Location','northeast','Interpreter','latex');
% fontname(gcf,"Times New Roman")
% 
% figure(11)
% plot(t_p,x3_array(:,1),t_p,x_e_array(:,9),t_p,x3_array(:,2),t_p,x_e_array(:,10),t_p,x3_array(:,3),t_p,x_e_array(:,11),t_p,x3_array(:,4),t_p,x_e_array(:,12),'LineWidth',0.9)
% legend('$x_{1,3}$','$x_{p1,3}$','$x_{2,3}$','$x_{p2,3}$','$x_{3,3}$','$x_{p3,3}$','$x_{4,3}$','$x_{p4,3}$','Interpreter','latex','Location','northeast')
% fontname(gcf,"Times New Roman")
% 
% figure(12)
% fontname(gcf,"Times New Roman")
% subplot(2,4,1)
% plot(t_p,x3_array(:,1),t_p,x_e_array(:,9),'LineWidth',0.9)
% legend('$x_{1,3}$','$x_{p1,3}$','Interpreter','latex','Location','northeast');
% subplot(2,4,2)
% plot(t_p,x3_array(:,1)-x_e_array(:,9),'LineWidth',0.9)
% legend('$e_{1,3}$','Interpreter','latex','Location','northeast');
% 
% subplot(2,4,3)
% plot(t_p,x3_array(:,2),t_p,x_e_array(:,10),'LineWidth',0.9)
% legend('$x_{2,3}$','$x_{p2,3}$','Interpreter','latex','Location','northeast');
% subplot(2,4,4)
% plot(t_p,x3_array(:,2)-x_e_array(:,10),'LineWidth',0.9)
% legend('$e_{2,3}$','Interpreter','latex','Location','northeast');
% 
% subplot(2,4,5)
% plot(t_p,x3_array(:,3),t_p,x_e_array(:,11),'LineWidth',0.9)
% legend('$x_{3,3}$','$x_{p3,3}$','Interpreter','latex','Location','northeast');
% subplot(2,4,6)
% plot(t_p,x3_array(:,3)-x_e_array(:,11),'LineWidth',0.9)
% legend('$e_{3,3}$','Interpreter','latex','Location','northeast');
% 
% subplot(2,4,7)
% plot(t_p,x3_array(:,4),t_p,x_e_array(:,12),'LineWidth',0.9)
% legend('$x_{4,3}$','$x_{p4,3}$','Interpreter','latex','Location','northeast');
% subplot(2,4,8)
% plot(t_p,x3_array(:,4)-x_e_array(:,12),'LineWidth',0.9)
% legend('$e_{4,3}$','Interpreter','latex','Location','northeast');
% 
% fontname(gcf,"Times New Roman")
% 
% figure(13)
% plot(t_p,W1_norm_plot(2:5001,1),t_p,W1_norm_plot(2:5001,2),t_p,W1_norm_plot(2:5001,3),t_p,W1_norm_plot(2:5001,4),'LineWidth',0.9)
% legend('$W_{1,1}$','$W_{2,1}$','$W_{3,1}$','$W_{4,1}$','Interpreter','latex','Location','northeast');
% ax = gca();
% ax.YRuler.Exponent = -2;
% figure(14)
% plot(t_p,W2_norm_plot(2:5001,1),t_p,W2_norm_plot(2:5001,2),t_p,W2_norm_plot(2:5001,3),t_p,W2_norm_plot(2:5001,4),'LineWidth',0.9)
% legend('$W_{1,2}$','$W_{2,2}$','$W_{3,2}$','$W_{4,2}$','Interpreter','latex','Location','northeast');
% ax = gca();
% ax.YRuler.Exponent = -2;
% 
% figure(15)
% plot(t_p,x_array(:,1)-x_array(:,1),t_p,x_array(:,2)-x_array(:,1),t_p,x_array(:,3)-x_array(:,1),t_p,x_array(:,4)-x_array(:,1),'LineWidth',0.9)
% legend('$x_1$-$x_1$','$x_2$-$x_1$', '$x_3$-$x_1$', '$x_4$-$x_1$','Location','northeast','Interpreter','latex');
% xlabel('time/s')
% ylabel('Position tracking errors')
% fontname(gcf,"Times New Roman")
% 
% figure(16)
% plot(t_p,x_array(:,5)-x_array(:,5),t_p,x_array(:,6)-x_array(:,5),t_p,x_array(:,7)-x_array(:,5),t_p,x_array(:,8)-x_array(:,5),'LineWidth',0.9)
% legend('$V_1$-$V_1$', '$V_2$-$V_1$', '$V_3$-$V_1$', '$V_4$-$V_1$','Location','northeast','Interpreter','latex');
% xlabel('time/s')
% ylabel('Velocity tracking errors')
% fontname(gcf,"Times New Roman")