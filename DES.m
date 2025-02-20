% MATLAB File for aaa621's DES Coursework 
% Using the recommeded represenation as the CW spec pdf
% Replacing '1' with the automata letter: for G_A: E1 -> EA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% See automata.m for automata class definition

% G_M Representation
G_M = automata;
G_M.event_list = char('n', 's', 'e', 'w'); % Event List
G_M.state_list = char('r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7'); % State List    
% The no. of transitions T = 2 * no. of walls shared between rooms => 2 * 6 = 12
G_M.transition_list = [1,2,3; 2,1,4; ... % n = 1, s = 2, e = 3, w = 4
                       2,3,2; 3,2,1; ...
                       3,4,2; 4,3,1; ...
                       3,7,3; 7,3,4; ...
                       4,5,2; 5,4,1; ...
                       5,6,4; 6,5,3];
% NOTE: Was unclear on whether to declare initial state as char or integer
G_M.initial_state = 'r1'; % Assumed the bot starts in Room 1

% G_R Representation
G_R = automata;
G_R.event_list = char('n', 's', 'e', 'w','r'); % Event List
G_R.state_list = char('fn','fe','fs','fw'); % State List (e.g. fn: Facing North)  
% T = 2 * no. of states; 1 for rotation and 1 for movement = 8
G_R.transition_list = [1,2,5; 1,1,1; ...
                       2,3,5; 2,2,2; ...
                       3,4,5; 3,3,3; ...
                       4,1,5; 4,4,4];
G_R.initial_state = 'fn'; % Assumed the bot starts facing north

G_MparR = Parallel(G_M, G_R);

%G_MparR.display_all

unobs = char('n', 's', 'e', 'w');
rep = char('m');
G_N = PartialObserve(G_MparR,unobs,rep);

G_N.display_all



unobs = char('n', 's', 'e', 'w');
rep = char('m');

%{
G_M.display_all
G_R.display_all
G_MparR.display_all
%}

