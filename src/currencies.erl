-module(currencies).
-import(jsx, [decode/1]).
-export([start/0]).


start() -> 
	URL = "http://openexchangerates.org/api/latest.json?app_id=2bcca613e8034f2cbd416a027258d599",
	inets:start(),
	{ok, Req} = httpc:request(URL),
	{A, B, C} = Req,
	D = list_to_binary(C),
	E = jsx:decode(D),
	Rates = proplists:get_value(<<"rates">>, E),
	EUR = proplists:get_value(<<"EUR">>, Rates),
	io:format("~p~n",[EUR]),
	init:stop().
