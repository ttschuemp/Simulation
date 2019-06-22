% european style option
clear

S0 = 100; 
E = 1000;                       % number of samples
m = 250;                        % number of subintervals per year; 250 every trading day 
T = 1;                          % time to expiration in years, one day 1/250 to maturity 


% distribution of returns
nu = .1;
sigma = .25; 
dt = 1/m;                       % length of a subperiod 
T = ceil(m * Ty);

% Computation 

% simulation of return
r = randn(T,E) * sigma*sqrt(dt) + (nu-sigma^2/2)*dt;  %each column different stock or simulation and each row different time

% future price 
ST = S0 .* exp(cumsum(r,1) );
                                                        
plot(ST)
hold on                                                     


S0 = 100; % current price
K = 100;  % strike of option
vola = 0.25; % stock volatility
E = 10000; 

InnerValue = @(ST) max(ST-K, 0); 


rF = log(1.05);  
                                               
%% computations       

rT = randn(1,E) * vola * sqrt(T) + (rF - vola^2/2)*T;                 
ST = S0 * exp(rT);                                                     

% call option 
c_T = InnerValue(ST); % Options payoff at maturity 
E_c_T = mean(c_T); % Options expected payoff %E(c_T)

%plot(ST, c_T, '.')


c_0 = E_c_T * exp(-rF*T); 


