%% simulation of complex systems (schelling?s segregation model)
clear
N = 1500; 
k = 2;      % groups
vis = .05;   % neighborhood
periods = 20;
prob_mut = .05; 

draw_every = 1; 

%% initialize 

% position on grid 
sN = ceil(sqrt(N));
N = sN^2;
p = (1:sN) * (1/sN) - (.5/sN); % offset by 1/2
[p1, p2] = meshgrid(p);  
pos = [p1(:), p2(:)];

% inital state 
state = ceil(rand(N,1)*k); % random states for start

% ajacency matrix 
D = squareform(pdist(pos)); % distance matrix
A = D < vis; 

show_result(state, pos);

%% over time

for t = 1:periods
    % check similarity 
    nbh = check_states(state, A, k); 
    [~, bg] = max( ( nbh + rand(N,k)* .01)' ); 
    state = bg; % change in state to biggest group
    % mutation
    a = rand(N,1) < prob_mut;
    state(a) = ceil(rand(sum(a),1)*k); % assign random state
    
     if mod(t, draw_every)==0
            show_result(state, pos); 
     end 
    title(t); drawnow;    
end


function nbh = check_states(state, A, k)
    N = numel(state); % nr of agents to check 
    nbh = nan(N,k); 
    for a = 1:N
        i = A(a,:); 
        for s = 1:k  
            nbh(a, s) = sum(state(i)==s); 
        end
    end
end


function show_result(state, pos) 
    clf; 
    hold on;
    for s = 1:max(state) 
        i = state==s; 
        plot(pos(i,1), pos(i,2), '.', 'markersize',30); 
    end
    daspect([1,1,1]); xlim([0,1]); ylim([0,1]); 
    hold off
    drawnow;
end








