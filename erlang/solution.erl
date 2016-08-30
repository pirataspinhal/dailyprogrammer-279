- module(solution).
- export([prettify/1,reflow/1,justify/1]).

%% oh look, a macro
%%
- define(Replace(L,Tgt,Arg),re:replace(L,Tgt,Arg,[global,{return,list}])).

%% call dis function
%%
prettify([]) -> [];
prettify(Str) ->
        lists:concat(justify(reflow(re:split(Str, "\\s+", [{return, list}])))).

%%      i: list of chars
%%      o: list of lines
%%
reflow([H|[]]) -> [H ++ "~n"];
reflow([H1,H2|T]) when (length(H1) + length(H2) + 1 =< 40) ->
        reflow([H1 ++ " " ++ H2|T]);
reflow([H1,H2|T]) -> [H1 ++ "~n"] ++ reflow([H2|T]).

%%      i: list of lines
%%      o: list of lines
%%
justify([H|[]]) -> [H];
justify([H|T]) ->
        case (length(H) + string:words(H) - 1 =< 40) of
                true -> justify([?Replace(H, " ", "  ")|T]); %% use ? to expand
                false -> [H] ++ justify(T)
        end.
