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

% This is probably way too overcomplicated
function par_trans_list = parallel_transition(g1, g2, par_event_list, par_state_list)
    par_trans_list = [];
    % Get relevant information
    E_1 = g1.event_list;
    E_2 = g2.event_list;
    X_1 = g1.state_list;
    X_2 = g2.state_list;
    f_1 = g1.transition_list;
    f_2 = g2.transition_list;
    
    % Convert the transition lists to be easier to compare later (int -> string)
    char_f1 = [];
    for idxf = 1:(size(f_1,1))
        curr_trans = f_1(idxf,:);
        state1 = X_1(curr_trans(1),:);
        state2 = X_1(curr_trans(2),:);
        trans = E_1(curr_trans(3));
        char_trans = [state1, state2, ',', trans];
        char_f1 = [char_f1 ; char_trans];
    end

    char_f2 = [];
    for idxf = 1:(size(f_2,1))
        curr_trans = f_2(idxf,:);
        state1 = X_2(curr_trans(1),:);
        state2 = X_2(curr_trans(2),:);
        trans = E_2(curr_trans(3));
        char_trans = [state1, state2, ',', trans];
        char_f2 = [char_f2 ; char_trans];
    end
    char_f1 = string(char_f1);
    char_f2 = string(char_f2);


    % Get the event sets needed to determine the transition
    only1 = setdiff(E_1, E_2);  % E1/E2
    only2 = setdiff(E_2, E_1);  % E2/E2
    both = intersect(E_1, E_2); %E1nE2
    
    % For each pair of states in par_sates, check if transition is valid
    g1_regex = '(\w*,';
    g2_regex = ',\w*)';
    for i = 1:size(par_state_list,1)
        for j = 1:size(par_state_list,1)
            %(this loop is a brute force way of finding all possible pairs of states)
            % par_state = '(' g1.state ',' g2.state ')' 
            beg_state = par_state_list(i,:);
            end_state = par_state_list(j,:);

            beg_g1_state = char(regexp(beg_state,g1_regex,"match"));
            beg_g1_state = beg_g1_state(1,(2:(length(beg_g1_state)-1)));
            end_g1_state = char(regexp(end_state,g1_regex,"match"));
            end_g1_state = end_g1_state(1,(2:(length(end_g1_state)-1)));

            beg_g2_state = char(regexp(beg_state,g2_regex,"match"));
            beg_g2_state = beg_g2_state(1,(2:(length(beg_g2_state)-1)));
            end_g2_state = char(regexp(end_state,g2_regex,"match"));
            end_g2_state = end_g2_state(1,(2:(length(end_g2_state)-1)));

            dummy_g1_trans = [beg_g1_state end_g1_state];
            dummy_g2_trans = [beg_g2_state end_g2_state];

            % Now that we have our states, for each event in the prior 
            % sets, check if that event is dfeined as a transition for 
            % our curent pairs and that the conditons are satisfied

            % For events in only automata 1
            for idx_only1 = 1:length(only1)
                curr_event = only1(idx_only1,:);
                check1 = string([dummy_g1_trans ',' curr_event]);
                if ismember(check1,char_f1)
                    % Only valid if the state of the other automata doesn't change
                    if isequal(beg_g2_state, end_g2_state)
                      % If the transition is defined, add to par_trans_list the indexes
                        % of the states in the par_state_list and the index of the event in
                        % par_event_list
                        event_index = 0;
                        for event_index_idx = 1:(size(par_event_list,1))
                            if isequal(curr_event, par_event_list(event_index_idx,:))
                                event_index = event_index_idx;
                                break
                            end
                        end
                        par_trans_list = [par_trans_list; i,j,event_index];
                    end
                end
            end
            
            % For events in only automata 2
            for idx_only2 = 1:length(only2)
                curr_event = only2(idx_only2,:);
                check2 = string([dummy_g2_trans ',' curr_event]);
                if ismember(check2,char_f2)
                    if isequal(beg_g1_state, end_g1_state)
                        event_index = 0;
                        for event_index_idx = 1:(size(par_event_list,1))
                            if isequal(curr_event, par_event_list(event_index_idx,:))
                                event_index = event_index_idx;
                                break
                            end
                        end
                    par_trans_list = [par_trans_list; i,j,event_index];
                    end
                end
            end
            
            % For events in both automata 
            for idx_both = 1:length(both)
                curr_event = both(idx_both,:);
                check1 = string([dummy_g1_trans ',' curr_event]);
                check2 = string([dummy_g2_trans ',' curr_event]);
                if (ismember(check1,char_f1) & ismember(check2,char_f2))
                    event_index = 0;
                    for event_index_idx = 1:(size(par_event_list,1))
                        if isequal(curr_event, par_event_list(event_index_idx,:))
                            event_index = event_index_idx;
                            break
                        end
                    end
                    par_trans_list = [par_trans_list; i,j,event_index];
                end
            end
        end
    end
    %}
end

