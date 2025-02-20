% Produce a partially observable automata, specified by the unobserveable events and the
% generalised replacement events

function automata_out = PartialObserve(g1, unobs_events, rep_event)
    automata_out = g1;
    original_events = g1.event_list;

    % Remove unoibs_events from event list
    automata_out.event_list = setdiff(original_events, unobs_events,"stable");
    % Add rep_events to event list
    automata_out.event_list = char(automata_out.event_list, rep_event);
    new_events = automata_out.event_list;
    % Iterate through transition matrix and replace unobs_event indecies with rep_event index in event list
    trans_list = g1.transition_list;
    for idx = 1:size(trans_list,1)
        curr_event = original_events(trans_list(idx,3));
        if ismember(curr_event, unobs_events)
            automata_out.transition_list(idx,3) = length(automata_out.event_list);
            % Because the relacement event is appended to the event list, its 
            % index is the same as the length of the list
        else
            event_index = find(new_events == curr_event);
            automata_out.transition_list(idx,3) = event_index;
        end
    end
end