function[rho_i,d_i] = Rho(i,N)
dt = .01; Tfn = 50;
rho = ones(N,Tfn/dt);
d = zeros(N,Tfn/dt);
for iN = 1:N
    for ir = 1:Tfn/dt
        t  = ir*dt; % current time
        if 10<t&&t<15
            %rho(2,ir) = abs(0.3*sin(0.08*t))+0.2*(cos(0.05*iN*t))^2;
            %d(iN,ir) = .7*exp(-0.02*(t-10))*sin(0.1*pi*(t-10)+iN*pi/4);
            d(iN,ir) = .7*exp(-0.02*(t))*sin(0.1*pi*(t)+iN*pi/4);
            %rho(iN,ir) = 1.2; 
        elseif 30<t&&t<35
            %rho(iN,ir) = 0.8;
            %rho(3,ir) = -0.2*sin(0.08*t)-0.2*cos(0.05*iN*t);
            %d(iN,ir) = -.7*exp(-0.02*(t-30))*sin(0.1*pi*(t-30)+iN*pi/4);
            d(iN,ir) = -.7*exp(-0.02*(t))*sin(0.1*pi*(t)+iN*pi/4);
        else
            %d(iN,ir) = .8+.5*exp(-0.02*t)*sin(0.1*pi*t+iN*pi/4);
            d(iN,ir) = 0;
        end
    end
end

for ir = 1:Tfn/dt
    t  = ir*dt; % current time
    Td = 2; % fault time
    Amp = .8; % fault signal amp
    Omg = 2*pi/Td ; % fault signal Omg
    if 10<t&&t<10+Td %10-12s
       rho(2,ir) = -Amp * sin(.5*Omg*(t-10))*exp(-0.05*(t-10))+1;
       rho(4,ir) = Amp * sin(.5*Omg*(t-10))*exp(-0.05*(t-10))+1;
       %rho(1,ir) = 0.6;rho(2,ir) = 0.6;rho(3,ir) = 0.6;rho(4,ir) = 0.6;
    elseif 30<t&&t<30+Td %30-32s
       rho(1,ir) = -Amp * sin(.5*Omg*(t-30))*exp(-0.05*(t-30))+1;
       rho(3,ir) = Amp * sin(.5*Omg*(t-30))*exp(-0.05*(t-30))+1;
       %rho(1,ir) = 0.6;rho(2,ir) = 0.6;rho(3,ir) = 0.6;rho(4,ir) = 0.6;
    else
       rho(1,ir) = 1;rho(4,ir) = 1;rho(2,ir) = 1;rho(3,ir) = 1;
    end
end
rho_i = rho(:,i);
d_i = d(:,i);
end