m  = 70;
l0 =  1;
g  = 9.81;
k = 20000; %N/m
alpha0 = 68*pi/180; %rad 

x0=0;
dy0 = 0; %m/s

% For this model we assume that energy is conserved, so we can compute the
% corresponding forward velocity given the other parameters.
Esys = 1/2*m*5^2 + m*g*1;

% y0=1.5;
% dx0 = 5; % m/s

% y0min limited by angle of flight stance
y0min = l0*sin(alpha0);

% y0max limited by energy in system
y0max = Esys/(m*g);

% Generate 11 equally spaced values in the range of y0min and y0max. 
v_y0 = linspace(y0min, y0max, 101);
v_dx0 = sqrt(2/m*(Esys-m*g*v_y0)); % m/s

v_y1 = NaN*v_y0;

for state = 1:length(v_y0)
    y0 = v_y0(state);
    dx0 = sqrt(2/m*(Esys-m*g*y0)); % m/s

    sim('SMM_apex_noAnim');
    
    v_y1(state) = simout_y1;
end

% tradeoff (inverse relationship) between forward velocity and apex height. starts to jump
% backwards because of the angle of attack. 

%%
figure
hold on;
plot(v_y0, v_y0, 'k-')
plot(v_y0, v_y1, 'r-')