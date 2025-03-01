function [dot_x,dot_x_e,u_c,u,W1_norm,W2_norm,x3_mas,S_e,varepi_ul,varepi1_e] = ESO(i,dt,x,x_e)
%% Sys Settings
N = 4;                                      % 智能体个数
%A = [0 0 0 0;
%     1 0 0 0;
%     0 1 0 0;
%     0 1 0 0]; % a i,k
A = [0 0 0 0;
     1 0 0 0;
     0 0 0 1;
     0 1 0 0];
B = diag([1 0 0 0]);                    % 领导者
D = diag([0 1 1 1]);                    % 度矩阵
H = D - A + B;
I1 = ones(N,1);
b = 2;
tau1 = 80;tau2 = 80;
%% Ref Signal
   om_x0 = .6;
   x00 = 1*sin(om_x0*i*dt);
   x01 = om_x0*cos(om_x0*i*dt);
   x02 = -om_x0*om_x0*sin(om_x0*i*dt); 
%% MASs
   x1_mas = x(1:N);
   x2_mas = x(1+N:2*N);
   %x3_mas = x(2*N+1:3*N);                   % x3代表未知部分
%% Extended Observer
   x1_obv = x_e(1:N);
   x2_obv = x_e(1+N:2*N);
   x3_obv = x_e(2*N+1:3*N);
%% Sliding Manifold
   alpha = 5;delta = 0.6;                   % 参数

   varepi1_e = H*(x1_obv'-kron(I1,x00));    % 位移跟随误差
   varepi2_e = H*(x2_obv'-kron(I1,x01));    % 速度跟随误差

   S_e = alpha*varepi1_e+varepi2_e;         % 滑模面
   [Pf,eta]=PPF(i);                         % 调用PPF函数
   S_e_N = S_e./Pf;                         % 归一化
   varepi_ul = log((abs(delta+S_e_N))-log(abs(delta*(I1-S_e_N)))); %S_e_N(0)>0 
  %varepi_ul = log((abs(delta+delta*S_e_N))/(delta-S_e_N)); %S_e_N(0)<0 
%% Neutral Network
   ci = [-10,-6,-2,2,6,10];
   c  = kron(ones(N,1),ci);     % Centers
   %sigma = .01;                % Width
   
   lambda1 = 20;lambda2 = 240;  % Adaptive law parameters
   varsigma = zeros(N,6);       % Hidden layer output

   f_e_1 = zeros(N,1);          %esti of f1
   f_e_2 = zeros(N,1);          %esti of f2

   W1 = zeros(N,6);             % 初值
   W1_1 = W1;                   %(i-1)时刻权值
   W1_2 = W1_1;                 %(i-2)时刻权值
   d_W1 = zeros(N,6);           % 增量

   W2 = zeros(N,6);             % 初值
   W2_1 = W2;                   %(i-1)时刻权值
   W2_2 = W2_1;                 %(i-2)时刻权值
   d_W2 = zeros(N,6);           % 增量
    
   for i_w = 1:N
       for j = 1:6
          varsigma(i_w,j) =  exp(-norm(x1_obv(i_w)-c(i_w,j)))^2/2^(2*1^2);
       end
   end

   for i_w =1:N
       d_W1(i_w,:) = (x1_mas(i_w)-x1_obv(i_w))*1*varsigma(i_w,:)-lambda1*W1(i_w,:);
       d_W2(i_w,:) = (x1_mas(i_w)-x1_obv(i_w))*1*varsigma(i_w,:)-lambda2*W2(i_w,:);
   end

   W1t = W1;
   W1 = W1t+d_W1+0.1*(W1_1-W1_2);
   W2t = W2;
   W2 = W2t+d_W2+0.1*(W2_1-W2_2);

   W1_norm = zeros(N,1);
   W2_norm = zeros(N,1);
   for i_w =1:N
        W1_norm(i_w) = norm(W1(i_w,:));
        W2_norm(i_w) = norm(W2(i_w,:));
   end
   
   for i_w = 1:N
       f_e_1(i_w) = W1(i_w,:)*varsigma(i_w,:)';
       f_e_2(i_w) = W2(i_w,:)*varsigma(i_w,:)';
   end

%% Actural Controller
   u1 =zeros(N,1);
   u2 =zeros(N,1);
   u  =zeros(N,1);
   % k1=5; k2 =80; k3 = 50;
    k1=5; k2 =55; k3 = 45;
   % k1=25; k2 =95; k3 = 40;
   % k1=5; k2 =75; k3 = 40;
   % k1=5; k2 =250; k3 = 80;
   Gamma = 5;
   e1 = (x1_mas-x1_obv)';
   invH = inv(H);
   for i_u = 1:N
       %u1(i_u) = -0.5*alpha*norm(W1(i_u,:))^2*norm(varsigma(i_u,:))^2;
       %u2(i_u) = -0.5*norm(W2(i_u,:))^2*norm(varsigma(i_u,:))^2;
       u1(i_u) = -alpha*varepi_ul(i_u)*norm(W1(i_u,:))^2*norm(varsigma(i_u,:))^2/tau1;
       u2(i_u) = -varepi_ul(i_u)*norm(W2(i_u,:))^2*norm(varsigma(i_u,:))^2/tau2;
   end
       %u3 = -invH*(alpha*varepi2_e+eta*S_e)-(alpha*k1*e1+k2*e1+x3_obv'-kron(I1,x02))-(alpha+1)/2 * varepi_ul-Gamma*invH *varepi_ul;
        u3 = -invH*(alpha*varepi2_e+eta*S_e)-(alpha*k1*e1+k2*e1+x3_obv'-kron(I1,x02))-Gamma*invH *varepi_ul;
       u_c = 1/b*(u1+u2+u3);
%% Actuator Fault
   [rho_i,d_i] = Rho(i,N); % 调用故障生成函数
   for i_af =1:N
       u(i_af) = rho_i(i_af)*u_c(i_af) + d_i(i_af);
   end
%% MASs Dynamics
   d_x1_mas = x2_mas+.15*sin(x1_mas+x2_mas);
   d_x2_mas = b*u'+ .20*cos(x1_mas-x2_mas);
   x3_mas = zeros(N,1);
   for id =1:N
       x3_mas(id) = b*(rho_i(id)-1)*u_c(id)+b*d_i(id);
   end
%% OBVs Dynamics
   d_x1_obv = x2_obv+f_e_1'+k1*e1';
   d_x2_obv = b*u_c' +f_e_2'+x3_obv+k2*e1';
   d_x3_obv = k3*e1';
%% Mux
   dot_x   = [d_x1_mas d_x2_mas];
   dot_x_e = [d_x1_obv d_x2_obv d_x3_obv];
end