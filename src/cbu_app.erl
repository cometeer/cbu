%%%-------------------------------------------------------------------
%% @doc cbu public API
%% @end
%%%-------------------------------------------------------------------

-module(cbu_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-define(
   ROUTES,
   [
       { "/sample", cbu_handler, []}
   ]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([{'_', ?ROUTES}]),
    cowboy:start_http(generic_http_listener,
                    100,
                    [{port, 8080}],
                    [{env, [{dispatch, Dispatch}]}]),
    erlang:display("start ran!"),
    cbu_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

