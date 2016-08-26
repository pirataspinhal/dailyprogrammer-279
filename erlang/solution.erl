- module(solution).
- export([prettify/1,reflow/1,justify/1]).

% module entry point
%
prettify(A) -> lists:concat
               (justify(reflow(re:split(A, "\\s+", [{return, list}])))).

% reflow calculator function
%
reflow([]) -> [];
reflow([H|[]]) -> [H ++ "~n"];
reflow([H1,H2|T]) when (length(H1) + length(H2) + 1 =< 40) ->
        reflow([H1 ++ " " ++ H2|T]);
reflow([H1,H2|T]) -> [H1 ++ "~n"] ++ reflow([H2|T]).

% justify string sizes to close 40
%
justify([]) -> [];
justify([H|[]]) -> [H];
justify([H|T]) ->
        case (length(H) + string:words(H) - 1 =< 40) of
                true -> justify([re:replace(H, " ", "  ", [global, {return, list}])|T]);
                false -> [H] ++ justify(T)
        end.
