% Takes a Partailly observed automata and constructs a corresponding
% observer of the automaton

function observer = Construct_Observer(g)
    observer = automata;
    observer.event_list = g.event_list;
    observer.initial_state = char();

    % unfinished, did not at all understand the coding hint
end