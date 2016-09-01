- module(solution).
- export([message/0,reflow/1]).

%% oh look, macros
- define(Split(List,Arg),re:split(List,Arg,[{return,list}])).
- define(LLLen(Line),length(lists:last(?Split(Line, "\n")))).

message() -> "In the beginning God created the heavens\n
and the earth. Now the earth was\n formless and empty,\n
darkness was over the surface of the deep, and the\n
Spirit of God was hovering over the waters.\n
And God said, \"Let there be light,\" and\n
there was light. God saw that the light\n
was good, and he separated the light\n
from the darkness. God called the light\n
\"day,\" and the darkness he called\n
\"night.\" And there was evening, and\n
there was morning - the first day.\n".

%% fold: O(n)
reflow(Str) ->
        [H|T] = ?Split(Str,"\\s+"),
        lists:foldl(fun(Word, Acc) ->
                            case (length(Word) + ?LLLen(Acc) < 40) of
                                    true  -> Acc ++ " "  ++ Word;
                                    _     -> Acc ++ "\n" ++ Word
                            end
                    end, H, T) ++ "\n".
