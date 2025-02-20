% Define automata class
% Properties as defined in the CW questions pdf

% No set sizes for event/state list as number chars for each event/state may vary e.g. E1 = [r1, r2, ... , r10]
% r10 is 3 characters, thus would not satisft (2,:)

% As I understand: T1 = [[begining_state, destination_state, transition_event];...]
% NOTE: The CW pdf says to declare T1 as 3xT but the example array is actually Tx3 (3 columns, T rows)?     

classdef automata
    properties
          event_list char = [];             % E1
          state_list char = [];             % X1
          transition_list (:,3) int32 = []; % T1
          initial_state char;               % x_0
    end
    methods
        function display_all(a)
            disp("Automata Events")
            disp(a.event_list)
            disp(newline + "Automata States")
            disp(a.state_list)
            disp(newline + "Transition Table")
            disp(a.transition_list)
            disp(newline + "Initial State:")
            disp(a.initial_state)
        end
    end    
end