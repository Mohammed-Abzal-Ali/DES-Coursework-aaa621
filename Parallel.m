% Produce the parallel composition of two automata

function automata_out = Parallel(g1, g2)
    automata_out = automata;
    % Cartesian product func
    % Make Automata obj

    % Event list is the union of the events in both automata
    automata_out.event_list = union(g1.event_list, g2.event_list, "stable");
    % State list is the cartesian product of the states in both automata
    automata_out.state_list = CartProd(g1.state_list, g2.state_list);
    % Transition list defined in Lect 2, Slide 7 (too lazy to write it)
    automata_out.transition_list = parallel_transition(g1, g2, automata_out.event_list, automata_out.state_list);
    % Intial state is the cartesian product of the initial states in both automata
    automata_out.initial_state = CartProd(g1.initial_state, g2.initial_state);
end

function par_trans_list = parallel_transition(g1, g2, par_event_list, par_state_list)
    E_1 = g1.event_list;
    E_2 = g2.event_list;
    X_1 = g1.state_list;
    X_2 = g2.state_list;
    f_1 = g1.transition_list;
    f_2 = g2.transition_list;

    % Get the event sets needed to determine the transition
    only1 = setdiff(E_1, E_2);  % E1/E2
    only2 = setdiff(E_2, E_1);  % E2/E1
    %both = intersect(E_1, E_2); %E1nE2

    % For each event in the sets: check the original transitions and see if they are defined
    % If defined in both, keep in f_1 and f_2, else move to seperate array;
    only1_trans = [];
    only2_trans = [];
    not_both_f1 = [];
    not_both_f2 = [];

    for idx_1 = 1:(size(f_1,1))
        cur_trans = E_1(f_1(idx_1,3));
        if ismember(cur_trans, only1)
            only1_trans = [only1_trans; f_1(idx_1,:)];
            not_both_f1 = [not_both_f1 idx_1]; % Track which indexes to remove
        end
    end
    for idx_2 = 1:(size(f_2,1))
        cur_trans = E_2(f_2(idx_2,3));
        if ismember(cur_trans, only2)
            only2_trans = [only2_trans; f_2(idx_2,:)];
            not_both_f2 = [not_both_f2 idx_2]; % Track which indexes to remove
        end
    end
    for idx_f1 = (length(not_both_f1)):-1:1
        f_1(not_both_f1(idx_f1),:) = [];
    end
    for idx_f2 = (length(not_both_f2)):-1:1
        f_2(not_both_f2(idx_f2),:) = [];
    end
    
    % For each of the transitions lists, find the relevant states in par_states 
    % Construct the par_trans_list by assigning events to it

    par_trans_list = [];

end

