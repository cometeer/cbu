-module(cbu_handler).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-export([ init/3
        , rest_init/2
        , allowed_methods/2
        , content_types_provided/2
        , to_json/2
        ]).

init(_Transport, _Req, _) ->
  {upgrade, protocol, cowboy_rest}.

rest_init(Req, _) ->
  State = #{},
  {ok, Req, State}.

allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
  {[{{<<"application">>, <<"json">>, '*'}, to_json}], Req, State}.

to_json(Req, State) ->
  Response = #{ title => <<"Hello world">>},
  {jsx:encode(Response), Req, State}.

-ifdef(TEST).

do_test() ->
  ok.

-endif.
